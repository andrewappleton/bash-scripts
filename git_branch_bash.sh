#!/bin/bash

export CLICOLOR=1
NORMAL="\[\033[00m\]"
BLUE="\[\033[01;34m\]"
YELLOW="\[\e[1;33m\]"
GREEN="\[\e[1;32m\]"
REVYELLOW="\[\033[43m\]"
PS1USER=`echo $USER | tr '[:upper:]' '[:lower:]'`
PS1HOST=`echo $HOSTNAME | tr '[:upper:]' '[:lower:]'`
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ [\1]/'
}
export PS1="${GREEN}${PS1USER}@${PS1HOST}:${BLUE}\W${YELLOW}\$(parse_git_branch)${NORMAL} $ "
