# 🚀 Universal Development Engine (UDE)

**UDE** is a cross-platform environment provisioning tool designed to eliminate configuration drift. It automates the setup of enterprise-grade development environments across **Linux (Fedora/WSL2)** and **Windows (PowerShell)**.



## 🛠 Strategic Purpose
In high-velocity engineering teams, manual environment setup is a bottleneck. UDE reduces a 2-hour provisioning process into a single-command execution, ensuring that .NET 8, AWS CLI, and critical security tools are configured identically across all workstations.

## ✨ Core Functionalities
* **Cloud-Ready Provisioning:** Automates AWS CLI installation and environment variable mapping.
* **Backend Stack Integration:** One-click setup for .NET 8 SDK, PHP/Laravel dependencies, and SQL drivers.
* **Security Hardening:** Scripts include logic to manage SSH permissions and IAM credential directories securely.
* **Cross-Platform Vision:** Modular architecture with native Bash scripts for Linux and a planned PowerShell module for Windows/Active Directory environments.

## 🏗 System Architecture
1. **Host Detection:** Identifies Kernel and Package Manager (DNF/APT/Winget).
2. **Dependency Resolution:** Scans for existing binaries to prevent version conflicts.
3. **Automated Deployment:** Fetches binaries from official mirrors and configures system paths.

## 🚀 Usage
### Linux (Fedora/WSL2)
```bash
chmod +x setup-linux.sh
./setup-linux.sh
