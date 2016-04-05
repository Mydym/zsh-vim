# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# colors & char ########################################################
# text normal colors
black='\e[0;39m'
white='\e[0;38m'
red='\e[0;31m'
blue='\e[0;34m'
cyan='\e[0;36m'
green='\e[0;32m'
yellow='\e[0;33m'
# text bright colors
bred='\e[0;91m'
bblue='\e[0;94m'
bcyan='\e[0;96m'
bgreen='\e[0;92m'
byellow='\e[0;93m'
bwhite='\e[0;97m'
# reset color
NC='\e[0m'

# alias ################################################################
# ls & grep ------------------------------------------------------------
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
# cd & goto ------------------------------------------------------------
alias cd..='cd ..'
alias ...='cd ..'
alias ....='cd ../..'
# end of alias #########################################################

# functions ############################################################
# archives -------------------------------------------------------------
# extract
function extract()      
{
     if [ -f $1 ] ; then
         case $1 in
             *.tar.bz2)   tar xvjf $1     ;;
             *.tar.gz)    tar xvzf $1     ;;
             *.bz2)       bunzip2 $1      ;;
             *.rar)       unrar x $1      ;;
             *.gz)        gunzip $1       ;;
             *.tar)       tar xvf $1      ;;
             *.tbz2)      tar xvjf $1     ;;
             *.tgz)       tar xvzf $1     ;;
             *.zip)       unzip $1        ;;
             *.Z)         uncompress $1   ;;
             *.7z)        7z x $1         ;;
             *.xz)        unxz $1         ;;
             *)           echo "'$1' ne peut etre extrait via >extract<" ;;
         esac
     else
         echo "'$1' n'est ps un fichier valide"
     fi
}
# compress
mktar() { tar cvf  "${1%%/}.tar"     "${1%%/}/"; }
mktgz() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }
mktbz() { tar cvjf "${1%%/}.tar.bz2" "${1%%/}/"; }
mktxz() { tar cvJf "${1%%/}.tar.xz" "${1%%/}/"; }
# end of functions #####################################################

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# prompt ###############################################################
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

if [ "$color_prompt" = yes ]; then
    TRAD=`echo "${LANG:0:2}"`
    if [ "$TRAD" == "fr" ]; then
        echo -en "\e[0;31mDebian\e[m + \e[0;36mHandyLinux-2\e[m - prenez le contrôle de votre système\n"
    else
        echo -en "\e[0;31mDebian\e[m + \e[0;36mHandyLinux-2\e[m - take control of your system\n"
    fi
    PS1='${debian_chroot:+($debian_chroot)} \e[0;32m\u\e[m@\e[0;37m\h\e[m \e[0;30m[\t]\e[m\n \e[01;34m\w\e[m \e[0;32m\$\e[m '
    # uncomment for a guantas_style prompt. sources: http://crunchbang.org/forums/viewtopic.php?pid=277970#p277970
    #PS1="\[\e[00;32m\]\A \[\e[00;35m\]\[\e[00;37m\]\n\[\e[00;35m\]●\[\e[00;33m\] ●\[\e[00;31m\] ●\[\e[01;35m\]\[\e[0m\] "
    # regular Debian colored prompt:
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h \t\n\w \\$\ '
fi
unset color_prompt force_color_prompt

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
