#
# ~/.bashrc
#

export XDG_CONFIG_HOME=~/.config

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ll='ls -la --color=auto'
alias grep='grep --color=auto'

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# Single line prompt with no eval or complex logic
PS1='\[\033[31m\]$([[ $? != 0 ]] && echo "[$?] ")\[\033[0m\][\[\033[37m\]\u\[\033[0m\]@\[\033[34m\]\h\[\033[0m\]:\[\033[37m\]\w\[\033[0m\]\[\033[32m\]$(parse_git_branch)\[\033[0m\]]$ '
