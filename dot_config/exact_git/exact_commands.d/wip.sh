#!/bin/sh
wip() {
    QUIET=""
    POP=false
    BRANCH=$(git symbolic-ref --short HEAD)
    ON_WIP=false

    if [ "$(git log -1 --pretty=%B | grep -c "WIP:")" -ge 1 ]; then
        ON_WIP=true
    fi

    # Parse arguments
    while [ "$#" -gt 0 ]; do
        case $1 in
        --help | -h)
            echo "Usage: wip [options]"
            echo "Options:"
            echo "  --help, -h   Show this help message"
            echo "  --quiet, -q  Do not output any messages"
            echo "  --pop, -p    Undo the last WIP commit"
            return
            ;;
        --quiet | -q)
            QUIET="--quiet"
            shift
            ;;
        --pop | -p)
            POP=true
            shift
            ;;
        *)
            echo "Invalid argument: $1"
            return
            ;;
        esac
    done

    if $POP; then
        if $ON_WIP; then
            git reset HEAD~1 --mixed $QUIET
        else
            echo 'Cannot undo normal commit:'
        fi
    else
        if $ON_WIP; then
            git add . && git commit --amend --no-edit $QUIET
        else
            git add . && git commit -m 'WIP: '"$BRANCH" $QUIET
        fi
    fi
}

wip "$@"
