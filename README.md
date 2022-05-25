Small helper project which stores some config-files that I would like to have on every machine that I work on.

## How to use

    sudo apt-get install git
    git clone https://github.com/centic9/config.git
    cd config
    ./install.sh

This will add some links so that e.g. `.bashrc` loads additional aliases and other definitions that I found useful.

## Todo

### Git Config

    git config --global alias.br branch

### Liquidprompt

Liquidprompt provides an adaptive prompt, see https://github.com/nojhan/liquidprompt

Install it manually via:

    cd
    git clone https://github.com/nojhan/liquidprompt.git
    echo "# Only load Liquid Prompt in interactive shells, not from a script or from scp" >> ~/.bashrc
    echo "[[ $- = *i* ]] && source ~/liquidprompt/liquidprompt" >> ~/.bashrc
