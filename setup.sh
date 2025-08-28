#!/bin/bash

# Global password variable
SUDO_PASSWORD=""
PASSWORD_VALIDATED=false

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to prompt and validate sudo password
validate_sudo_password() {
    local max_attempts=3
    local attempt=1
    
    echo -e "${YELLOW}This script requires sudo privileges.${NC}"
    
    while [ $attempt -le $max_attempts ]; do
        echo -n "Enter sudo password (attempt $attempt/$max_attempts): "
        read -s SUDO_PASSWORD
        echo  # New line after hidden input
        
        # Test the password
        if echo "$SUDO_PASSWORD" | sudo -S true 2>/dev/null; then
            echo -e "${GREEN}✓ Password validated successfully!${NC}"
            PASSWORD_VALIDATED=true
            return 0
        else
            echo -e "${RED}✗ Incorrect password.${NC}"
            ((attempt++))
            SUDO_PASSWORD=""  # Clear wrong password
        fi
    done
    
    echo -e "${RED}Maximum attempts reached. Exiting.${NC}"
    exit 1
}

echo -e "\nUpdating and upgrading system...\n"
sudo apt update && sudo apt upgrade -y

# Install essential tools
echo -e "\nInstalling Essential Tools...\n"
sudo apt install -y build-essential git curl wget unzip zip htop

# Install NVM (Node Version Manager) if not installed
if ! command -v nvm &> /dev/null && [ ! -d "$HOME/.nvm" ]; then
    echo -e "\nInstalling NVM...\n"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
else
    echo "\nNVM is already installed. Skipping...\n"
fi

# Set up environment
echo -e "\nSetting up NVM environment...\n"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Install Node.js if not installed
if ! command -v node &> /dev/null || ! node -v | grep -q "v22"; then
    echo -e "\nInstalling Node.js...\n"
    # in lieu of restarting the shell
    \. "$HOME/.nvm/nvm.sh"
    nvm install 22
    echo -e "\Node.js v22 successfully Installed.\n"
else
    echo -e "\nNode.js v22 is already installed. Skipping...\n"
fi

echo
nvm current && node -v && npm -v
echo

if grep -Rq "^deb .*ondrej/php" /etc/apt/sources.list.d/; then
    echo -e "\nPHP PPA already added.\n"
else
    echo -e "\nAdding PHP PPA...\n"
    sudo add-apt-repository -y ppa:ondrej/php
    echo -e "\nPHP PPA successfully added.\n"
fi

# Install PHP 8.4 if not already installed
if ! php -v | grep -q "8.4"; then
    echo -e "\nInstalling PHP 8.4 with extensions...\n"
    sudo apt install php8.4 php8.4-cli php8.4-fpm php8.4-mbstring php8.4-xml php8.4-mysql php8.4-zip php8.4-curl php8.4-intl php8.4-bcmath php8.4-soap php8.4-gd -y
else
    echo -e "\nPHP 8.4 is already installed. Skipping...\n"
fi

# Install Composer
if ! command -v composer &> /dev/null; then
    echo -e "\nInstalling Composer...\n"
    curl -sS https://getcomposer.org/installer | php
    sudo mv composer.phar /usr/local/bin/composer
    echo -e "\Composer successfully Installed.\n"
else
    echo -e "\nComposer is already installed. Skipping...\n"
fi

echo
composer --version
echo

# Install MySQL if not installed
if ! command -v mysql &> /dev/null; then
    echo -e "\nInstalling MySQL...\n"
    sudo apt install mysql-server -y
    echo "Setting up MySQL..."
    sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';"
    sudo mysql -e "FLUSH PRIVILEGES;"
else
    echo "MySQL is already installed. Skipping..."
fi

# Install MySQL Workbench
if ! snap list | grep -q mysql-workbench-community; then
    echo -e "\nInstalling MySQL Workbench...\n"
    sudo snap install mysql-workbench-community
else
    echo -e "\nMySQL Workbench is already installed. Skipping...\n"
fi

# Git Setup
if ! command -v git &> /dev/null; then
    echo -e "\nInstalling Git...\n"
    sudo apt install git -y
fi
echo -e "\nSetting up Git...\n"
git --version
git config --global user.name "Jude Adolfo"
git config --global user.email "judea3264@gmail.com"
git config --list

# Install GUI apps
if ! command -v terminator &> /dev/null; then
    echo -e "\nInstalling Terminator and Mousepad...\n"
    sudo apt install terminator mousepad -y
