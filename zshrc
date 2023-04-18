# vim: set ts=2 sw=2 ft=zsh:

# Sourced by all interactive shells, both login and non-login

#------------------------------
# History
#------------------------------
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
HISTCONTROL=ignoredups:ignorespace

#------------------------------
# Variables
#------------------------------
export BROWSER="firefox"
export EDITOR="vim"
export VISUAL="vim"
#export PAGER="vimpager"
export PATH="${PATH}:${HOME}/bin"

# set default fzf command to ripgrep
# fzf: https://github.com/junegunn/fzf
# ripgrep: https://github.com/BurntSushi/ripgrep
export FZF_DEFAULT_COMMAND='rg --files'

#-----------------------------
# Dircolors
#-----------------------------
export LS_COLORS='rs=0:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:';

#------------------------------
# Keybindings
#------------------------------
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line
bindkey -v
typeset -g -A key

bindkey '\e[3~' delete-char # del key behaviour
bindkey '^[[5~' up-line-or-history
bindkey '^[[6~' down-line-or-history
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search

#------------------------------
# ShellFuncs
#------------------------------

# -- coloured manuals
man() {
  env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
    man "$@"
}

# asdf - multi language version manager
# https://github.com/asdf-vm/asdf
# if [ -d ~/.asdf ]; then
#   source "$HOME/.asdf/asdf.sh"
#
#   # include completions
#   fpath=(${ASDF_DIR}/completions $fpath)
# fi

# rtx - lang manager
if fn_exists rtx; then
  eval "$(rtx activate zsh)"
fi

# z-zsh
# https://github.com/agkozak/zsh-z
source ~/.zsh/zsh-z/zsh-z.plugin.zsh
zstyle ':completion:*' menu select

# And the external aliases file
source ~/.zsh/aliases

#------------------------------
# Window title
#------------------------------
# set the title of the term when "idle"
precmd_set_title () {
  print -Pn "\e]0;[%n@%M][%~]%#\a"
}

# set the term title to show what is currently being executed
preexec_set_title () {
  print -Pn "\e]0;[%n@%M][%~]%# ($1)\a"
}

# Add the title functions to the function arrays for execution
precmd_functions+=(precmd_set_title)
preexec_functions+=(preexec_set_title)

#------------------------------
# Prompt
#------------------------------
autoload -U colors zsh/terminfo
colors
source ~/.zsh/prompt
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#-------------------------------------------------------------------------------
# Completions
#-------------------------------------------------------------------------------
zmodload zsh/complist
autoload -Uz compinit
compinit

#- buggy
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
#-/buggy

zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*'   force-list always

zstyle ':completion:*:*:killall:*' menu yes select
zstyle ':completion:*:killall:*'   force-list always

zstyle :compinstall filename '${HOME}/.zshrc'

#- complete pacman-color the same as pacman
compdef _pacman pacman-color=pacman
zstyle ':completion:*:pacman:*' force-list always
zstyle ':completion:*:*:pacman:*' menu yes select

# Load completions for npm
source ~/.zsh/npm-completion


# And finally, provide an entrypoint for anything that's not generally
# applicable
[ -s ~/.machine-specific ] && . ~/.machine-specific
