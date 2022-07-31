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
)

rm $log_file
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