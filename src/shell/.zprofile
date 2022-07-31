#!/usr/bin/env zsh

source ~/.dotfiles/src/shell/shenv

if [ -e ~/.dotfiles/src/shell/shenv.local ]
then
    source ~/.dotfiles/src/shell/shenv.local
fi