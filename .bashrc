# ~/.bashrc
#
# Author: Carlos Marx <me@carlosmarx.com>
# Last updated: 2022-02-06
# ------------------------------------------------------------------------------

# If not running interactively, don't do anything
[[ -x "$PS1" ]] && return

################################################################################
# Remove a directory from PATH
# Globals:
#   PATH
# Arguments:
#   $1 - dir to be removed
################################################################################
function remove_from_path() {
	dir2rm=${1}

	PATH=:$PATH:
	PATH=${PATH//:${dir2rm}:/:}
	PATH=${PATH#:}
	PATH=${PATH%:}

	export PATH
}

################################################################################
# Print PATH line by line, sorted and with unique entries
# Globals:
#   PATH
# Arguments:
#   None
################################################################################
function print_path() {
	echo "${PATH//:/$'\n'}" | sort | uniq
}

################################################################################
# Basic configuration: history, prompt, path, default applications
# Globals:
#   HISTCONTROL
#   HISTSIZE
#   HISTFILESIZE
# Arguments:
#   None
################################################################################
function config_defaults() {
	# history
	shopt -s histappend
	HISTCONTROL=ignoreboth
	HISTSIZE=10000
	HISTFILESIZE=100000
	PROMPT_COMMAND="history -a; history -c; history -r; ${PROMPT_COMMAND}"

	# check window size conrtinuously
	shopt -s checkwinsize

	# prompt
	if [[ -x /usr/bin/tput ]] && [[ $(tput colors) == "256" ]]; then
		PS1="[\[\e[33m\]\w\[\e[m\]]\[\e[32m\]->\[\e[m\] "
	else
		PS1='[\w]-> '
	fi

	# path: ~/.local/bin
	export PATH=${HOME}/.local/bin:${PATH}

	# default applications
	[[ -x "$(which nvim)" ]] && export EDITOR=nvim
}

################################################################################
# Aliases
# Globals:
#   None
# Arguments:
#   $1: "unalias"
# shellcheck disable=SC2120
################################################################################
function config_aliases() {
	if [[ "$1" == "unalias" ]]; then
		unalias ls dir vdir grep fgrep ll la cp rm mv paths
		return
	fi

	alias ls='ls --color=auto'
	alias dir='dir --color=auto'
	alias vdir='vdir --color=auto'
	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'

	alias ll='ls -l --group-directories-first'
	alias la='ll -A'
	alias cp='cp --interactive --verbose --reflink=auto'
	alias rm='rm --interactive=once --verbose'
	alias mv='mv --interactive --verbose'
}

################################################################################
# Bash completion
# Globals:
#   None
# Arguments:
#   None
################################################################################
function config_completion() {
	if [[ -f /usr/share/bash-completion/bash_completion ]]; then
		source /usr/share/bash-completion/bash_completion
	elif [[ -f /etc/bash_completion ]]; then
		source /etc/bash_completion
	fi
}

################################################################################
# Setup environment for Homebrew
# Globals:
#   PATH
#   HOMEBREW_PREFIX
# Arguments:
#   $1 - prefix or "unset" | default = /home/linuxbrew/.linuxbrew
# shellcheck disable=SC2120
################################################################################
function config_homebrew() {
	if [[ "$1" == "unset" ]]; then
		remove_from_path "${HOMEBREW_PREFIX}/bin"
		remove_from_path "${HOMEBREW_PREFIX}/sbin"
		return
	fi

	export HOMEBREW_PREFIX="${1:-/home/linuxbrew/.linuxbrew}"
	export HOMEBREW_CELLAR="${HOMEBREW_PREFIX}/Cellar"
	export HOMEBREW_REPOSITORY="${HOMEBREW_PREFIX}/Homebrew"
	export PATH="${HOMEBREW_PREFIX}/bin:${HOMEBREW_PREFIX}/sbin${PATH+:$PATH}"
	export MANPATH="${HOMEBREW_PREFIX}/share/man${MANPATH+:$MANPATH}:"
	export INFOPATH="${HOMEBREW_PREFIX}/share/info:${INFOPATH:-}"
}

################################################################################
# Setup environment for Golang
# Globals:
#   HOME
#   PATH
#   GOPATH
# Arguments:
#   $1 - goroot or "unset" | default = /usr/local/go
#   $2 - gopath | default = ${HOME}/.local/share/go
# shellcheck disable=SC2120
################################################################################
function config_go() {
	if [[ "$1" == "unset" ]]; then
		remove_from_path "${GOROOT}/bin"
		remove_from_path "${GOPATH}/bin"
		return
	fi

	export GOROOT=${1:-/usr/local/go}
	export GOPATH=${2:-${HOME}/.local/share/go}
	export PATH=${PATH}:${GOROOT}/bin:${GOPATH}/bin
}

################################################################################
# Setup environment for Rust
# Globals:
#   HOME
#   PATH
#   GOPATH
# Arguments:
#   $1 - prefix or "unset" | default = ~/.cargo
# shellcheck disable=SC2120
################################################################################
function config_rust() {
	if [[ "$1" == "unset" ]]; then
		remove_from_path "${CARGO_HOME}/bin"
		return
	fi

	export CARGO_HOME="${1:-${HOME}/.cargo}"
	export PATH="${CARGO_HOME}/bin:${PATH}"
}

################################################################################
# Setup environment for PHP
# Globals:
#   HOME
#   PATH
# Arguments:
#   $1 - "unset" (optional)
# shellcheck disable=SC2120
################################################################################
function config_php() {
	if [[ "$1" == "unset" ]]; then
		remove_from_path "${HOME}/.config/composer/vendor/bin"
		return
	fi

	export PATH+=":${HOME}/.config/composer/vendor/bin"
}

################################################################################
# Setup environment for Python
# Globals:
#   HOME
#   PATH
# Arguments:
#   $1 - "unset" (optional)
# shellcheck disable=SC2120
################################################################################
function config_pyton() {
	if [[ "$1" == "unset" ]]; then
		remove_from_path "${PYENV_ROOT}/bin:${PATH}"
		return
	fi

	export PYENV_ROOT="${HOME}/.pyenv"
	command -v pyenv >/dev/null || export PATH="${PYENV_ROOT}/bin:${PATH}"
	eval "$(pyenv init -)"

}


# main -------------------------------------------------------------------------
config_defaults
config_aliases
config_completion
config_homebrew
config_go
config_rust
config_php
config_pyton
