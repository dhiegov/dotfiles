
export EDITOR=nvim

get_git_b () {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1 /'
}

# made with the help of https://bashrcgenerator.com/
export PS1="\\ \u@\h [\A] \[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;14m\]\W\[$(tput sgr0)\]\n/ \$(get_git_b)\[$(tput sgr0)\]\[\033[38;5;3m\]\\$\[$(tput sgr0)\] \[$(tput sgr0)\]"

# got from https://news.ycombinator.com/item?id=11070797
alias config='/usr/bin/git --git-dir=$HOME/.config.git/ --work-tree=$HOME'

alias t='pter ~/docs/notas/todo.txt'
alias te='$EDITOR ~/docs/notas/todo.txt'
alias py='python3'

# default parameters
alias ls='ls --color=auto --group-directories-first'

