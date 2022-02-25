case $- in
    *i*) ;;
      *) return;;
esac

HISTCONTROL=ignoreboth

shopt -s histappend

HISTSIZE=4000
HISTFILESIZE=8000

shopt -s checkwinsize

if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi                                                                                                                                                                                                                                   
                                                                                                                                                                             
force_color_prompt=yes                                                                                                                                                                                                                     
                                                                                                                                                                                                                                           
if [ -n "$force_color_prompt" ]; then                                                                                                                                                                                                      
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then                                                                                                                                                                                                                                                                                                                                                     
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='\[\033[01;36m\]\u@\H\[\033[00m\] [\[\033[01;31m\]\w\[\033[00m\]] \[\033[01;35m\]~>\[\033[00m\] '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias diff='diff --color=auto'
    alias ip='ip --color=auto'

fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


# useful functions
function mkcd(){
mkdir $1
cd $1
}

function td(){
directory=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
mkdir /tmp/$directory
cd /tmp/$directory
}

function tf(){
file=tf-$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 5 | head -n 1)
vim /tmp/$file
echo $file
}

function cl() {
    DIR="$*";
        # if no DIR given, go home
        if [ $# -lt 1 ]; then
                DIR=$HOME;
    fi;
    builtin cd "${DIR}" && \
    # use your preferred ls command
        ls
}

function httpx-lowfruits(){
    # lowfruits by jdi
    ipinfo prips "$@" | httpx -csv -sr -o httpx-low-fruits.out -title -sc -td -p 80,443,8080,8000,8009,8888,8443,9443,10443,7000-7004,8000-8003,9000-9003,9503,7070,7071,11111,4444,4445,4786,143,6066,2990,1617,4848,9200,5432,8880,11006,5601,8060,1090,1098,1099,11099,47001,47002,10999,5000,45000,45001,8686,9012,50500,5555,5556,15672,8161,3000,8088,8500
}

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export PATH="$HOME/.poetry/bin:/root/.local/bin/:$PATH"
export HISTFILE=/data/.bash_history
export PROMPT_COMMAND='history -a'
