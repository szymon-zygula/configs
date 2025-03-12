function fish_greeting
end

if status is-interactive
    # Commands to run in interactive sessions can go here
    if not set -q TMUX
        exec tmux
    end
end


# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
test -r '/home/szymon/.opam/opam-init/init.fish' && source '/home/szymon/.opam/opam-init/init.fish' > /dev/null 2> /dev/null; or true
# END opam configuration

function conda-start
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /home/szymon/.local/share/miniconda3/bin/conda
    eval /home/szymon/.local/share/miniconda3/bin/conda "shell.fish" "hook" $argv | source
else
    if test -f "/home/szymon/.local/share/miniconda3/etc/fish/conf.d/conda.fish"
        . "/home/szymon/.local/share/miniconda3/etc/fish/conf.d/conda.fish"
    else
        set -x PATH "/home/szymon/.local/share/miniconda3/bin" $PATH
    end
end
# <<< conda initialize <<<
end
