alias vim="nvim"
alias ls="ls --color=auto -h"
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
# The following lines were added by compinstall

zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'l:|=* r:|=*'
zstyle :compinstall filename '/home/michael/.zshrc'

eval $(dircolors)

autoload -Uz compinit
autoload -U promptinit; promptinit
prompt pure

compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt autocd extendedglob correct share_history inc_append_history
unsetopt beep nomatch notify
bindkey -e
bindkey '^[g' global-cd-widget
bindkey '^[i' insert-widget

# End of lines configured by zsh-newuser-install
#

global-cd-widget() {
    zle kill-buffer
    local file="$(locate -0 / | grep -z -vE '~$' | fzf --read0 -0 -1 --preview 'tree -C {} | head -200')"
    if [[ -n $file ]]; then
        if [[ -d $file ]]; then  
           cd -- "$file"
        else
            cd -- "${file:h}"
        fi
    fi
    zle reset-prompt
}
zle -N global-cd-widget

insert-widget() {
    local target="$(locate -Ai -0 / | grep -z -vE '~$' | fzf --read0 -0 -1 --preview 'tree -C {} | head -200')"
    if [[ -n $target ]]; then
        LBUFFER+="\"$target\" "
        zle redisplay
    else
        zle redisplay
    fi
}
zle -N insert-widget

source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
source .zsh_plugins.sh


