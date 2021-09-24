#!/bin/bash

sudo apt-get install tmux dc bc sensors

TAR_SCRIPT="`pwd`/tmux-functions.sh"
DES_SCRIPT="$HOME/.tmux-functions.sh"

TAR_TMUX="`pwd`/.tmux.conf"
DES_TMUX="$HOME/.tmux.conf"

[ ! -e ${DES_SCRIPT} ] && (echo "ln -s ${TAR_SCRIPT} ${DES_SCRIPT}" && ln -s ${TAR_SCRIPT} ${DES_SCRIPT} && echo "Create symlink") || echo "symlink (~/.tmux-functions) already exists" 

rm -rf "${HOME}/.tmux.conf"
cp ${TAR_TMUX} ${DES_TMUX} && echo "Generated .tmux.conf file"