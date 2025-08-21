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

# 7-Zip Detection Function
function Get-7ZipPath {
    $defaultPaths = @(
        "$PSScriptRoot\Tools\7z.exe",
        "$env:ProgramFiles\7-Zip\7z.exe",
        "$env:ProgramFiles(x86)\7-Zip\7z.exe",
        "D:\Program Files\7-Zip\7z.exe",
        "D:\Program Files (x86)\7-Zip\7z.exe"
    )

    foreach ($path in $defaultPaths) {
        if (Test-Path $path) { return $path }
    }

    Write-Host "`n7-Zip not found in default locations."
    $manualPath = Read-Host "Enter your 7z.exe path manually or press Enter to download"
    if ($manualPath -and (Test-Path $manualPath)) {
        return $manualPath
    }

    Write-Host "`nYou can download 7-Zip from the official site:"
    Write-Host "https://www.7-zip.org/download.html`n"
    Start-Process "https://www.7-zip.org/download.html"
    Pause
    exit
}

# Resolve 7-Zip path
$sevenZipPath = Get-7ZipPath

# Extraction Logic
$rarFiles = Get-ChildItem -Path $targetFolder -Filter *.rar

foreach ($file in $rarFiles) {
    $fileName = $file.Name

    if ($fileName -match "\.part0*1\.rar$" -or ($fileName -notmatch "\.part\d+\.rar$")) {
        Write-Host "Extracting $fileName..."
        $arguments = @("x", "`"$($file.FullName)`"", "-o`"$targetFolder`"", "-y")
        Start-Process -FilePath $sevenZipPath -ArgumentList $arguments -Wait
    }
    else {
        Write-Host "Skipping $fileName (handled by part1)"
    }
}

# Verify BIN files before installation.bat

$verifyBat = Join-Path $targetFolder "Verify BIN files before install.bat"
$md5Folder = Join-Path $targetFolder "MD5"
$quickSFV = Join-Path $md5Folder "QuickSFV.exe"
$md5File  = Join-Path $md5Folder "fitgirl-bins.md5"

Write-Host "`nSuccessful Extraction"
Write-Host "Now, let's get started with the verification..."

if (Test-Path $verifyBat) {
    Start-Process $verifyBat -NoNewWindow -Wait
}
elseif (Test-Path $quickSFV -and (Test-Path $md5File)) {
    Start-Process -FilePath $quickSFV -ArgumentList "`"$md5File`"" -NoNewWindow
}
else {
    Write-Host "No verification method found. Please check your setup folder."
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