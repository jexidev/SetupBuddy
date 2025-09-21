# SetupBuddy

**SetupBuddy** is a PowerShell script designed to deal with the chaos of multi-rar unpacking after using Direct Downloads. If you find yourself scratching your head looking at a bunch of .rar files wondering where to start, this is for you. 

## What It Does

SetupBuddy handles:

- **Automated Extraction:** Finds multi-part archives (RAR/ZIP/7z) in a single folder, and extracts them. 
- **Tool-Included:** Comes with a pre-packaged copy of 7-Zip, so you don't need to install anything else. 
- **Smart Launching:** Automatically runs "Verify BIN before install.bat", before prompting to launch setup.exe or not.
- **Cleans Your Setup Folder:** After successful BIN verification, all .rar parts are deleted. 
- **User Guidance:** Offers clear prompts and fallback options if a file is missing. 

## Requirements

* **Windows 10/11**
* **PowerShell 5+**

SetupBuddy is frictionless, which is why the necessary tools are included, meaning you're not left downloading external requirements. 

## How to Run (Testing Version)

1. **Download:** Grab the "Tools" folder and "SetupBuddy.ps1"

2. **Running:** First, try right-clicking the .ps1 file and hitting "run in PowerShell". 

Alternatively, If your execution policy blocks scripts:
    ```powershell
    powershell -ExecutionPolicy Bypass -File "SetupBuddy.ps1"
    ```
    Or elevate with:
    ```powershell
    Start-Process powershell -Verb RunAs -ArgumentList '-ExecutionPolicy Bypass -File "SetupBuddy.ps1"'
    ```

**Created by JexiDev**