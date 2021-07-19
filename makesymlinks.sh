#!/bin/bash
# This script creates symlinks from the home directory to any desired dotfiles in ~/.dotfiles

DOTF_DIR=~/.dotfiles
BACKUP_DIR=~/.backup

# list of .dotfiles 
files=".bashrc .gitconfig .p10k.zsh .tmux.conf .vimrc .zshrc"    

while [ -n "$1" ]; do
  case "$1" in

  # revert changes with -d flag
  -D) echo "removing symlinks from ~"
    cd ~
    for file in $files; do
      rm $file -f 
    done
    echo "copying .files back from $BACKUP_DIR"
    cp -a $BACKUP_DIR/. ~/

    echo "change back to /bin/bash"
    chsh -s /bin/bash
    exit 0
    ;;

  -*) echo "Option $1 not recognized"
    exit 127
     ;;

  esac
shift
done

# create dotfiles_old in homedir
mkdir -p $BACKUP_DIR

# move existing dotfiles => $BACKUP_DIR
# create symlinks for dotfiles 
cd ~

for file in $files; do
  if [[ -L "${file}" ]]; then
    # if symlink => rm
    rm $file
  fi
  if [[ -f "${file}" ]]; then
    # if normal file save to backup
    mv $file $BACKUP_DIR
  fi
   
  # install symlink 
  ln -s $DOTF_DIR/$file $file
done


install_vim () {
  # install vim extensions
  if [ ! -f /usr/bin/vim ]; then
    sudo apt-get install vim
  fi

  if [ ! -d ~/".vim/pack/typescript/start/typescript-vim" ] ; then
    git clone https://github.com/leafgarland/typescript-vim.git ~/.vim/pack/typescript/start/typescript-vim
  fi
  if [ ! -d ~/".vim/pack/dist/start/vim-airline" ] ; then
    git clone https://github.com/vim-airline/vim-airline ~/.vim/pack/dist/start/vim-airline
  fi
}


install_zsh () {
  # Test to see if zshell is installed.  If it is:
  if [ -f /bin/zsh -o -f /usr/bin/zsh ]; then
    # Set the default shell to zsh if it isn't currently set to zsh
    if [[ ! $(echo $SHELL) == $(which zsh) ]]; then
      chsh -s $(which zsh)
    fi
  else
    sudo apt-get install zsh
    chsh -s $(which zsh)
  fi

  if [ ! -d ~/".zsh/powerlevel10k" ] ; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.zsh/powerlevel10k
  fi
  if [ ! -d ~/".zsh/zsh-autosuggestions" ] ; then
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
  fi
  if [ ! -d ~/".zsh/zsh-syntax-highlighting" ] ; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
  fi
}
 
install_vim
install_zsh

