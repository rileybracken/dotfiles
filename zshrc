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
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# export PATH="/usr/local/bin:$PATH"
# export PATH="$HOME/.bin:$PATH"
# source /Users/riley/.asdf/asdf.sh

# Start rbenv
eval "$(rbenv init -)"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
