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
* **Idempotent Execution:** Scripts safely check for existing binaries before attempting installation to prevent system bloat.
* **Cloud-Native Provisioning:** Automates AWS CLI installation and handles environment variable mapping for local cloud development.
* **Backend Stack Integration:** One-click setup for the .NET 8 SDK, PHP/Laravel dependencies, and SQL relational drivers.
* **Security Hardening:** Implements logic to manage SSH permissions and IAM credential directories according to least-privilege principles.

## 🏗 System Architecture
The engine follows a modular logic flow to ensure system stability:



1.  **Host Detection:** Dynamically identifies the Kernel and active Package Manager (`dnf`, `apt`, or `winget`).
2.  **Dependency Mapping:** Scans the system `$PATH` for existing tool versions to prevent conflicts.
3.  **Automated Deployment:** Securely fetches binaries from official mirrors and configures system environment variables.
4.  **Verification:** Performs post-install integrity checks on all critical SDKs.

## 🚀 Usage

### Linux (Fedora / KDE Neon / WSL2)
```bash
# Clone and execute
git clone [https://github.com/JudeAdolfo/universal-dev-engine.git](https://github.com/JudeAdolfo/universal-dev-engine.git)
cd universal-dev-engine
chmod +x setup-linux.sh
./setup-linux.sh

### Windows (PowerShell)
# Run as Administrator
Set-ExecutionPolicy Bypass -Scope Process -Force
./setup-windows.ps1

⚙️ Managed Dependencies
Tool,Purpose,Version
.NET SDK,Enterprise Backend Dev,8.0+
AWS CLI,Cloud Infrastructure Mgmt,Latest
Git,Version Control,Latest
Docker,Containerization (Planned),-

📅 Development Roadmap
[x] Phase 1: Core Bash provisioning engine for Fedora/RPM systems.
[x] Phase 2: PowerShell winget integration for Windows/Enterprise environments.
[ ] Phase 3: Automated AWS IAM profile switcher and SSO integration.
[ ] Phase 4: Docker-compose templates for local microservice orchestration.

Author: Jude Christian Adolfo
Specialization: Backend Engineering | Cloud Architecture | Automation License: MIT
