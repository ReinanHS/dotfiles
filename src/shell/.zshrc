# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme
ZSH_THEME="awesomepanda"

# Plugins
plugins=(
    git
)

source $ZSH/oh-my-zsh.sh

# User configuration
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Aliases
source ~/.dotfiles/src/shell/aliases