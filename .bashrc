
export EDITOR=nvim

get_git_s () {
	git status 1>/dev/null 2>/dev/null || return 1
	IFS=\n
	gits=$(git status --porcelain)
	[ ${#gits} -eq 0 ] && { echo -n "clean "; return 0; }

	# modified staged files
	M=$(echo $gits | grep -e '^M' | wc -l)
	# modified unstaged files
	m=$(echo $gits | grep -e '^ M' | wc -l)
	# unadded / untracked files
	a=$(echo $gits | grep -e '^??' | wc -l)
	# git added / newly tracking files
	A=$(echo $gits | grep -e '^A' | wc -l)
	# deleted unstaged files
	d=$(echo $gits | grep -e '^ D' | wc -l)
	# deleted staged files
	D=$(echo $gits | grep -e '^D' | wc -l)
	# renamed staged files
	R=$(echo $gits | grep -e '^R' | wc -l)

	mout=$([ $m -gt 0 ] && echo -n m)
	mout=$mout$([ $M -gt 0 ] && echo -n M)
	aout=$([ $a -gt 0 ] && echo -n a)
	aout=$aout$([ $A -gt 0 ] && echo -n A)
	dout=$([ $d -gt 0 ] && echo -n d)
	dout=$dout$([ $D -gt 0 ] && echo -n D)
	rout=$([ $R -gt 0 ] && echo -n R)
	echo -n "$aout$mout$dout$rout "
}

get_git_b () {
	B=$(git branch --show-current 2>/dev/null) && echo "$B "
}

# made with the help of https://bashrcgenerator.com/
# looks like this:
# ╲ username@hostname HH:MM current-directory
# ╱ $ typed command
# and like this when in a git repo's main branch with some staged files:
# ╲ mario@peachmainframe 20:30 bowser-destroyer-hack
# ╱ main AmM $ echo 'mario' > its-me.txt
export PS1="╲ \u@\h \A \[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;14m\]\W\[$(tput sgr0)\]\n╱ \$(get_git_b)\$(get_git_s)\[$(tput sgr0)\]\[\033[38;5;3m\]\\$\[$(tput sgr0)\] \[$(tput sgr0)\]"

# got from https://news.ycombinator.com/item?id=11070797
alias config='/usr/bin/git --git-dir=$HOME/.config.git/ --work-tree=$HOME'

alias gitl='git log --oneline'
alias t='pter ~/docs/notas/todo.txt'
alias te='$EDITOR ~/docs/notas/todo.txt'
alias py='python3'

# default parameters
alias grep='grep --color=auto'
alias ls='ls --color=auto --group-directories-first'

# autorun at the start of every terminal window
when --past=0 --future=3

