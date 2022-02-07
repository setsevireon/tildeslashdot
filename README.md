# Keeping dotfiles in a git bare repository

## Starting

First initialize a bare repo.

	git init --bare $HOME/.tildeslashdot

Set a git alias so we don't have to write git-dir and work-tree every time.

	git config --global alias.dot '!git --git-dir=$HOME/.tildeslashdot --work-tree=$HOME'

Do not show untracked file.

	git dot config --local status.showUntrackedFiles no

## Migrating

Clone the repo.

	git clone --bare https://bitbucket.org/setsevireon/tildeslashdot $HOME/.tildeslashdot

Set a git alias so we don't have to write git-dir and work-tree every time.

	git config --global alias.dot '!git --git-dir=$HOME/.tildeslashdot --work-tree=$HOME'

Checkout.

	git dot checkout
