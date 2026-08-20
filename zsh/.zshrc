. "$HOME/.local/share/../bin/env"

# ============================================================
#                     Completion System
# ============================================================

autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# ============================================================
#                        Environment
# ============================================================

# Go workspace
export GOPATH="$HOME/.go"
export PATH="$GOPATH/bin:$PATH"

# Bat theme
export BAT_THEME="rose-pine"

# Tree-Sitter CLI    
export PATH="$HOME/.cargo/bin:$PATH"

# ============================================================
#                        History Settings
# ============================================================

HISTFILE="$HOME/.zhistory"
SAVEHIST=1000
HISTSIZE=999

# History options
setopt share_history          # Share history between all running shells
setopt hist_expire_dups_first # Delete older duplicate entries first
setopt hist_ignore_dups       # Ignore consecutive duplicate commands
setopt hist_verify            # Don't execute history substitution immediately

# ============================================================
#                        Key Bindings
# ============================================================

# Eliminate 0.4s lag when pressing Escape / Ctrl+[
export KEYTIMEOUT=1

# ============================================================
#                    Tool Initializations
# ============================================================

# mise (must be loaded before zoxide)
if (( $+commands[mise] )); then
  eval "$(mise activate zsh)"
fi

# zoxide
if (( $+commands[zoxide] )); then
  eval "$(zoxide init zsh)"
fi

# Starship prompt
if (( $+commands[starship] )); then
  eval "$(starship init zsh)"
fi

# ============================================================
#                     zsh-vi-mode Hook
# ============================================================

# General / Insert mode initialization & integrations
function zvm_after_init() {
  # 1. Search history with ↑ / ↓ in insert mode
  zvm_bindkey viins '^[[A' history-search-backward
  zvm_bindkey viins '^[[B' history-search-forward

  # 2. Prevent leaked Alt+m (tmux prefix) from switching modes
  zvm_bindkey viins '^[m' undefined-key
  zvm_bindkey vicmd '^[m' undefined-key
  zvm_bindkey opp '^[m' undefined-key

  # 3. Initialize fzf after vi-mode sets up keymaps
  if (( $+commands[fzf] )); then
    eval "$(fzf --zsh)"
  fi
}

# Normal & Visual mode keybindings (Lazy keybindings hook)
function zvm_after_lazy_keybindings() {
  # 1. Unbind plain k/j from cycling history in normal mode
  zvm_bindkey vicmd 'k' undefined-key
  zvm_bindkey vicmd 'j' undefined-key

  # 2. History search with Ctrl+k (up) and Ctrl+j (down) in normal mode
  zvm_bindkey vicmd '^k' history-beginning-search-backward
  zvm_bindkey vicmd '^j' history-beginning-search-forward
}

# ============================================================
#                            Aliases
# ============================================================

# General
alias vim="nvim"
alias ff="fzf --preview 'bat --style=numbers --color=always {}'"

# eza (replaces ls)
if (( $+commands[eza] )); then
  alias ls='eza -lh --group-directories-first --icons=auto'
  alias lsa='ls -a'
  alias lt='eza --tree --level=2 --long --icons --git'
  alias lta='lt -a'
fi

alias tn='tmux new-session -A -s "$(basename "$PWD")"'

# ============================================================
#                        Custom Functions
# ============================================================

# Open files in the background
open() {
  xdg-open "$@" >/dev/null 2>&1 &
}

# Project navigation with fzf
fp() {
  # Search paths
  local search_paths=(
    "$HOME/Projects"
    "$HOME/Work"
    "$HOME/Documents"
  )

  # Directories to exclude
  local excludes=(
    -E node_modules
    -E .venv
    -E dist
    -E build
    -E target
    -E vendor
    -E .next
    -E __pycache__
  )

  # Project marker files
  local marker_list=(
    "\.git"
    "package\.json"
    "Cargo\.toml"
    "go\.mod"
    "Makefile"
    "pyproject\.toml"
    "composer\.json"
    "mix\.exs"
  )

  # Build regex pattern from markers
  local markers="^($(IFS='|'; echo "${marker_list[*]}"))$"
  
  # Preview command
  local preview="eza --tree --color=always --level=1 --icons --group-directories-first {}"

  # Find and select project directory
  local selected
  selected=$(fd -H -I -t f --max-depth 5 \
    "${excludes[@]}" \
    "$markers" \
    "${search_paths[@]}" \
    -x echo {//} | sort -u | \
    fzf --prompt="Project > " \
        --height=80% \
        --layout=reverse \
        --border \
        --preview="$preview")

  # Navigate to selected directory
  [[ -n "$selected" ]] && z "$selected"
}

# ============================================================
#                            fzf Setup
# ============================================================

# Rose Pine inspired colors
export FZF_DEFAULT_OPTS="
  --color=fg:#908caa,bg:#191724,hl:#ebbcba
  --color=fg+:#e0def4,bg+:#26233a,hl+:#ebbcba
  --color=border:#403d52,header:#31748f,gutter:#191724
  --color=spinner:#f6c177,info:#9ccfd8
  --color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa
"

# Default commands
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Completion helpers
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

# Preview configurations
show_file_or_dir_preview="if [ -d {} ]; then \
  eza --tree --color=always {} | head -200; \
  else bat -n --color=always --line-range :500 {}; \
fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Custom behavior based on command
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \${}'"                         "$@" ;;
    ssh)          fzf --preview 'dig {}'                                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview"                "$@" ;;
  esac
}

# ============================================================
#                            Plugins
# ============================================================

# NOTE: Plugins must be sourced at the end.
# zsh-syntax-highlighting must be the very last plugin.

# zsh-vi-mode (must precede syntax-highlighting and autosuggestions)
if [[ -f /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh ]]; then
  # Plugin options & cursor styling
  ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BEAM
  ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLOCK
  ZVM_OPPEND_MODE_CURSOR=$ZVM_CURSOR_UNDERLINE
  ZVM_VI_SURROUND_BINDKEY="s-prefix"
  ZVM_SYSTEM_CLIPBOARD_ENABLED=true

  source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh
fi

# zsh-autosuggestions
if [[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
  source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# zsh-syntax-highlighting (MUST BE LAST)
if [[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
