# 🧙‍♂️ SetupBuddy - Your Install-Sidekick

**SetupBuddy** is a powerful PowerShell script built to streamline the chaos of game setups, file management, and post-download confusion. Tired of wrangling fragmented archives and hunting for setup files? SetupBuddy is the evolved form of **BinSnatcher**, now with direct extraction, verification and automated setup launching.

---

## 🚀 What It Does

SetupBuddy handles:

- ✅  **Automated Extraction:** Finds and extracts multi-part archives (RAR/ZIP/7z) in a single folder.
- 📦  **Tool-Included:** Comes with a pre-packaged copy of 7-Zip, so you don't need to install anything else.
- 🧠  **Smart Launching:** Automatically finds and runs `setup.exe` with basic error handling.
- 🔍  **User Guidance:** Provides clear prompts and fallback options if a file is missing.

---

### 🛠️ Requirements

* **Windows 10/11**
* **PowerShell 5+**

SetupBuddy is designed to be as simple as possible. It includes the necessary tools, so there are no other external requirements. Just download and run.

---

## 🧪 How to Run (Trial Mode)

1.  **Download:** Grab the latest version from this repository.
2.  **Unzip:** Extract the contents to your desired location.
3.  **Run:** Open a PowerShell terminal and navigate to the extracted folder. Run the script with one of these commands:

    If your execution policy blocks scripts:
    ```powershell
    powershell -ExecutionPolicy Bypass -File "SetupBuddy.ps1"
    ```
    Or elevate with:
    ```powershell
    Start-Process powershell -Verb RunAs -ArgumentList '-ExecutionPolicy Bypass -File "SetupBuddy.ps1"'
    ```

---

## 💡 Why SetupBuddy Exists

SetupBuddy was built to simplify the install process and empower users with tools that just work. It's designed for:

- 🎮  **Gamers** who want clean, hassle-free installs.
- 🛠️  **Modders** who support others and maintain setups.
- 🌐  **Communities** that value clarity, consistency, and ease of use.

---

## 🧭 What's Coming Next

SetupBuddy is still evolving. Here's what's on the roadmap:

- 🔐  **Discord-integrated support flow:** Safe, filtered contact and ticketing
- 🧱  **Modular install profiles:** Tailored setups for different games and tools
- 💬  **Interactive prompts:** Fallback options and guided decisions
- 🧼  **Setup folder hygiene checks:** Smarter file placement and cleanup

---

## 🤝 Support & Feedback

SetupBuddy is a work in progress — your feedback helps shape it.

- ☕ [Support me on Ko-fi](https://ko-fi.com/jexidev)  
- 🧑‍💻 [Explore my GitHub projects](https://github.com/JexiDev)  
- 💬 Reach out via Discord (filtered contact channel coming soon)

## 🧠 Credits
Created by JexiDev

Built with empathy, speed, and a touch of chaos.
