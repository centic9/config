#!/bin/sh

test -L ~/.bash_aliases && rm ~/.bash_aliases
ln -sf `pwd`/.bash_aliases ~/

test -L ~/.xinitrc && rm ~/.xinitrc
ln -sf `pwd`/.xinitrc ~/

test -L ~/.Xmodmap && rm ~/.Xmodmap
ln -sf `pwd`/.Xmodmap ~/

test -L ~/.toprc && rm ~/.toprc
ln -sf `pwd`/.toprc ~/
