# 🚀 Universal Development Engine (UDE)

![Build Status](https://img.shields.io/badge/build-passing-brightgreen)
![Platform](https://img.shields.io/badge/platform-Linux%20%7C%20Windows-lightgrey)
![Bash](https://img.shields.io/badge/Shell_Script-121011?style=for-the-badge&logo=gnu-bash&logoColor=white)
![PowerShell](https://img.shields.io/badge/PowerShell-%235391FE.svg?style=for-the-badge&logo=powershell&logoColor=white)
![.NET 8](https://img.shields.io/badge/.NET_8-512BD4?style=for-the-badge&logo=dotnet&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge&logo=amazon-aws&logoColor=white)

**UDE** is an automated environment provisioning engine designed to eliminate "Configuration Drift." It streamlines the setup of enterprise-grade development environments across **Linux (Fedora/KDE Neon)** and **Windows (PowerShell/WSL2)**.

## 🛠 Strategic Purpose
In high-velocity engineering teams, manual environment setup is a bottleneck. UDE reduces a 2-hour manual provisioning process into a single-command execution. It ensures that the **.NET 8 SDK**, **AWS CLI**, and **Database Drivers** are configured identically across all workstations, reducing "it works on my machine" bugs.

## ✨ Core Functionalities
* **Distro-Agnostic Abstraction:** Dynamically detects and utilizes `dnf`, `apt`, or `pacman` based on the host environment.
* **Idempotent Execution:** Scripts safely check for existing binaries before attempting installation to prevent system bloat.
* **Full-Stack Provisioning:** Automates the installation of .NET 8, Node.js (v22), PHP 8.4, and SQL engines (MySQL/PostgreSQL).
* **Cloud-Native Ready:** Configures AWS CLI and Docker environments for immediate serverless/containerized development.

## 🏗 System Architecture
The engine follows a modular logic flow to ensure system stability:



1.  **Host Detection:** Identifies Kernel, DE (KDE/Gnome), and Package Manager.
2.  **Dependency Mapping:** Scans `$PATH` for existing tool versions to avoid redundant installs.
3.  **Cross-Platform Deployment:** Securely fetches binaries and configures environment aliases.
4.  **Verification:** Runs post-install integrity checks (e.g., `dotnet --version`).

## 🚀 Usage

### Linux (Fedora / KDE Neon / Ubuntu / WSL2)
```bash
# Clone and execute
git clone [https://github.com/JuD990/universal-dev-engine.git](https://github.com/JudeAdolfo/universal-dev-engine.git)
cd universal-dev-engine
chmod +x setup-linux.sh
./setup-linux.sh
```

### Windows (PowerShell)

```powershell
# Run as Administrator
Set-ExecutionPolicy Bypass -Scope Process -Force
./setup-windows.ps1
```
