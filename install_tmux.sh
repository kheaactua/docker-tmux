#!/bin/bash

function install_tmux() {
	local -r prefix="$1"
	local -r tag="$2"

	# Get the source:
	if [[ ! -d "${INSTALL_PREFIX}/src/tmux" ]]; then
		mkdir -p "${INSTALL_PREFIX}/src"
		cd "${INSTALL_PREFIX}/src"
		git clone https://github.com/tmux/tmux.git
	fi

	cd "${prefix}/src/tmux"
	git reset --hard
	git fetch origin
	git checkout "${tag}"
	git pull

	sh autogen.sh                          \
		&& ./configure --prefix="${prefix}" \
		&& make                             \
		&& make install
}

install_tmux "${INSTALL_PREFIX}" "${TMUX_TAG}"

# vim: ts=3 sw=3 sts=0 noet :
