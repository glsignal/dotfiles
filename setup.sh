CURRENT_DIR=$(pwd)

# git-completion.bash
# z.sh
# zsh-zyntax-highlighting.zsh
if which git &> /dev/null; then
  echo "Fetching submodules"
  git submodule update --init

	printf '\n'
  echo "$CURRENT_DIR/git-completion.bash -> $HOME/.git-completion"
  ln -s "$CURRENT_DIR/git-completion.bash" "$HOME/.git-completion"

	printf '\n'
  echo "$CURRENT_DIR/z-zsh/z.sh -> $HOME/.z.sh"
  ln -s "$CURRENT_DIR/z-zsh/z.sh" "$HOME/.z.sh"

	printf '\n'
  echo "$CURRENT_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh -> $HOME/.zsh-syntax-highlighting"
  ln -s "$CURRENT_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" "$HOME/.zsh-syntax-highlighting"
else
  echo "Please install git"
fi

for f in aliases \
         gemrc \
         gitconfig \
         gitignore_global \
         npm-completion \
         prompt \
         ruby-version \
         screenrc \
         work \
         zprofile \
         zshrc
do
	printf '\n'
  echo "$CURRENT_DIR/$f -> $HOME/.$f"
	ln -s "$CURRENT_DIR/$f" "$HOME/.$f"
done
