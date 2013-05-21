# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Define a helper for checking if a program exists
fn_exists () {
  command -v "$1" >/dev/null 2>&1
}

# Use vim as our editor
export VISUAL=vim

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# Returns the current branch name or 'no branch' if we're not under a
# specific branch
git_branch() {
  local b=$(git symbolic-ref HEAD 2> /dev/null)
  local branch="${b#refs/heads/}"
  if [ -n "$branch" ]; then
    branch="$branch"
  else
    branch="no branch"
  fi

  if [ "$color_prompt" = yes ]; then
    echo -n "$branch"
  else
    echo -n "$branch"
  fi
}

# Set up the pretty status line
if [ "$color_prompt" = yes ]; then
  PS1="\n${debian_chroot:+($debian_chroot)}\[\033[00;33m\]\u\[\033[00m\]"
  PS1="${PS1}[\[\033[00;35m\]\h\[\033[00m\]]"
  PS1="${PS1} :: \[\033[00;36m\]\$(git_branch)\[\033[00m\]"
  if [ -x "$HOME/.rvm/bin/rvm-prompt" ]; then
    PS1="${PS1} :: \[\033[00;31m\]\$($HOME/.rvm/bin/rvm-prompt)\[\033[00m\]"
  elif fn_exists ruby; then
    rb_version="$(ruby -v | cut -d " " -f 1,2)"
    PS1="${PS1} :: \[\033[00;31m\]\${rb_version}\[\033[00m\]"
  else
    PS1="${PS1} :: \[\033[00;31m\]no rubies\[\033[00m\]"
  fi
  PS1="${PS1}\n\[\033[01;34m\]\w\[\033[00m\]>\$ "
else
  PS1="\n${debian_chroot:+($debian_chroot)}\u[\h] :: $(git_branch) :: \$($HOME/.rvm/bin/rvm-prompt)\n\w>\$ "
fi
unset color_prompt force_color_prompt current_branch

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Git completion
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

# Git Flow completion
if [ -f ~/.git-flow-completion.bash ]; then
  . ~/.git-flow-completion.bash
fi

# Load RVM function
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

# Add RVM to PATH for scripting
PATH=$PATH:$HOME/.rvm/bin

# Add location for arbitrary executables
PATH=$PATH:$HOME/bin

export LESS="-R"

# load additional path dotfiles if they're present
# Android SDK
if [ -f ~/.path/android ]; then
  . ~/.path/android
fi

# STM32 Toolchain
if [ -f ~/.path/stm32 ]; then
  . ~/.path/stm32
fi

# Arch-specific
if [ -f ~/.path/arch ]; then
  . ~/.path/arch
fi
