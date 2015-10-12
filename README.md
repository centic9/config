Small helper project which stores some config-files that I would like to have on every machine that I work on

## How to use

    git clone https://github.com/centic9/config.git
    cd config
    ./install.sh

This will add some links so that e.g. .bashrc loads additional aliases and other definitions that I found useful.


## Todo

### Git Config

    git config --global alias.co checkout
    git config --global alias.br branch
    git config --global alias.ci commit
    git config --global alias.st status
    git config --global user.name "John Doe"
    git config --global user.email johndoe@example.com

### Liquidprompt

https://github.com/nojhan/liquidprompt

    cd
    git clone https://github.com/nojhan/liquidprompt.git
    echo "# Only load Liquid Prompt in interactive shells, not from a script or from scp" > ~/.bashrc
    echo "[[ $- = *i* ]] && source ~/liquidprompt/liquidprompt" > ~/.bashrc

### Packages to install

    sudo add-apt-repository ppa:webupd8team/java
    sudo add-apt-repository ppa:cwchien/gradle
    sudo add-apt-repository ppa:git-core/ppa
    sudo add-apt-repository ppa:webupd8team/atom
    sudo add-apt-repository ppa:dominik-stadler/subversion-1.9
    sudo dpkg --add-architecture i386
    sudo add-apt-repository "deb http://archive.canonical.com/ $(lsb_release -sc) partner"
    sudo apt-get update
    gksu gdebi subversion gradle firefox ant oracle-java8-installer oracle-java8-set-default skype git git-svn gitk geany synaptic build-essential linux-headers-generic synaptic rsync putty ssh libgnome2-bin atom dos2unix iotop wget curl
