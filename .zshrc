eval $(ssh-agent -s)

# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' ''
zstyle :compinstall filename '/home/aj/.zshrc'

autoload -Uz compinit
compinit
autoload -Uz promptinit
promptinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=20000
setopt extendedglob
unsetopt autocd
bindkey -e
# End of lines configured by zsh-newuser-install

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias Go-Serfiwr='ssh aj@192.168.0.67'
alias T-Reload='source ~/.zshrc'

NEWLINE=$'\n'
PROMPT="%B%F{14}[%f%b%B%F{219}%n%f%b %F{14}@%f %B%F{82}%m%f%b%F{14}]%f${NEWLINE}%F{82}%d%f%F{14} > %f"


#AJ's git funcs
function G-Fetch () {
    git fetch
    git status
}

function G-Switch () {
    git stash
    git fetch
    git switch $1
}

function G-Clone () {
    git clone $1
    LOC=$(echo $1 | cut -f5 -d '/')
    cd $LOC

    if [ "$2" ]
    then
        git switch $2
    fi
}

function G-Sync () {
    git stash
    G-Fetch
    git pull
}

function G-Prep () {
    git stash
    git switch develop
    G-Fetch
    git pull
}

function G-Repo () {
    LOC=$(pwd | awk -F / '{print $NF}')
    URL="https://github.com/TiredAJ/${LOC}"

    if [ "$1" ]
    then
        case $1 in
            branches)
                URL+="/branches"
                ;;
            this)
                BRANCH=$(git branch --show-current)
                URL+="/branch/${BRANCH}"
                ;;
            prs)
                URL+="/pull-requests"
                ;;
        esac
    fi


    echo "Opening ${URL}"

    python -m webbrowser -t $URL
}
