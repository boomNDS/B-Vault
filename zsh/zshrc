# ~/.zshrc

# 1) Terminal & Editor
export TERM=xterm-256color
export EDITOR="nvim"

# 2) FZF (enhanced Ctrl+R)
export FZF_DEFAULT_OPTS='--height 40% --tmux bottom,40% --layout reverse --border top'
export FZF_DEFAULT_COMMAND="fd --type f --hidden --exclude .git"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# 3) History & Keybindings
HISTFILE=~/.zsh_history; HISTSIZE=100000; SAVEHIST=100000
setopt HIST_SAVE_NO_DUPS INC_APPEND_HISTORY
bindkey -e           # Emacs keys
setopt autocd        # `cd dirname`

# 4) Homebrew & compinit
eval "$(brew shellenv)"         # Homebrew in PATH
autoload -Uz compinit           # load completion system
# Option A (preferred): fix perms once via compaudit | xargs chmod g-w,o-w
# Option B: skip check with compinit -u
compinit                        # or `compinit -u`

# 5) Antidote plugin manager
if [ -d "${ZDOTDIR:-~}/.antidote" ]; then
  source "${ZDOTDIR:-~}/.antidote/antidote.zsh"
else
  source "$(brew --prefix)/opt/antidote/share/antidote/antidote.zsh"
fi
antidote load

# 6) ngrok autocomplete
if command -v ngrok &>/dev/null; then
  eval "$(ngrok completion)"
fi

# 8) Starship prompt (Dracula theme)
eval "$(starship init zsh)"

# 9) ASDF version manager
export ASDF_DATA_DIR="$HOME/.asdf"
export PATH="$ASDF_DATA_DIR/shims:$PATH"
fpath=("$ASDF_DATA_DIR/completions" $fpath)
autoload -U +X bashcompinit && bashcompinit
autoload -U +X compinit && compinit

# 10) zoxide (fast cd)
eval "$(zoxide init zsh)"
