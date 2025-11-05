# Suppress the welcome message
set fish_greeting

# Use nvim as the default editor
fish_config theme choose "Rosé Pine"
set -x EDITOR nvim

# Set vi key bindings
fish_vi_key_bindings

# Configure PATH variables
set -x PATH "/home/daniel/.local/bin" $PATH
# Go
set -gx GOROOT /usr/local/go-1.23.0
set -gx GOPATH $HOME/go
set -gx PATH $GOPATH/bin $GOROOT/bin $PATH

# Gradle
set -x GRADLE_HOME /opt/gradle/gradle-8.4
set -x PATH $GRADLE_HOME/bin $PATH

alias vim 'nvim'
alias fd='cd $(find ~/ -type d | fzf)'

# Aliases: git
alias ga='git add'
alias gap='ga --patch'
alias gb='git branch'
alias gba='gb --all'
alias gc='git commit'
alias gca='gc --amend --no-edit'
alias gce='gc --amend'
alias gco='git checkout'
alias gcl='git clone --recursive'
alias gd='git diff --output-indicator-new=" " --output-indicator-old=" "'
alias gds='gd --staged'
alias gi='git init'
alias gl='git log --graph --all --pretty=format:"%C(magenta)%h %C(white) %an  %ar%C(blue)  %D%n%s%n"'
alias gm='git merge'
alias gn='git checkout -b'  # new branch
alias gp='git push'
alias gr='git reset'
alias gu='git pull'

function gs
    git status
    git log --oneline -4
end

function gcm
	git commit --message "$argv"
end

# Man colors
function man
    set -lx GROFF_NO_SGR 1
    set -lx LESS_TERMCAP_mb \e\[31m
    set -lx LESS_TERMCAP_md \e\[34m
    set -lx LESS_TERMCAP_me \e\[0m
    set -lx LESS_TERMCAP_se \e\[0m
    set -lx LESS_TERMCAP_so \e\[1\;30m
    set -lx LESS_TERMCAP_ue \e\[0m
    set -lx LESS_TERMCAP_us \e\[35m
    command man $argv
end

if status is-interactive
    # Commands to run in interactive sessions can go here
    starship init fish | source
    zoxide init fish | source

end

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /home/daniel/miniconda3/bin/conda
    eval /home/daniel/miniconda3/bin/conda "shell.fish" "hook" $argv | source
else
    if test -f "/home/daniel/miniconda3/etc/fish/conf.d/conda.fish"
        . "/home/daniel/miniconda3/etc/fish/conf.d/conda.fish"
    else
        set -x PATH "/home/daniel/miniconda3/bin" $PATH
    end
end
# <<< conda initialize <<<

# conda fzf envs
function fce
  conda activate (conda info --envs | fzf | awk '{print $1}')
end

