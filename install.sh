#!/bin/sh

test -L ~/.bash_aliases && mv ~/.bash_aliases /tmp/.bash_aliases.sav
ln -sf `pwd`/.bash_aliases ~/

test -L ~/.dput.cf && mv ~/.dput.cf /tmp/.dput.cf.sav
ln -sf `pwd`/.dput.cf ~/

test -L ~/.xinitrc && mv ~/.xinitrc /tmp/.xinitrc.sav
ln -sf `pwd`/.xinitrc ~/

test -L ~/.Xmodmap && mv ~/.Xmodmap /tmp/.Xmodmap.sav
ln -sf `pwd`/.Xmodmap ~/

test -L ~/.toprc && mv ~/.toprc /tmp/.toprc.sav
ln -sf `pwd`/.toprc ~/

mkdir -p ~/.config/procps
test -L ~/.config/procps/toprc && mv ~/.config/procps/toprc /tmp/toprc.sav
ln -sf `pwd`/.toprc ~/.config/procps/toprc

test -L ~/.gitconfig && mv ~/.gitconfig /tmp/.gitconfig.sav
ln -sf `pwd`/.gitconfig ~/

test -L ~/.gitk && mv ~/.gitk /tmp/.gitk.sav
ln -sf `pwd`/.gitk ~/

test -L ~/.Rprofile && mv ~/.Rprofile /tmp/.Rprofile.sav
ln -sf `pwd`/.Rprofile ~/

test -L ~/.xbindkeysrc && mv ~/.xbindkeysrc /tmp/.xbindkeysrc.sav
ln -sf `pwd`/.xbindkeysrc ~/

test -L ~/.gnomerc && mv ~/.gnomerc /tmp/.gnomerc.sav
ln -sf `pwd`/.gnomerc ~/
