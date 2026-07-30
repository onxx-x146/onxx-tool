# 🚀 onxx-Tool  
### *Your Personal Hacking Toolbox – Interactive Installer* 
![install](https://files.catbox.moe/sp3yja.png)

**Created by Onxx-x143*
### 🔗Feedback
[![Instagram](https://img.shields.io/badge/Instagram-Follow%20Now-E4405F?style=for-the-badge&logo=instagram&logoColor=white)](https://www.instagram.com/_insrnx_)

[![YouTube](https://img.shields.io/badge/YouTube-Subscribe%20Now-FF0000?style=for-the-badge&logo=youtube&logoColor=white)](https://youtube.com/@onxx-x145)

[![Telegram](https://img.shields.io/badge/Telegram-Join%20Now-2CA5E0?style=for-the-badge&logo=telegram&logoColor=white)](https://t.me/harijadhavai)

---

![Version](https://img.shields.io/badge/version-3.0-brightgreen)  
![Termux](https://img.shields.io/badge/Termux-Compatible-blue)  
![Tools](https://img.shields.io/badge/500+-Tools-orange)  
![License](https://img.shields.io/badge/License-MIT-yellow)  

---

## 📌 Overview

**GATE‑UP TOOLS** is a powerful, interactive installer for Termux (and Linux) that lets you choose from **500+ hacking/pen‑testing tools** – with a simple **number‑based menu**.  
Just type the numbers of the tools you want (e.g., `1 2 3 5 2`) and the script installs only those – saving time and bandwidth.  

- 🎨 **Colorful, eye‑candy banner** that auto‑clears after each step.  
- 📦 **Scalable design** – add/remove tools easily via `tools.txt`.  
- 🔗 **Auto‑opens your GATE‑UP dashboard** in Chrome after installation.  
- 🛠️ **Error logging** – any failures are saved to `errors.txt` for debugging.  
- ⚡ **Global command** – after installation, just type `gateup` to rerun the installer anytime.
![install](https://files.catbox.moe/anvfbd.jpg)
---
## Termux install 🥷🏻
```
apt update && apt upgrade -y 
git clone https://github.com/onxx-x143/onxx-tool.git
cd onxx-tool
chmod +x main.sh
bash main.sh
```
## ✨ Features
| Feature | Description |
|---------|-------------|
| **Interactive Selection** | Choose tools by typing numbers (e.g., `1 5 2 3`) or install all with `all`. |
| **500+ Tools Ready** | The `tools.txt` file holds all tool names and their install commands – easy to maintain. |
| **Auto‑Clear & Beautiful UI** | Each step clears the screen and shows a vibrant banner. |
| **Dependency Handling** | Automatically installs required packages (`git`, `python`, etc.). |
| **Error Resilient** | If a tool fails to install, the script continues and logs the error. |
| **Post‑Install Actions** | Copies the script to `$PREFIX/bin/gateup` and opens your GATE‑UP URL. |

---

## 📋 Requirements

- **Termux** (Android) or any **Linux** distribution with `bash`.  
- Internet connection to clone repositories / download packages.  
- **Storage permission** (if on Android) – run `termux-setup-storage` once.

---

## 🔧 Installation

1. **Clone the repository** (or downloa
