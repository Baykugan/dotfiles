#!/bin/sh
lg0() {
    git log --graph --no-decorate $ALL $DATE_ORDER --format=format:"%C(auto)%d%C(reset)"
}

lg1() {
    git log --graph $ALL $DATE_ORDER --format=format:"%C(bold blue)%h%C(reset) - %C(bold green)($TIME)%C(reset) %C(white)%s%C(reset) %C(dim white)- $NAME%C(reset)%C(auto)%d%C(reset)"
}

lg2() {
    git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)'
}

lg() {
    DATE_ORDER=""
    NAME="%aN"
    TIME="%ar"
    ALL=""

    # Parse arguments
    while [ "$#" -gt 0 ]; do
        case $1 in
        --help | -h)
            echo "Usage: lg [options] -- [git log options]"
            echo "Options:"
            echo "  --help, -h     Show this help message"
            echo "  --author, -a   Order by author date"
            echo "  --commit, -c   Order by commit date"
            echo "  --lines, -l    Show n lines per commit"
            return
            ;;
        --author | -a)
            DATE_ORDER="--author-date-order"
            NAME="%aN"
            TIME="%ar"
            shift
            ;;
        --commit | -c)
            DATE_ORDER="--date-order"
            NAME="%cN"
            TIME="%cr"
            shift
            ;;
        --all)
            ALL="--all"
            shift
            ;;
        --lines=*)
            case ${1#*=} in
            [[:digit:]])
                LINES=${1#*=}
                echo "Called with $LINES line(s)"
                shift
                ;;
            '')
                echo "Missing argument for --lines= option"
                return
                ;;
            *)
                echo "Invalid argument for --lines= option: ${1#*=}"
                return
                ;;
            esac
            ;;
        --lines | -l)
            case $2 in
            [[:digit:]])
                LINES="$2"
                echo "Called with $LINES line(s)"
                shift 2
                ;;
            '')
                echo "Missing argument for $1 option"
                return
                ;;
            *)
                echo "Invalid argument for $1 option: $2"
                return
                ;;
            esac
            ;;
        --) # End of all options
            shift
            break
            ;;
        *)
            echo "Invalid argument: $1"
            return
            ;;
        esac
    done

    # Dynamically construct and call the function name
    FUNC_NAME="lg${LINES}"
    if command -v "$FUNC_NAME" >/dev/null 2>&1; then
        $FUNC_NAME
    else
        echo "There is no preset for $LINES lines"
        return
    fi
}

lg "$@"
