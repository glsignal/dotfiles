#------------------------------
# Based off zsh file from Øyvind "Mr.Elendig" Heggstad <mrelendig@har-ikkje.net>
#------------------------------

# Use vim keybindings
bindkey -v

# Define a helper for checking if a program exists
fn_exists () {
  command -v "$1" >/dev/null 2>&1
}

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

#-----------------------------
# Dircolors
#-----------------------------
LS_COLORS='rs=0:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:';
export LS_COLORS

#------------------------------
# Keybindings
#------------------------------
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line
bindkey -v
typeset -g -A key
#bindkey '\e[3~' delete-char
bindkey '\e[1~' beginning-of-line
bindkey '\e[4~' end-of-line
#bindkey '\e[2~' overwrite-mode
bindkey '^?' backward-delete-char
bindkey '^[[1~' beginning-of-line
bindkey '^[[5~' up-line-or-history
bindkey '^[[3~' delete-char
bindkey '^[[4~' end-of-line
bindkey '^[[6~' down-line-or-history
bindkey '^[[A' up-line-or-search
bindkey '^[[D' backward-char
bindkey '^[[B' down-line-or-search
bindkey '^[[C' forward-char
# for rxvt
bindkey "\e[8~" end-of-line
bindkey "\e[7~" beginning-of-line
# for gnome-terminal
bindkey "\eOH" beginning-of-line
bindkey "\eOF" end-of-line

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

# asdf-vm (multi language version manager)
if [ -d ~/.asdf ]; then
  . "$HOME/.asdf/asdf.sh"
  # append completions to fpath
  fpath=(${ASDF_DIR}/completions $fpath)
fi

#- buggy
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
#-/buggy

zstyle ':completion:*:pacman:*' force-list always
zstyle ':completion:*:*:pacman:*' menu yes select

zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*'   force-list always

zstyle ':completion:*:*:killall:*' menu yes select
zstyle ':completion:*:killall:*'   force-list always

#------------------------------
# Window title
#------------------------------
case $TERM in
  termite|*xterm*|rxvt|rxvt-unicode|rxvt-256color|rxvt-unicode-256color|(dt|k|E)term)
    precmd () {
      vcs_info
      print -Pn "\e]0;[%n@%M][%~]%#\a"
    }
    preexec () {
      print -Pn "\e]0;[%n@%M][%~]%# ($1)\a"
    }
    ;;
  screen|screen-256color)
    precmd () {
      vcs_info
      print -Pn "\e]83;title \"$1\"\a"
      print -Pn "\e]0;$TERM - (%L) [%n@%M]%# [%~]\a"
    }
    preexec () {
      print -Pn "\e]83;title \"$1\"\a"
      print -Pn "\e]0;$TERM - (%L) [%n@%M]%# [%~] ($1)\a"
    }
    ;;
esac

#------------------------------
# Comp stuff
#------------------------------
zmodload zsh/complist
autoload -Uz compinit

compinit
zstyle :compinstall filename '${HOME}/.zshrc'

#- complete pacman-color the same as pacman
compdef _pacman pacman-color=pacman

export FZF_DEFAULT_COMMAND='rg --files'

[ -s ~/.prompt ]      && . ~/.prompt
[ -s ~/.aliases ]     && . ~/.aliases
[ -s ~/.credentials ] && . ~/.credentials

# Derp (vte; so gnome-terminal's tabs don't suck)
[ -s /etc/profile.d/vte.sh ] && . /etc/profile.d/vte.sh

# z-zsh
[ -s ~/.z.sh ]                    && . ~/.z.sh
[ -s ~/.zsh-syntax-highlighting ] && . ~/.zsh-syntax-highlighting
[ -s ~/.npm-completion ]          && . ~/.npm-completion

# Machine specific config
[ -s ~/.machine-specific ] && . ~/.machine-specific

# vim: set ts=2 sw=2 et:
