# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme
ZSH_THEME="awesomepanda"

# Plugins
plugins=(
    git
    docker-compose
    common-aliases
    command-not-found
    emoji
    gcloud
    golang
    history
    laravel
    composer
    terraform
)

source $ZSH/oh-my-zsh.sh

# User configuration
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Aliases
source ~/.dotfiles/src/shell/aliases
