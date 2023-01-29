
export EDITOR=nvim

get_git_b () {
	B=$(git branch --show-current 2>/dev/null) && echo "$B "
}

# made with the help of https://bashrcgenerator.com/
# looks like this:
# \ username@hostname [HH:MM] current-directory
# / $ typed command
# and like this when in a git repo's main branch:
# \ mario@peachmainframe [20:30] bowser-destroyer-hack
# / main $ echo 'mario' > its-me.txt
export PS1="\\ \u@\h [\A] \[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;14m\]\W\[$(tput sgr0)\]\n/ \$(get_git_b)\[$(tput sgr0)\]\[\033[38;5;3m\]\\$\[$(tput sgr0)\] \[$(tput sgr0)\]"

# got from https://news.ycombinator.com/item?id=11070797
alias config='/usr/bin/git --git-dir=$HOME/.config.git/ --work-tree=$HOME'

alias t='pter ~/docs/notas/todo.txt'
alias te='$EDITOR ~/docs/notas/todo.txt'
alias py='python3'

# default parameters
alias grep='grep --color=auto'
alias ls='ls --color=auto --group-directories-first'

# autorun at the start of every terminal window
when --past=0 --future=2

