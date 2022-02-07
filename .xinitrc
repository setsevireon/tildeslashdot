#!/bin/sh

[ -f /etc/X11/Xsession ] && . /etc/X11/Xsession

exec /usr/bin/awesome \
	>>"${XDG_CACHE_HOME:-$HOME/.cache}/awesome/stdout" \
	2>>"${XDG_CACHE_HOME:-$HOME/.cache}/awesome/stderr"
