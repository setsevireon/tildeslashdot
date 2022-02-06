# Keeping dotfiles in a git bare repository

	git init --bare $HOME/.tildeslashdot
	git config --global alias.dot '!git --git-dir=$HOME/.tildeslashdot --work-tree=$HOME'
