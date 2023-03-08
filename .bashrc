
export EDITOR=nvim

# get git status summary
#
# Outputs a short string which indicates if there are
# any files which have been modified (m/M); created, but
# yet untracked (a/A); deleted (d/D) or renamed (R).
# Capital letters indicate the corresponding change has
# been staged and is ready to be committed.
#
# It's meant to be used as part of PS1, as a way of showing
# that a git command had an effect or simply that the
# working tree is in a (un)clean state.
#
get_git_s () {
	IFS=\n
	gits=$(git status --porcelain 2>/dev/null) || return 1

	[ ${#gits} -eq 0 ] && { echo -n "clean "; return 0; }

	# modified staged files
	echo $gits | grep -e '^M' 1>/dev/null; M=$?
	# modified unstaged files
	echo $gits | grep -e '^.M' 1>/dev/null; m=$?
	# unadded / untracked files
	echo $gits | grep -e '^??' 1>/dev/null; a=$?
	# git added / newly tracking files
	echo $gits | grep -e '^A' 1>/dev/null; A=$?
	# deleted unstaged files
	echo $gits | grep -e '^ D' 1>/dev/null; d=$?
	# deleted staged files
	echo $gits | grep -e '^D' 1>/dev/null; D=$?
	# renamed staged files
	echo $gits | grep -e '^R' 1>/dev/null; R=$?

	mout=$([ $m -eq 0 ] && echo -n m)$([ $M -eq 0 ] && echo -n M)
	aout=$([ $a -eq 0 ] && echo -n a)$([ $A -eq 0 ] && echo -n A)
	dout=$([ $d -eq 0 ] && echo -n d)$([ $D -eq 0 ] && echo -n D)
	rout=$([ $R -eq 0 ] && echo -n R)
	echo -n "$aout$mout$dout$rout "
}

get_git_b () {
	B=$(git branch --show-current 2>/dev/null) && echo "$B "
}

uhostname=$(cat ~/.config/usual-hostname 2>/dev/null) || \
	echo -e "Usual hostname not configured. Add it to ~/.config/usual-hostname\
 to omit it from your prompt when you're at your usual machine."
get_hostname () {
	[ $(hostname) = "${uhostname}" ] || echo "@$(hostname)"
}

# made with the help of https://bashrcgenerator.com/
#
# looks like this:
# ❮ username@hostname HH:MM current-directory ❯ typed command
#
# and like this when in a git repo's main branch with some staged files:
# ❮ mario@peachmainframe 20:30 bowser-destroyer-hack main AmM ❯ echo 'mario' > its-me.txt
#
export PS1="\[\033[38;5;3m\]❮\[$(tput sgr0)\] \u\$(get_hostname) \A \[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;14m\]\W\[$(tput sgr0)\] \$(get_git_b)\$(get_git_s)\[$(tput sgr0)\]\[\033[38;5;3m\]❯\[$(tput sgr0)\] "

# got from https://news.ycombinator.com/item?id=11070797
alias config='/usr/bin/git --git-dir=$HOME/.config.git/ --work-tree=$HOME'

alias gitl='git log --oneline'
alias gits='git status --short'
alias t='pter ~/docs/notas/todo.txt'
alias te='$EDITOR ~/docs/notas/todo.txt'
alias py='python3'

# default parameters
alias grep='grep --color=auto --ignore-case'
alias ls='ls --human-readable --color=auto --group-directories-first'

[ -f .bashrc_private ] && source .bashrc_private

# autorun at the start of every terminal window
when --past=0 --future=3

