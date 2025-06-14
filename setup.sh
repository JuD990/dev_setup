#!/bin/bash

# Install NVM (Node Version Manager) if not installed
if ! command -v nvm &> /dev/null && [ ! -d "$HOME/.nvm" ]; then
    echo "Installing NVM..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
else
    echo "NVM is already installed. Skipping..."
fi

# Set up environment
echo "Setting up NVM environment..."
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Install Node.js if not installed
if ! command -v node &> /dev/null || ! node -v | grep -q "v22"; then
    echo "Installing Node.js..."
    nvm install 22
else
    echo "Node.js v22 is already installed. Skipping..."
fi
node -v && npm -v

# Add PHP repository and update package list
echo "Adding PHP repository and updating package list..."
sudo add-apt-repository ppa:ondrej/php -y
sudo apt update

# Install PHP 8.4 if not already installed
if ! php -v | grep -q "8.4"; then
    echo "Installing PHP 8.4 with extensions..."
    sudo apt install php8.4 php8.4-cli php8.4-fpm php8.4-mbstring php8.4-xml php8.4-mysql php8.4-zip php8.4-curl php8.4-intl php8.4-bcmath php8.4-soap php8.4-gd -y
else
    echo "PHP 8.4 is already installed. Skipping..."
fi

# Install Composer
if ! command -v composer &> /dev/null; then
    echo "Installing Composer..."
    curl -sS https://getcomposer.org/installer | php
    sudo mv composer.phar /usr/local/bin/composer
else
    echo "Composer is already installed. Skipping..."
fi
composer --version

# Install MySQL if not installed
if ! command -v mysql &> /dev/null; then
    echo "Installing MySQL..."
    sudo apt install mysql-server -y
    echo "Setting up MySQL..."
    sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';"
    sudo mysql -e "FLUSH PRIVILEGES;"
else
    echo "MySQL is already installed. Skipping..."
fi

# Install MySQL Workbench
if ! snap list | grep -q mysql-workbench-community; then
    echo "Installing MySQL Workbench..."
    sudo snap install mysql-workbench-community
else
    echo "MySQL Workbench is already installed. Skipping..."
fi

# Git Setup
if ! command -v git &> /dev/null; then
    echo "Installing Git..."
    sudo apt install git -y
fi
echo "Setting up Git..."
git --version
git config --global user.name "Jude Adolfo"
git config --global user.email "judea3264@gmail.com"
git config --list

# Install GUI apps
if ! command -v terminator &> /dev/null; then
    echo "Installing Terminator and Mousepad..."
    sudo apt install terminator mousepad -y
else
    echo "Terminator and Mousepad already installed. Skipping..."
fi

# Install VS Code
if ! snap list | grep -q code; then
    echo "Installing Visual Studio Code..."
    sudo snap install code --classic
else
    echo "VS Code is already installed. Skipping..."
fi

# Install Firefox Developer Edition
FIREFOX_DIR="/opt/firefox-developer"
ARCHIVE_FILE="firefox-developer.tar.xz"
if [ ! -f "/usr/local/bin/firefox-developer" ]; then
    echo "Installing Firefox Developer Edition..."
    curl -L "https://download.mozilla.org/?product=firefox-devedition-latest-ssl&os=linux64&lang=en-US" -o "$ARCHIVE_FILE"
    if [ -s "$ARCHIVE_FILE" ]; then
        echo "Extracting $ARCHIVE_FILE..."
        sudo tar -xJf "$ARCHIVE_FILE" -C /opt/
        sudo mv /opt/firefox "$FIREFOX_DIR"
        sudo ln -sf "$FIREFOX_DIR/firefox" /usr/local/bin/firefox-developer
        rm "$ARCHIVE_FILE"
        echo "Creating desktop entry..."
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
        echo "✅ Firefox Developer Edition installed successfully."
    else
        echo "❌ Download failed or file is empty."
    fi
else
    echo "Firefox Developer Edition is already installed. Skipping..."
fi

# Install Python and tools
if ! command -v python3 &> /dev/null; then
    echo "Installing Python..."
    sudo apt install python3 -y
fi
echo "Installing Python tools..."
sudo apt install python3-pip python3-venv -y
pip3 install --upgrade pip
pip3 install virtualenv django flask
echo "Verifying Python packages..."
python3 --version
pip3 show django flask virtualenv

# Install MEGAsync
if ! command -v megasync &> /dev/null; then
    echo "Installing MEGAsync..."
    wget https://mega.nz/linux/repo/xUbuntu_24.04/amd64/megasync-xUbuntu_24.04_amd64.deb
    sudo apt install ./megasync-xUbuntu_24.04_amd64.deb -y
    rm megasync-xUbuntu_24.04_amd64.deb
else
    echo "MEGAsync is already installed. Skipping..."
fi

# Install Google Chrome
if ! command -v google-chrome &> /dev/null; then
    echo "Installing Google Chrome..."
    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo apt install ./google-chrome-stable_current_amd64.deb -y
    rm google-chrome-stable_current_amd64.deb
else
    echo "Google Chrome is already installed. Skipping..."
fi

# Install LibreOffice
if ! snap list | grep -q libreoffice; then
    echo "Installing LibreOffice..."
    sudo snap install libreoffice
else
    echo "LibreOffice is already installed. Skipping..."
fi

# Install VLC
if ! snap list | grep -q vlc; then
    echo "Installing VLC..."
    sudo snap install vlc
else
    echo "VLC is already installed. Skipping..."
fi

# Update system
echo "Updating and upgrading system..."
sudo apt update && sudo apt upgrade -y

echo "✅ Setup Complete!"
