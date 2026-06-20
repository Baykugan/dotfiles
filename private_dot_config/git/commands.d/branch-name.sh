#!/bin/sh;

branch_name() {
    FORMAT="pretty"

    # Parse arguments
    while [ "$#" -gt 0 ]; do
        case $1 in
        --help | -h)
            echo "Usage: branch-name [options]"
            echo "Options:"
            echo "  --help, -h     Show this help message"
            echo "  --format, -f   Output format (basic, pretty)"
            return
            ;;
        --format=*)
            case ${1#*=} in
            basic)
                FORMAT="basic"
                shift
                ;;
            pretty)
                FORMAT="pretty"
                shift
                ;;
            '')
                echo "Missing argument for --format= option"
                return
                ;;
            *)
                echo "Invalid argument for --format= option: ${1#*=}"
                return
                ;;
            esac
            ;;
        --format | -f)
            case $2 in
            basic)
                FORMAT="basic"
                shift 2
                ;;
            pretty)
                FORMAT="pretty"
                shift 2
                ;;
            "")
                echo "Missing argument for $1 option"
                return
                ;;
            *)
                echo "Invalid argument for $1 option: $2"
                return
                ;;
            esac
            ;;
        *)
            echo "Invalid argument: $1"
            return
            ;;
        esac
    done

    if [ "$FORMAT" = "basic" ]; then
        git rev-parse --abbrev-ref HEAD
        return
    fi

    if [ "$FORMAT" = "pretty" ]; then
        git branch --color=always | grep '\*' | awk '{print "* "$2}'
        return
    fi
}

branch_name "$@"
