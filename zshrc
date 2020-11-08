# Oh My Zsh
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Aliases
alias tlog='tail -f log/development.log'
alias wmip='ipconfig getifaddr en0'
alias tmux="TERM=screen-256color-bce tmux"

# NVM
export NVM_DIR="$HOME/.nvm"
if [[ -s "$NVM_DIR/nvm.sh" ]]; then
    source "$NVM_DIR/nvm.sh"
fi

# export PATH="/usr/local/bin:$PATH"
# export PATH="$HOME/.bin:$PATH"
# source /Users/riley/.asdf/asdf.sh

# Start rbenv
eval "$(rbenv init -)"
