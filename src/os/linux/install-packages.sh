#!/bin/bash

# Variables
log_file=~/install_dotfiles.log
declare -a packages=(
    "zsh" 
    "zsh-syntax-highlighting"
    "php-cli"
    "unzip"
    "build-essential"
    "make"
    "neovim"
    "python3-neovim"
    "terraform"
)

cd ~
rm $log_file

# Install terraform
# Doc: https://www.terraform.io/cli/install/apt

wget -O- https://apt.releases.hashicorp.com/gpg | \
    gpg --dearmor | \
    sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
    https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
    sudo tee /etc/apt/sources.list.d/hashicorp.list

sudo apt update

for package in "${packages[@]}"
do
   sudo apt-get -y install $package
    if type -p $package > /dev/null; then
        echo "[✓] $package installed" >> $log_file
    else
        echo "[x] $package failed to installed" >> $log_file
    fi
done

# Install composer
curl -sS https://getcomposer.org/installer -o composer-setup.php
HASH=`curl -sS https://composer.github.io/installer.sig`
echo $HASH
php -r "if (hash_file('SHA384', 'composer-setup.php') === '$HASH') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer
rm composer-setup.php
composer --version

# Install oh-my-zsh
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

rm ~/.zshrc
rm ~/.zprofile
rm ~/.gitconfig
rm ~/.gitignore
