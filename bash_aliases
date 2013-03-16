# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -alh'
alias l='ls -CF'

# LaTeX compile alias
lc () { latex $*.tex; dvips $*.dvi; ps2pdf $*.ps; }

# set vi to run vim if vim is available
if fn_exists vim; then
  alias vi='vim'
fi

alias gst='git status'
alias gck='git checkout'
alias gc='git clone'

alias be='bundle exec'

# Start webserver in current directory
if fn_exists python; then
  python_major=$(python -V 2>&1 | cut -d " " -f 2 | cut -d "." -f 1)
  if [ $python_major -lt 3 ]; then
    alias webme='python -m SimpleHTTPServer'
  else
    alias webme='python -m http.server'
  fi
fi

# Start the rails app and drop into Pry
alias pryme='bundle exec pry -r ./config/environment'

# Start a nice ASCII art clock
alias clock='watch -t -n1 "date +%T|figlet"'

# PHP Development server (assuming PHP => 5.4.x)
alias phpme='php -S localhost:4000'

# Alias pbcopy/pbpaste if they aren't available and we have xsel
if fn_exists xsel; then
  if ! fn_exists pbcopy; then
    alias pbcopy='xsel --clipboard --input'
  fi
  if ! fn_exists pbpaste; then
    alias pbpaste='xsel --clipboard --output'
  fi
fi

# Start and stop PostgreSQL under Arch Linux quickly
if [ -x $(which uname) ] && [[ "$(uname -r)" =~ .*ARCH.* ]]; then
  alias pgstart='sudo systemctl start postgresql'
  alias pgstop='sudo systemctl stop postgresql'
fi
