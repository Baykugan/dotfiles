# Commands to run in interactive sessions can go here
if status is-interactive
    # No greeting
    set fish_greeting

    # Use starship
    function starship_transient_prompt_func
        starship module character
    end
    if test "$TERM" != "linux"
        starship init fish | source
        enable_transience
    end
    
    # Colors
    if test -f ~/.local/state/quickshell/user/generated/terminal/sequences.txt
        cat ~/.local/state/quickshell/user/generated/terminal/sequences.txt
    end

    # Aliases
    # kitty doesn't clear properly so we need to do this weird printing
    alias clear "printf '\033[2J\033[3J\033[1;1H'"
    alias q 'qs -c ii'
    alias clip-file 'cat $argv | wl-copy'
     
     # Abbreviations
     abbr --add -position anywhere clip '| wl-copy'
     abbr --add -position anywhere put 'wl-paste >'    


    if test "$TERM" != "linux"
        alias ls 'eza --icons'
    end
    if test "$TERM" = "xterm-kitty"
        alias ssh 'kitten ssh'
    end
end

# Warm up images
printf '\033_Ga=T,t=f,c=1,r=1,q=2;%s\033\\' \
  "$(printf '%s' '/home/enki/.cache/fastfetch/logo.png' | base64 -w0)" \
  > /dev/tty

fastfetch

