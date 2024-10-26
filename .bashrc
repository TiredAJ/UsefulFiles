eval $(ssh-agent -s)


alias T-Reload='source ~/.bashrc'
alias Go-Serfiwr='ssh aj@192.168.0.67'
alias Get-IP-Pub='curl -s http://tnx.nl/ip | tr -d "<>"'
alias Get-IP-Prv='ip addr | grep inet'
alias Get-IPs='echo "public: " && Get-IP-Pub && echo "private \n" && Get-IP-Prv'
alias T-Edit='nano ~/.bashrc'


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
