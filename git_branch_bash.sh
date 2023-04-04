#!/bin/bash
NORMAL="\[\033[00m\]"
BLUE="\[\033[01;34m\]"
YELLOW="\[\e[1;33m\]"
GREEN="\[\e[1;32m\]"
REVYELLOW="\[\033[43m\]"
PS1USER=`echo $USER | tr '[:upper:]' '[:lower:]'`
PS1HOST=`echo $HOSTNAME | tr '[:upper:]' '[:lower:]'`
function parse_git_dirty() {
  [[ $(git status --porcelain 2> /dev/null) ]] && echo " *"
}
function parse_git_branch() {
     git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/ [\1$(parse_git_dirty)]/"
}
export PS1="${GREEN}${PS1USER}@${PS1HOST}:${BLUE}\W${YELLOW}\$(parse_git_branch)${NORMAL} $ "