else
    echo -e "\nTerminator and Mousepad already installed. Skipping...\n"
fi

# Install VS Code
if ! snap list | grep -q code; then
    echo -e "\nInstalling Visual Studio Code...\n"
    sudo snap install code --classic
else
    echo -e "\nVS Code is already installed. Skipping...\n"
fi

# Install Firefox Developer Edition
FIREFOX_DIR="/opt/firefox-developer"
ARCHIVE_FILE="firefox-developer.tar.xz"
if [ ! -f "/usr/local/bin/firefox-developer" ]; then
    echo -e "\nInstalling Firefox Developer Edition...\n"
    curl -L "https://download.mozilla.org/?product=firefox-devedition-latest-ssl&os=linux64&lang=en-US" -o "$ARCHIVE_FILE"
    if [ -s "$ARCHIVE_FILE" ]; then
        echo -e "\nExtracting $ARCHIVE_FILE...\n"
        sudo tar -xJf "$ARCHIVE_FILE" -C /opt/
        sudo mv /opt/firefox "$FIREFOX_DIR"
        sudo ln -sf "$FIREFOX_DIR/firefox" /usr/local/bin/firefox-developer
        rm "$ARCHIVE_FILE"
        echo -e "\nCreating desktop entry...\n"
        cat <<EOF | sudo tee /usr/share/applications/firefox-developer.desktop > /dev/null
[Desktop Entry]
Name=Firefox Developer Edition
Exec=/opt/firefox-developer/firefox %u
Terminal=false
Icon=/opt/firefox-developer/browser/chrome/icons/default/default128.png
Type=Application
Categories=Network;WebBrowser;
StartupNotify=true
EOF
        echo -e "\nFirefox Developer Edition installed successfully.\n"
    else
        echo -e "\nDownload failed or file is empty.\n"
    fi
else
    echo -e "\nFirefox Developer Edition is already installed. Skipping...\n"
fi

# Install Python and tools
if ! command -v python3 &> /dev/null; then
    echo -e "\nInstalling Python...\n"
    sudo apt install python3 -y
else
    echo -e "\nPython is already installed\n"
fi

if ! command -v python3-pip &> /dev/null; then
    echo -e "\nInstalling Python tools...\n"
    echo "SUDO_PASSWORD" | sudo -S apt install python3-pip python3-venv -y
else
    echo -e "\nPython tools is already installed\n"
fi

# Install MEGAsync
if ! command -v megasync &> /dev/null; then
    echo -e "\nInstalling MEGAsync...\n"
    wget https://mega.nz/linux/repo/xUbuntu_24.04/amd64/megasync-xUbuntu_24.04_amd64.deb
    sudo apt install ./megasync-xUbuntu_24.04_amd64.deb -y
    rm megasync-xUbuntu_24.04_amd64.deb
else
    echo -e "\nMEGAsync is already installed. Skipping...\n"
fi

# Install LibreOffice
if ! snap list | grep -q libreoffice; then
    echo -e "\nInstalling LibreOffice...\n"
    sudo snap install libreoffice
else
    echo -e "\nLibreOffice is already installed. Skipping...\n"
fi

# Install VLC
if ! snap list | grep -q vlc; then
    echo -e "\nInstalling VLC...\n"
    sudo snap install vlc
else
    echo -e "\nVLC is already installed. Skipping...\n"
fi

if ! command -v docker &> /dev/null; then
    echo -e "\nInstalling Docker...\n"
    # Add Docker's official GPG key:
    sudo apt-get update
    sudo apt-get install ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    # Add the repository to Apt sources:
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update

    #Installing docker
    echo -e "\nInstalling latest docker...\n"
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose docker-compose-plugin -y
    
else
    echo -e "\nDocker is already installed. Skipping...\n"
fi

if ! command -v postgresql &> /dev/null; then
    echo -e "\nInstalling PostgreSQL...\n"
    sudo apt install postgresql postgresql-contrib -y
else
    echo -e "\nPostgreSQL is already installed. Skipping...\n"
fi

if ! command -v dotnet-sdk &> /dev/null; then
    echo -e "\nInstalling C# and .NET...\n"
    sudo apt install dotnet-sdk-8.0 -y
else
    echo -e "\nC# and .NET is already installed. Skipping\n"
fi

# Update system
echo -e "\nUpdating, Cleaning and upgrading system...\n"
sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y

echo -e "\nSetup Complete!\n"
