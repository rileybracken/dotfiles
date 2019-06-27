# Oh My Zsh
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Aliases
alias tlog='tail -f log/development.log'
alias wmip='ipconfig getifaddr en0'

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="/usr/local/bin:$PATH"

export PATH="$HOME/.bin:$PATH"
# source /Users/riley/.asdf/asdf.sh

# Start rbenv
eval "$(rbenv init -)"
