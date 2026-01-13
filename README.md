🚀 Universal Development Engine (UDE)
UDE is an automated environment provisioning engine designed to eliminate "Configuration Drift." It streamlines the setup of enterprise-grade development environments across Linux (Fedora/KDE Neon) and Windows (PowerShell/WSL2).

🛠 Strategic Purpose
In high-velocity engineering teams, manual environment setup is a bottleneck. UDE reduces a 2-hour manual provisioning process into a single-command execution. It ensures that the .NET 8 SDK, AWS CLI, and Database Drivers are configured identically across all workstations, reducing "it works on my machine" bugs.

✨ Core Functionalities
Idempotent Execution: Scripts are designed to be run multiple times safely, checking for existing binaries before attempting installation.

Cloud-Native Provisioning: Automates AWS CLI installation and handles environment variable mapping for local cloud development.

Backend Stack Integration: One-click setup for the .NET 8 SDK, PHP/Laravel dependencies, and SQL relational drivers.

Security Hardening: Implemented logic to manage SSH permissions and IAM credential directories according to least-privilege principles.

🏗 System Architecture
The engine follows a modular logic flow to ensure stability:

Host Detection: Dynamically identifies the Kernel and active Package Manager (dnf, apt, or winget).

Dependency Mapping: Scans the system $PATH for existing tool versions to prevent version conflicts.

Automated Deployment: Securely fetches binaries from official mirrors and configures environment aliases.

Verification: Performs post-install integrity checks on all critical SDKs.

🚀 Usage
Linux (Fedora / KDE Neon / WSL2)
# Clone and execute
git clone https://github.com/JudeAdolfo/universal-dev-engine.git
cd universal-dev-engine
chmod +x setup-linux.sh
./setup-linux.sh

Windows (PowerShell)
# Run as Administrator
Set-ExecutionPolicy Bypass -Scope Process -Force
./setup-windows.ps1

📅 Development Roadmap
[x] Phase 1: Core Bash provisioning engine for Fedora/RPM systems.
[x] Phase 2: PowerShell winget integration for Windows/Enterprise environments.
[ ] Phase 3: Automated AWS IAM profile switcher and SSO integration.
[ ] Phase 4: Docker-compose templates for local microservice orchestration.

Author: Jude Christian Adolfo
Specialization: Backend Engineering | Cloud Architecture | Automation
