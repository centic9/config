# Collection of useful aliases and other stuff that I usually adjust in .bashrc

function as_func() {
	apt-cache search $1 | sort
}

function au_func() {
	# also ask Akregator to persist it's database, this is a workaround for bugs
	# https://bugs.kde.org/show_bug.cgi?id=210408
	# https://bugs.kde.org/show_bug.cgi?id=199232
	# https://bugs.kde.org/show_bug.cgi?id=196633
	# https://bugs.kde.org/show_bug.cgi?id=185507
	# I didn't have a better place to put this so it is executed as part of the d-bus session
	#dbus-send --session --dest=org.kde.akregator --type=method_call /Akregator  org.kde.akregator.part.saveSettings

    # Use --allow-releaseinfo-change to accept change of source-settings
	sudo apt-get update "$@" && sudo apt-get dist-upgrade "$@"
}

function _usbmount() {
	#echo "Looking at $1"
	mount $1 2> /dev/null && (echo "Mounting $1 " && nautilus $1 2> /dev/null &)
}

function _usbumount() {
	#echo "Looking at $1"
	mount | grep $1 && (echo "Unmounting $1" && umount $1)
}

function _u_func() {
	geany -l 1 "$@" &
}

function __gradle_func() {
	if [[ -x gradlew ]]
	then
		GRADLE_OPTS="-Xms128m -Xmx400m" nice -n 10 ./gradlew --warning-mode all "$@" | \
  perl -pe'$m|=/BUILD .*SUCCESS/; END {exit!$m}' && \
  (which notify-send > /dev/null && notify-send --icon=face-cool "`basename $(pwd)`: gradle $*" "Build SUCCESS" ; exit 0) || \
  (which notify-send > /dev/null && notify-send --icon=face-crying "`basename $(pwd)`: gradle $*" "Build FAILED" ; exit 1)
	else
		GRADLE_OPTS="-Xms128m -Xmx400m" nice -n 10 gradle --warning-mode all "$@" | \
  perl -pe'$m|=/BUILD .*SUCCESS/; END {exit!$m}' && \
  (which notify-send > /dev/null && notify-send --icon=face-cool "`basename $(pwd)`: gradle $*" "Build SUCCESS" ; exit 0) || \
  (which notify-send > /dev/null && notify-send --icon=face-crying "`basename $(pwd)`: gradle $*" "Build FAILED" ; exit 1)
	fi
}

function __gnome_open_func() {
    # there are different tools for opening files with the
    # associated application, use one that is available or
    # fail if none is found
    OPTION=
    if [[ -x /usr/bin/xdg-open ]]; then
        TOOL=/usr/bin/xdg-open
    elif [[ -x /usr/bin/gio ]]; then
        TOOL=/usr/bin/gio
        OPTION="open"
    elif [[ -x /usr/bin/gnome-open ]]; then
        TOOL=/usr/bin/gnome-open
    elif [[ -x /usr/bin/kde-open ]]; then
        TOOL=/usr/bin/kde-open
    elif [[ -x /usr/bin/kde-open ]]; then
        TOOL=/usr/bin/kde-open5
    elif [[ -x /usr/bin/mimeopen ]]; then
        TOOL=/usr/bin/mimeopen
    else
        echo Did not find any tool for opening file according to their type
        return
    fi

    echo "Using open-tool ${TOOL} ${OPTION}"

	for i in "$@"
	do
		echo ${i}
		${TOOL} ${OPTION} "${i}"
		sleep 1
	done
}

function mplay_func() {
	smplayer "$@"
	# -cache-min 30 -cache 512 "$@"
	# -actions "pl_shuffle true pl_repeat true"
}

alias as="as_func"
alias ap="apt-cache showpkg"
alias ai="sudo apt-get install"
alias au="au_func"
alias lcdoff="xset dpms force off"
alias apo="apt-cache policy"
if [[ `uname --machine` == armv7l || `uname --machine` == armv6l ]];then
  alias u="vi"
else
  alias u="_u_func"
fi
alias iotop="iotop -o -d 5 -P -k"
alias ll="ls -al"
alias mplay="mplay_func"

