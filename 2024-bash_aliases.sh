function parse_git_dirty {
  [[ $(git status --porcelain 2> /dev/null) ]] && echo " *"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/ (\1$(parse_git_dirty))/"
}
export PS1="\[$(tput setaf 33)\]\u\[$(tput setaf 69)\]@\[$(tput setaf 105)\]\h \[$(tput setaf 141)\]\W\[$(tput setaf 226)\]\$(parse_git_branch) \[$(tput sgr0)\]$ "
