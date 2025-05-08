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
sudo add-apt-repository ppa:ondrej/php
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

# Git Setup
echo "Setting up Git..."
git --version
git config --global user.name "Jude Adolfo"
git config --global user.email "judea3264@gmail.com"
git config --list

# Update and Upgrade
echo "Updating and upgrading system..."
sudo apt update && sudo apt upgrade -y

echo "Setup Complete!"
