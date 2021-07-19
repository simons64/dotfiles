#!/bin/bash
# This script creates symlinks from the home directory to any desired dotfiles in ~/.dotfiles

DOTF_DIR=~/.dotfiles
BACKUP_DIR=~/.backup

# list of .dotfiles 
files=".bashrc .p10k.zsh .tmux.conf .vimrc .zshrc"    

while [ -n "$1" ]; do
	case "$1" in

	# revert changes with -d flag
	-D) echo "removing symlinks from ~"
		for file in $files; do
			echo "rm ~/$file"
			rm ~/$file
		done
		echo "copying .files back from $BACKUP_DIR"
		cp -a $BACKUP_DIR/. ~/
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
# change to the dotfiles directory
cd ~

# move existing dotfiles => $BACKUP_DIR
# create symlinks for dotfiles 
for file in $files; do
    echo "checking for $file in ~"
    if [ -f "${file}" ]; then
       echo "mv existing file to .backup"
       mv ~/$file $BACKUP_DIR
    fi
    if [ -L "${file}" ]; then 
       echo "rm old symlink"
	   rm ~/$file
    fi
    echo "creating symlink to $file in home directory."
    ln -s $DOTF_DIR/$file ~/$file
done


install_vim () {
	# install vim extensions
	if [ -f /usr/bin/vim ]; then
		echo "vim is installed"
	else 
		sudo apt-get install vim
	fi

	git clone https://github.com/leafgarland/typescript-vim.git ~/.vim/pack/typescript/start/typescript-vim
	git clone https://github.com/vim-airline/vim-airline ~/.vim/pack/dist/start/vim-airline
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

	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.zsh/powerlevel10k
	git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
}
 
install_vim
install_zsh

