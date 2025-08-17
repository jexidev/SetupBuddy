# 🧙‍♂️ SetupBuddy (WIP)

**SetupBuddy** is your install-sidekick, built to streamline the chaos of game mod setups, bin file wrangling, and post-download confusion. Born from the humble frustrations of _"great, now I need to copy all these bin files to the setup folder"_, it’s the evolved form of **BinSnatcher** — now with direct download support, extraction, and setup launching.

---

## 🚀 What It Does

SetupBuddy handles:

- ✅ **Direct download** of required files (bins, zips, etc.)
- 📦 **Extraction** of archives (RAR/ZIP/7z) with WinRAR integration
- 🧩 **Folder hygiene** — auto-creates setup folders, verifies contents
- 🧠 **Smart launching** — runs `setup.exe` with basic error handling
- 🔍 **User prompts** — fallback options if something’s missing

---

## 🛠️ Requirements

- Windows 10/11  
- PowerShell 5+  
- [WinRAR](https://www.rarlab.com/download.htm) installed and up to date (v7.13+ recommended)

If WinRAR isn’t found, SetupBuddy will prompt you to install or manually locate it.

---

## 🧪 How to Run (Trial Mode)

If your execution policy blocks scripts:

powershell -ExecutionPolicy Bypass -File "SetupBuddy.ps1"

Or elevate with:

Start-Process powershell -Verb RunAs -ArgumentList '-ExecutionPolicy Bypass -File "SetupBuddy.ps1"'

---

## 💡 Why SetupBuddy Exists

SetupBuddy was built to simplify the install process and empower users with tools that just work.

It’s designed for:

- 🎮 **Gamers** who want clean, hassle-free installs  
- 🛠️ **Modders** who support others and maintain setups  
- 🌐 **Communities** that value clarity, consistency, and ease of use

---

## 🧭 What's Coming Next

SetupBuddy is still evolving. Here's what's on the roadmap:

- 🔐 **Discord-integrated support flow** — safe, filtered contact and ticketing  
- 🧱 **Modular install profiles** — tailored setups for different games and tools  
- 💬 **Interactive prompts** — fallback options and guided decisions  
- 🧼 **Setup folder hygiene checks** — smarter file placement and cleanup

---

## 🤝 Support & Feedback

SetupBuddy is a work in progress — your feedback helps shape it.

- ☕ [Support me on Ko-fi](https://ko-fi.com/jexidev)  
- 🧑‍💻 [Explore my GitHub projects](https://github.com/JexiDev)  
- 💬 Reach out via Discord (filtered contact channel coming soon)
