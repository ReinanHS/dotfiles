#!/bin/bash

# Variables
log_file=~/install_dotfiles.log
declare -a packages=(
    "zsh" 
    "zsh-syntax-highlighting"
    "unzip"
    "build-essential"
    "make"
    "neovim"
    "python3-neovim"
    "ripgrep"
)

cd ~
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

# Astronvim

## Lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit -D -t /usr/local/bin/
rm -rf lazygit.tar.gz
rm -rf lazygit

## Gdu
curl -L https://github.com/dundee/gdu/releases/latest/download/gdu_linux_amd64.tgz | tar xz
chmod +x gdu_linux_amd64
sudo mv gdu_linux_amd64 /usr/bin/gdu

## Bottom
curl -LO https://github.com/ClementTsang/bottom/releases/download/0.10.2/bottom_0.10.2-1_amd64.deb
sudo dpkg -i bottom_0.10.2-1_amd64.deb

# Install oh-my-zsh
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

rm ~/.zshrc
rm ~/.zprofile
rm ~/.gitconfig
rm ~/.gitignore
