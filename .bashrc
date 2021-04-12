

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
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

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
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

PS1='`a=$?;if [ $a -ne 0 ]; then a="  "$a; echo -ne "\[\e[1A\e[$((COLUMNS-2))G\e[31m\e[1;41m${a:(-3)}\]\[\e[0m\e[7m\e[2m\r\n\]";fi`${debian_chroot:+($debian_chroot)}\[\e[1;33m\]\u\[\e[1;31m\]@\[\e[1;35m\]\h\[\e[1;32m\][\t]\[\e[1;31m\]:\[\e[1;36m\]\w\[\e[1;34m\]\$\[\e[0;39m\]'

export PS1="\[\033[38;5;87m\]\u\[$(tput bold)\]\[$(tput sgr0)\]\[\033[38;5;15m\]@\[$(tput sgr0)\]\[$(tput sgr0)\]\[\033[38;5;119m\]\h\[$(tput sgr0)\]\[\033[38;5;15m\] [\[$(tput sgr0)\]\[\033[38;5;198m\]\t\[$(tput sgr0)\]\[\033[38;5;15m\]] {\[$(tput sgr0)\]\[\033[38;5;81m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]}\n\[$(tput sgr0)\]\[\033[38;5;2m\]--\[$(tput sgr0)\]\[\033[38;5;118m\]>\[$(tput sgr0)\]\[\033[38;5;15m\]\\$ \[$(tput sgr0)\]"

#PS1="\[\e[36;1m\]  \W \[\e[31;1m\]> \[$(tput sgr0)\]\[\e[0m\]"


# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alh'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

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



. /opt/conda/etc/profile.d/conda.sh

alias pi='pip install'
alias cd.='cd ..'
alias v='vim'
alias w='wc -l'
alias d='du -sh'
alias c='cat'
alias le='less'
alias h='head'
alias hn='head -n'
alias t='tail'
alias vb='vim ~/.bashrc'

alias sb='source ~/.bashrc'
#alias pytorch='conda activate pytorch'

alias nv='nvidia-smi'
alias jp='nohup jupyter notebook > nohup.jp 2>&1 &'

#alias psp='ps -ef | grep python | cut -c 9-15| xargs kill -s 9'
alias pg='ps -ef | grep'
alias ka=' | cut -c 9-15| xargs kill -s 9'

export CUDA_HOME=/usr/local/cuda

export PATH=$PATH:$CUDA_HOME/bin
export LD_LIBRARY_PATH=/usr/local/cuda/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}

#export PATH=/usr/local/cuda-8.0/bin${PATH:+:${PATH}}
#export LD_LIBRARY_PATH=/usr/local/cuda8.0/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}

export kk='kill -9'
export PATH="/opt/conda/bin:$PATH"
export DISPLAY="localhost:10.0"
alias gc='git clone'
alias gr='git clone --recursive'
alias gsi='git submodule init'
alias gsp='git submodule update'
alias mk='make -j 32'
alias mc='make clean'
alias mi='make install'
alias pa='ps aux'

alias ds='du -sh ./*'


alias py3.6='conda activate py3.6'

alias da='conda deactivate'

alias wk='cd /workspace'
alias ta='tmux attach -t'
alias tn='tmux new -s'
alias cls6='cd /workspace/cls6/'
alias tmp='cd /workspace/tmp/'
alias data='cd /ssd/cls_lung'
alias tl='tmux ls'
alias tk='tmux kill-session -t' # session_name
# ctrl + b, d， 临时退出
# ctrl + b, ctrl + z, 挂起当前session
alias v='vim'
alias pt='python train_with_dataloader.py'
alias pr='python resnext3d.py'
alias cls='cd /workspace/lung_cls5'
alias p3='python resnext3d.py'
alias wn='watch -n 0.1 -d nvidia-smi'
alias p='python'