# git aliases, http://www.catonmat.net/blog/git-aliases/
alias ga='git add'
alias gp='git push'
alias gl='git log'
alias gst='git status'
alias gd='git diff'
alias gdc='git diff --cached'
alias gm='git commit -m'
alias gma='git commit -am'
alias gb='git branch -a'
alias gco='git checkout'
alias gra='git remote add'
alias grr='git remote rm'
alias gpu='git pull'
alias gcl='git clone'
alias svndiff='svn diff --diff-cmd diff -x -uw '
alias iot='sudo iotop -d 30 -o -P -k'
alias ifwatch='sudo watch --differences=cumulative --interval=30 ifconfig'
alias usbmount='for i in b c d e f;do _usbmount /usb$i;done;mount | grep usb'
alias usbumount='for i in a b c d e f;do _usbumount /usb$i;done;mount | grep usb'
alias debuildnew='debuild "-i(.git|.svn|.travis.yml|.idea|cmake-build-debug)" -S -sa'
alias debuildexisting='debuild "-i(.git|.svn|.travis.yml|.idea|cmake-build-debug)" -S -sd'
alias doc='sudo docker'
alias g='__gradle_func'
alias o='__gnome_open_func'
alias git-import-orig='gbp import-orig'
alias git-import-dsc='gbp import-dsc'
alias git-import-dscs='gbp import-dscs'
alias vaml='vi -c "set syntax:yaml" -'
alias vson='vi -c "set syntax:json" -'
alias pg='ps -aux | grep'
alias psm='ps -aef --sort start_time | grep -v lasdasjd ; echo ; echo -n "procs: " ; ps -aef | wc -l ; echo -n "pkgs:  " ; dpkg --list | wc -l ; echo ; df -h --exclude-type=devtmpfs'
alias kc='minikube kubectl --'

# * If on master: gbin branch1 <-- this will show you what's in branch1 and not in master
# * If on master: gbout branch1 <-- this will show you what's in master that's not in branch 1
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

function gbin {
  echo branch \($1\) has these commits and \($(parse_git_branch)\) does not
	  git log ..$1 --no-merges --format='%h | Author:%an | Date:%ad | %s' --date=local
}

function gbout {
  echo branch \($(parse_git_branch)\) has these commits and \($1\) does not
	  git log $1.. --no-merges --format='%h | Author:%an | Date:%ad | %s' --date=local
}

# Raspberry has the JDK in a different directory depending on hardware architecture
if [[ `uname --machine` == "armv7l" || `uname --machine` == "armv6l" ]];then
  export TERM=linux
  export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-armhf
# Raspberry Pi OS 64-bit has a different location for the JVM
elif [[ `uname --machine` == "aarch64" ]];then
  export TERM=linux
  export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-arm64
else
  export TERM=xterm
  export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
fi

# Some tools support using a specific version of Java based on these environment variables
export JAVA_HOME8=/usr/lib/jvm/java-8-openjdk-amd64
export JAVA_HOME11=${JAVA_HOME}
export JAVA_HOME17=/usr/lib/jvm/java-17-openjdk-amd64

export DEBEMAIL=dominik.stadler@gmx.at
export DEBFULLNAME="Dominik Stadler (Ubuntu key)"

# see http://pkg-perl.alioth.debian.org/howto/quilt.html
export QUILT_PATCHES=debian/patches

# color for manpages, see http://tuxarena.blogspot.com/2009/06/6-bash-productivity-tips.html
export LESS_TERMCAP_mb=$'\E[01;31m' # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m' # begin bold
export LESS_TERMCAP_me=$'\E[0m' # end mode
export LESS_TERMCAP_se=$'\E[0m' # end standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m' # begin standout-mode - info box export LESS_TERMCAP_ue=$'\E[0m' # end underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline

wiki() { dig +short txt $1.wp.dg.cx; }
memtop() { ps aux | sort -nk +4 | tail; }

# somehow this did include spansish es_ES?!
export LANGUAGE="de_AT:de"
export LANG=de_AT.UTF-8

export EDITOR=vi

# Set default Keyboard click speed
# https://askubuntu.com/questions/846030/how-to-set-keyboard-repeat-delay-and-speed-in-ubuntu-gnome-16-10
if [ -e /usr/bin/gsettings ]; then
    # we can only perform this if the schema is available
    /usr/bin/gsettings list-schemas | grep org.gnome.desktop.peripherals.keyboard > /dev/null
    RET=$?
    if [ ${RET} -eq 0 ]; then
	    /usr/bin/gsettings set org.gnome.desktop.peripherals.keyboard repeat-interval 25
	    /usr/bin/gsettings set org.gnome.desktop.peripherals.keyboard delay 200
	fi
fi

# Try to disable visible bell from popping up or changing things like the konsole taskbar icon
# See https://www.ibiblio.org/pub/Linux/docs/HOWTO/Visual-Bell for more details
set bell-style none

# See
# https://askubuntu.com/questions/67283/is-it-possible-to-make-writing-to-bash-history-immediate
# https://unix.stackexchange.com/questions/1288/preserve-bash-history-in-multiple-terminal-windows

# Avoid duplicates and set larger history size
export HISTCONTROL=ignoredups:erasedups  # no duplicate entries
export HISTSIZE=100000                   # big big history
export HISTFILESIZE=100000               # big big history

# keep history from all terminal windows
shopt -s histappend

# immediately persist history after each command
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"
