#!/bin/bash
set -e

echo "--------------------- Installing Teams ------------------------------------"
sudo apt update -y
sudo snap install teams-for-linux

echo "--------------------- Installing Node using NVM ---------------------------"
sudo apt install curl -y
curl -sL https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.0/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
nvm install --lts

echo "--------------------- Installing Adminer ----------------------------------"
sudo apt install adminer -y
sudo a2enconf adminer
sudo systemctl reload apache2

echo "--------------------- Installing MySQL ------------------------------------"
sudo apt install mysql-server -y

echo "--------------------- Installing MongoDB ----------------------------------"
sudo apt-get install gnupg curl -y
curl -fsSL https://www.mongodb.org/static/pgp/server-8.0.asc | \
   sudo gpg -o /usr/share/keyrings/mongodb-server-8.0.gpg --dearmor
echo "deb [ arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-server-8.0.gpg ] https://repo.mongodb.org/apt/ubuntu noble/mongodb-org/8.0 multiverse" | \
   sudo tee /etc/apt/sources.list.d/mongodb-org-8.0.list
sudo apt-get update -y
sudo apt-get install -y mongodb-org
sudo systemctl enable --now mongod

echo "--------------------- Installing MongoDB Compass --------------------------"
wget -q https://downloads.mongodb.com/compass/mongodb-compass_1.46.7_amd64.deb
sudo dpkg -i mongodb-compass_1.46.7_amd64.deb || sudo apt install -f -y
rm mongodb-compass_1.46.7_amd64.deb

echo "--------------------- Installing VS Code ----------------------------------"
wget -q https://vscode.download.prss.microsoft.com/dbazure/download/stable/e3550cfac4b63ca4eafca7b601f0d2885817fd1f/code_1.103.0-1754517494_amd64.deb
sudo dpkg -i code_1.103.0-1754517494_amd64.deb || sudo apt install -f -y
rm code_1.103.0-1754517494_amd64.deb

echo "--------------------- Installing Google Chrome ----------------------------"
wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb || sudo apt install -f -y
rm google-chrome-stable_current_amd64.deb

echo "--------------------- All tools installed ---------------------------------"
