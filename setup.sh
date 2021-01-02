CURRENT_DIR=$(pwd)

# git-completion.bash
# z.sh
# zsh-zyntax-highlighting.zsh
if which git &> /dev/null; then
  echo "Fetching submodules"
  git submodule update --init
else
  echo "Please install git"
fi

echo "Creating machine-specific config file"
touch "$CURRENT_DIR/machine-specific"

for f in zsh \
         gemrc \
         gitconfig \
         git_templates \
         gitignore_global \
         machine-specific \
         tmux.conf \
         zshenv \
         zprofile \
         zshrc
do
	printf '\n'
  echo "$CURRENT_DIR/$f -> $HOME/.$f"
	ln -s "$CURRENT_DIR/$f" "$HOME/.$f"
done

if ! [[ -d "$HOME/.config/git" ]]; then
  mkdir -p "$HOME/.config/git";
fi

echo "$CURRENT_DIR/config/git/template -> $HOME/.config/git/"
ln -is "$CURRENT_DIR/config/git/template" "$HOME/.config/git/"

echo "$CURRENT_DIR/config/kitty -> $HOME/.config/"
ln -is "$CURRENT_DIR/config/kitty" "$HOME/.config/"

if [[ "$OSTYPE" == "darwin"* ]]; then
  ln -is "$HOME/.config/kitty/kitty.macos.conf" "$HOME/.config/kitty/kitty.conf"
else
  ln -is "$HOME/.config/kitty/kitty.linux.conf" "$HOME/.config/kitty/kitty.conf"
fi
