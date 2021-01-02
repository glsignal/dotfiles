# vim: set ts=2 sw=2 ft=zsh:

# Sourced by non-login, non-interactive shells (so, always, and including
# scripts) - keep it minimal!

# Helper for checking if a command is present on the system
# This is used in a lot of places, not just in .zshenv, so don't remove without
# checking for usage first
fn_exists () {
  command -v "$1" >/dev/null 2>&1
}

# Alias pbcopy/pbpaste if they aren't available and we have xsel
# This is in .zshenv mostly so that it's available when executing commands
# through vim's externral command interface
if fn_exists xsel; then
  if ! fn_exists pbcopy; then
    alias pbcopy='xsel --clipboard --input'
  fi

  if ! fn_exists pbpaste; then
    alias pbpaste='xsel --clipboard --output'
  fi
fi
