
export EDITOR=nvim

get_git_s () {
	IFS=\n
	gits=$(git status --porcelain 2>/dev/null) || return 1

	[ ${#gits} -eq 0 ] && { echo -n "clean "; return 0; }

	# modified staged files
	echo $gits | grep -e '^M' 1>/dev/null
	M=$?
	# modified unstaged files
	echo $gits | grep -e '^ M' 1>/dev/null
	m=$?
	# unadded / untracked files
	echo $gits | grep -e '^??' 1>/dev/null
	a=$?
	# git added / newly tracking files
	echo $gits | grep -e '^A' 1>/dev/null
	A=$?
	# deleted unstaged files
	echo $gits | grep -e '^ D' 1>/dev/null
	d=$?
	# deleted staged files
	echo $gits | grep -e '^D' 1>/dev/null
	D=$?
	# renamed staged files
	echo $gits | grep -e '^R' 1>/dev/null
	R=$?

	mout=$([ $m -eq 0 ] && echo -n m)
	mout=$mout$([ $M -eq 0 ] && echo -n M)
	aout=$([ $a -eq 0 ] && echo -n a)
	aout=$aout$([ $A -eq 0 ] && echo -n A)
	dout=$([ $d -eq 0 ] && echo -n d)
	dout=$dout$([ $D -eq 0 ] && echo -n D)
	rout=$([ $R -eq 0 ] && echo -n R)
	echo -n "$aout$mout$dout$rout "
}

get_git_b () {
	B=$(git branch --show-current 2>/dev/null) && echo "$B "
}

# made with the help of https://bashrcgenerator.com/
# looks like this:
# ╱ username@hostname HH:MM current-directory
# ╲ $ typed command
# and like this when in a git repo's main branch with some staged files:
# ╱ mario@peachmainframe 20:30 bowser-destroyer-hack
# ╲ main AmM $ echo 'mario' > its-me.txt
export PS1="╱ \u@\h \A \[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;14m\]\W\[$(tput sgr0)\]\n╲ \$(get_git_b)\$(get_git_s)\[$(tput sgr0)\]\[\033[38;5;3m\]\\$\[$(tput sgr0)\] \[$(tput sgr0)\]"

# got from https://news.ycombinator.com/item?id=11070797
alias config='/usr/bin/git --git-dir=$HOME/.config.git/ --work-tree=$HOME'

alias gitl='git log --oneline'
alias gits='git status --short'
alias t='pter ~/docs/notas/todo.txt'
alias te='$EDITOR ~/docs/notas/todo.txt'
alias py='python3'

# default parameters
alias grep='grep --color=auto --ignore-case'
alias ls='ls --color=auto --group-directories-first'

# autorun at the start of every terminal window
when --past=0 --future=3

