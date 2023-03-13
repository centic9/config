#
#
#
#
#
#
# These settings are handled by the config-project,
# make sure to apply changes there as well
#
#
#
#
#
#

# work around acpid problem, #230110
xhost local:root	# allow root to run X applications

sudo /etc/init.d/acpid restart

xmodmap -e 'keycode 153='
xmodmap -e 'keycode 144='
xmodmap -e 'keycode 164='

setxkbmap -option terminate:ctrl_alt_bksp

# Instruct LibreOffice to use different UI which is much faster
# https://askubuntu.com/questions/1375082/libreoffice-7-2-calc-slow-on-ubuntu-21-10
# https://ask.libreoffice.org/t/calc-and-writer-ver-7-0-are-extremely-slow/58522/5
# https://bugs.launchpad.net/ubuntu/+source/libreoffice/+bug/1940836
export SAL_USE_VCLPLUGIN=qt5
