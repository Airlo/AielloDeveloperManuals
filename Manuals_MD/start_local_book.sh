#!/bin/zsh
# -*- coding: UFT-8 -*-
#################################################
# File Name: &
# Autor: Pan Xiangyu
# Created Time: Mon 03 Jul 2023 09:47:10 AM CST
#################################################
#
SCRIPT_DIR=`dirname "$0"`
LOCALBOOK=`cd $SCRIPT_DIR && pwd`

source $HOME/.cargo/env
touch ${LOCALBOOK}
# cd ${LOACLBOOK}

mdbook serve ${LOCALBOOK} -n 0.0.0.0 -p 3001
exit 0
