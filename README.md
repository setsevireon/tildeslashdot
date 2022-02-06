# Keeping dotfiles in a git bare repository

## Starting

	# first initialize a bare repo
	git init --bare $HOME/.tildeslashdot
	# set a git alias so we don't have to write git-dir and work-tree every time
	git config --global alias.dot '!git --git-dir=$HOME/.tildeslashdot --work-tree=$HOME'
	# do not show untracked file
	git dot config --local status.showUntrackedFiles no

## Migrating

	# clone the repo
	git clone --bare https://bitbucket.org/setsevireon/tildeslashdot $HOME/.tildeslashdot
	# set a git alias so we don't have to write git-dir and work-tree every time
	git config --global alias.dot '!git --git-dir=$HOME/.tildeslashdot --work-tree=$HOME'
	git dot checkout
