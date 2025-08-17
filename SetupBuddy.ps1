# intro
Write-Host "`nWelcome to SetupBuddy - a JexiDev creation!"
Write-Host "Taking you from chaos to install in a matter of clicks.`n"
Write-Host "Step 1: Make sure all .rar/part files for your downloaded game are in the same folder.`n"


do {
    $targetFolder = Read-Host "Paste the full path to your game's setup folder"
    $targetFolder = $targetFolder.Trim() -replace '^"|"$', ''
    if (!(Test-Path $targetFolder)) {
        Write-Host "Folder not found. Please double-check and try again.`n"
    }
} until (Test-Path $targetFolder)

Write-Host "Folder found. Commencing extraction process...`n"

# WinRAR Check and Execution
function Get-WinRARPath {
    $defaultPaths = @(
        "$env:ProgramFiles\WinRAR\WinRAR.exe",
        "$env:ProgramFiles(x86)\WinRAR\WinRAR.exe",
        "D:\Program Files\WinRAR\WinRAR.exe",
        "D:\Program Files (x86)\WinRAR\WinRAR.exe"
    )

    foreach ($path in $defaultPaths) {
        if (Test-Path $path) { return $path }
    }

    # Prompt user for manual path
    Write-Host "`nWinRAR not found in default locations."
    $manualPath = Read-Host "Enter your WinRAR.exe path manually or press Enter to download"
    if ($manualPath -and (Test-Path $manualPath)) {
        return $manualPath
    }

    # Offer download
    Write-Host "`nYou can download WinRAR from the official site:"
    Write-Host "https://www.rarlab.com/download.htm`n"
    Start-Process "https://www.rarlab.com/download.htm"
    Pause
    exit
}

function Get-WinRARVersion($exePath) {
    try {
        $versionInfo = (Get-Item $exePath).VersionInfo
        return $versionInfo.ProductVersion
    } catch {
        return $null
    }
}

# Version Detection - Main Logic
$winRARPath = Get-WinRARPath
$winRARVersion = Get-WinRARVersion $winRARPath

if (-not $winRARVersion) {
    Write-Host "Could not determine WinRAR version. Please ensure it's up to date."
    Pause
    exit
}

# Compare version
$requiredVersion = [Version]"7.13"
$currentVersion = [Version]$winRARVersion

if ($currentVersion -lt $requiredVersion) {
    Write-Host "`nYour WinRAR version ($winRARVersion) is outdated and may be vulnerable."
    Write-Host "Please update to version 7.13 or later:"
    Write-Host "https://www.rarlab.com/download.htm`n"
    Start-Process "https://www.rarlab.com/download.htm"
    Pause
    exit
}

Write-Host "`nWinRAR version $winRARVersion is up to date."


# Add in Extracting... to run every X amount of seconds until process complete

$rarFiles = Get-ChildItem -Path $targetFolder -Filter *.rar

foreach ($file in $rarFiles) {
    $fileName = $file.Name

    if ($fileName -match "\.part0*1\.rar$" -or ($fileName -notmatch "\.part\d+\.rar$")) {
        Write-Host "Extracting $fileName..."
        $arguments = @("x", "`"$($file.FullName)`"", "`"$targetFolder`"")
        Start-Process -FilePath $winRARPath -ArgumentList $arguments -Wait
    }
    else {
        Write-Host "Skipping $fileName (handled by part1)"
    }
}

# Handling the verification process
Write-Host "Successful Extraction"
Write-Host "Now, lets get started with the verification`n"

$verifyBat = Join-Path $targetFolder "Verify BIN files before installation.bat"

Write-Host "`nSuccessful Extraction"
Write-Host "Now, lets get started with the verification..."

if (Test-Path $verifyBat) {
    Start-Process $verifyBat -NoNewWindow -Wait
} else {
    Write-Host "Verification script not found. Please check your setup folder."
    exit
}

# Confirm verification results with user and launch setup.exe if successful

Write-Host "`nQuickSFV launched successfully"
Write-Host "Once you've confirmed all BIN files are verified..."
Write-Host "Press Y to launch setup.exe or N to exit."

do {
    $userInput = Read-Host "Your choice (Y/N)"
} while ($userInput -notmatch '^[YyNn]$')

if ($userInput -match '^[Yy]$') {
    $setupExe = Join-Path $targetFolder "setup.exe"
    if (Test-Path $setupExe) {
        Write-Host "`nLaunching setup.exe"
        Start-Process $setupExe
    } else {
        Write-Host "setup.exe not found. Please check your files."
    }
} else {
    Write-Host "Setup aborted by user. You can run setup.exe munaually later if needed."
    exit
}