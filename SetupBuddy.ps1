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

# 7-zip Extraction Logic - Bundled



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