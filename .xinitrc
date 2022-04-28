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

