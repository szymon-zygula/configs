function fish_greeting
end

if status is-interactive
    # Commands to run in interactive sessions can go here
    if not set -q TMUX
        exec tmux
    end
end
