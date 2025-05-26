#!/bin/bash

# Install NVM (Node Version Manager)
echo "Installing NVM..."
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

# Set up environment
echo "Setting up NVM environment..."
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Download and install Node.js
echo "Installing Node.js..."
nvm install 22
# Verify Node.js and npm versions
node -v && npm -v

# Add PHP repository and update package list
echo "Adding PHP repository and updating package list..."
sudo add-apt-repository ppa:ondrej/php -y
sudo apt update

# Install PHP 8.4 with extensions
echo "Installing PHP 8.4 with extensions..."
sudo apt install php8.4 php8.4-cli php8.4-fpm php8.4-mbstring php8.4-xml php8.4-mysql php8.4-zip php8.4-curl php8.4-intl php8.4-bcmath php8.4-soap php8.4-gd -y

# Install Composer
echo "Installing Composer..."
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer

# Verify Composer installation
composer --version

# Install MySQL
echo "Installing MySQL..."
sudo apt install mysql-server -y

# Set up MySQL
echo "Setting up MySQL..."
sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'password';"
sudo mysql -e "FLUSH PRIVILEGES;"
sudo mysql -e "EXIT;"

# MySQL Workbench
echo "Installing MySQL Workbench"
sudo snap install mysql-workbench-community

# Git Setup
echo "Setting up Git..."
git --version
git config --global user.name "Jude Adolfo"
git config --global user.email "judea3264@gmail.com"
git config --list

# Install GUI applications: Terminator, Mousepad
echo "Installing Terminator and Mousepad..."
sudo apt install terminator mousepad -y

# Install VS Code via Snap
echo "Installing Visual Studio Code via Snap..."
sudo snap install code --classic

# Install Firefox Developer Edition
echo "Installing Firefox Developer Edition..."
FIREFOX_DIR="/opt/firefox-developer"
ARCHIVE_FILE="firefox-developer.tar.xz"

# Download the file and manually name it
curl -L "https://download.mozilla.org/?product=firefox-devedition-latest-ssl&os=linux64&lang=en-US" -o "$ARCHIVE_FILE"

# Check if file exists and is not empty
if [ -s "$ARCHIVE_FILE" ]; then
    echo "Extracting $ARCHIVE_FILE..."
    sudo tar -xJf "$ARCHIVE_FILE" -C /opt/
    sudo mv /opt/firefox "$FIREFOX_DIR"
    sudo ln -sf "$FIREFOX_DIR/firefox" /usr/local/bin/firefox-developer
    rm "$ARCHIVE_FILE"

    echo "Creating desktop entry for Firefox Developer Edition..."
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

# Install Python, pip, virtualenv, Django, Flask
echo "Installing Python development tools..."
sudo apt install python3 python3-pip python3-venv -y
pip3 install --upgrade pip
pip3 install virtualenv django flask

# Verify installations
echo "Verifying Python packages..."
python3 --version
pip3 show django flask virtualenv

# Install MEGAsync
echo "Installing MEGAsync..."
wget https://mega.nz/linux/repo/xUbuntu_24.04/amd64/megasync-xUbuntu_24.04_amd64.deb
sudo apt install ./megasync-xUbuntu_24.04_amd64.deb -y
rm megasync-xUbuntu_24.04_amd64.deb

# Install Google Chrome
echo "Installing Google Chrome..."
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb -y
rm google-chrome-stable_current_amd64.deb

echo "Installing LibreOffice via snap..."
sudo snap install libreoffice

echo "Installing VLC"
sudo snap install vlc

# Update and Upgrade
echo "Updating and upgrading system..."
sudo apt update && sudo apt upgrade -y

echo "Setup Complete!"
