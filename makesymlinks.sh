#!/bin/bash
############################
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/dotfiles                    # dotfiles directory
olddir=~/.dotfiles_old             # old dotfiles backup directory
# list of files/folders to symlink in homedir
files="bashrc p10k.zsh tmux.conf vimrc zshrc"    


########## Options
while [ -n "$1" ]; do # while loop over all options
	case "$1" in
	
	-D) echo "-d option passed" 
		for file in $files; do
			echo "Removing $file from home directory."
			rm ~/.$file
		done
		echo "copying .files back from $olddir"
		cp -a $olddir/. ~/
		# rm ~/.vim/pack/typescript/* -rf
		exit 0
		;;	

    -*) echo "Option $1 not recognized"
		exit 127
   		;;

    esac

shift

done




##########

# create dotfiles_old in homedir
echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
mkdir -p $olddir
echo "done"

# change to the dotfiles directory
echo -n "Changing to the $dir directory ..."
cd $dir
echo "done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
for file in $files; do
	echo "checking for $file in ~"
    if [ -f ~/."$file" ]; then
       echo "Moving $file to $olddir"
       mv ~/.$file $olddir/
    fi
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done


install_vim () {
# install vim extensions
if [ -f /usr/bin/vim ]; then
    # if vim installed
    git clone https://github.com/leafgarland/typescript-vim.git ~/.vim/pack/typescript/start/typescript-vim
else 
    # no vim installed	
    sudo apt-get install vim
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
    # If zsh isn't installed, get the platform of the current machine
    platform=$(uname);
    sudo apt-get install zsh
	chsh -s $(which zsh)
fi
}

install_zsh_extra () {
# install zsh extensions
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.zsh/powerlevel10k
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
}

install_vim
install_zsh
install_zsh_extra

