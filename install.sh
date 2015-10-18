#!/bin/sh

test -L ~/.bash_aliases && mv ~/.bash_aliases /tmp/.bash_aliases.sav
ln -sf `pwd`/.bash_aliases ~/

test -L ~/.xinitrc && mv ~/.xinitrc /tmp/.xinitrc.sav
ln -sf `pwd`/.xinitrc ~/

test -L ~/.Xmodmap && mv ~/.Xmodmap /tmp/.Xmodmap.sav
ln -sf `pwd`/.Xmodmap ~/

test -L ~/.toprc && mv ~/.toprc /tmp/.toprc.sav
ln -sf `pwd`/.toprc ~/

test -L ~/.gitconfig && mv ~/.gitconfig /tmp/.gitconfig.sav
ln -sf `pwd`/.gitconfig ~/
