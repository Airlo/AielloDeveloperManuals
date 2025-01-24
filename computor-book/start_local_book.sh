#!/bin/zsh
# -*- coding: UFT-8 -*-
#################################################
# File Name: &
# Autor: Pan Xiangyu
# Created Time: Mon 03 Jul 2023 09:47:10 AM CST
#################################################
#
export TIANTIBOOK=$HOME/Developer_Manuals/computor-book
touch ${TIANTIBOOK}
cd ${TIANTIBOOK}
mdbook serve --open;
# exit 0
