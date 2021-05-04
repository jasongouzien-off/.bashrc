###################################################
# .Bashrc - by : Jason Gouzien - Copyleft : 2021. #
###################################################
# Date de création     : 02-05-2021.              #
# Date de modification : 02-05-2021.              #
###################################################

# Ne pas dupliquer de ligne où celles qui commencent par "espace".
HISTCONTROL=ignoreboth

# If not running interactively, don't do anything
case $- in
    *i*)        ;;
      *) return ;;
esac

# Source global definitions
if [ -f /etc/bashrc ] ; then
    . /etc/bashrc
fi

# PS1 de customisation de : [user@host]-[dir]
# UID 0 is the root user :
# if [[ $(id -u) -eq 0 ]] ; then
    # PS1 si le shell est exécuté en "root".
    # PS1='[\u]@[\h]-[\W] \\$'
    PS1="\[\033[0;31m\]\342\224\214\342\224\200\$([[ \$? != 0 ]] && echo \"[\[\033[0;31m\]\342\234\227\[\033[0;37m\]]\342\224\200\")[$(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]root\[\033[01;33m\]@\[\033[01;96m\]\h'; else echo '\[\033[0;39m\]\u\[\033[01;33m\]@\[\033[01;96m\]\h'; fi)\[\033[0;31m\]]\342\224\200[\[\033[0;32m\]\w\[\033[0;31m\]]\n\[\033[0;31m\]\342\224\224\342\224\200\342\224\200\342\225\274 \[\033[0m\]\[\e[01;33m\]\\$\[\e[0m\]"
# else
    # PS1 si le shell est exécuté en "user".
    # PS1='[\u]@[\h]-[\W] \\$'
    PS1="\[\033[0;31m\]\342\224\214\342\224\200\$([[ \$? != 0 ]] && echo \"[\[\033[0;31m\]\342\234\227\[\033[0;37m\]]\342\224\200\")[$(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]root\[\033[01;33m\]@\[\033[01;96m\]\h'; else echo '\[\033[0;39m\]\u\[\033[01;33m\]@\[\033[01;96m\]\h'; fi)\[\033[0;31m\]]\342\224\200[\[\033[0;32m\]\w\[\033[0;31m\]]\n\[\033[0;31m\]\342\224\224\342\224\200\342\224\200\342\225\274 \[\033[0m\]\[\e[01;33m\]\\$\[\e[0m\]"
# fi

# Option pour ajouter à l'historique sans écraser le fichier.
shopt -s histappend

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ] ; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# Set 'man' colors
if [ "$color_prompt" = yes ]; then
	man() {
	env \
	LESS_TERMCAP_mb=$'\e[01;31m' \
	LESS_TERMCAP_md=$'\e[01;31m' \
	LESS_TERMCAP_me=$'\e[0m' \
	LESS_TERMCAP_se=$'\e[0m' \
	LESS_TERMCAP_so=$'\e[01;44;33m' \
	LESS_TERMCAP_ue=$'\e[0m' \
	LESS_TERMCAP_us=$'\e[01;32m' \
	man "$@"
	}
fi

unset color_prompt force_color_prompt

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ] ; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix ; then
  if [ -f /usr/share/bash-completion/bash_completion ] ; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ] ; then
    . /etc/bash_completion
  fi
fi

export PATH=/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/usr/share/games:/usr/local/sbin:/usr/sbin:/sbin:~/.local/bin:/snap/bin:$PATH

#########################
#      UTILITAIRES      #
#########################


# Send command output to qbin.io for quick & easy sharing (stored for 14 days)
# Utilisation : echo "Hello World" | qbin
alias qbin="curl https://qbin.io -s -T -"

# Générateur de mot de passe :
# Utilisation : pw-gen, puis un nombre de caractères.
function pw-gen()
{
	echo -n "Longeur du mot de passe (caractères) : "
	read input_value
	cat /dev/urandom | tr -dc 'a-zA-Z0-9!@#$%^&*()_+?><~\`;' | fold -w $input_value | head -n 1
}
