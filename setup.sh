#!/usr/bin/env bash
set -euo pipefail

# 0. Define and clone dotfiles repo
DOTFILES="$HOME/.B-Vault"
if [ ! -d "$DOTFILES" ]; then
  git clone https://github.com/myrepo/a.git "$DOTFILES"
fi
cd "$DOTFILES"

# 1. Install Homebrew if needed
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew…"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# 2. Update brew and install listed tools, casks, mas apps
echo "Updating Homebrew and installing from Brewfile…"
brew update
brew bundle --file="$DOTFILES/brew/Brewfile"

# 3. Install ASDF and load it
echo "Installing and sourcing ASDF…"
brew install asdf
# Source ASDF for Intel or Apple Silicon
if [ -f "/usr/local/opt/asdf/libexec/asdf.sh" ]; then
  . "/usr/local/opt/asdf/libexec/asdf.sh"
elif [ -f "/opt/homebrew/opt/asdf/libexec/asdf.sh" ]; then
  . "/opt/homebrew/opt/asdf/libexec/asdf.sh"
else
  echo "ERROR: asdf.sh not found"
  exit 1
fi

# 4. Read .tool-versions and ensure each plugin/version is installed & set global
TOOL_FILE="$DOTFILES/asdf/tool-versions"
[ -f "$TOOL_FILE" ] || TOOL_FILE="$HOME/.tool-versions"
if [ ! -f "$TOOL_FILE" ]; then
  echo "ERROR: .tool-versions not found"
  exit 1
fi

echo "Bootstrapping ASDF plugins and versions from $TOOL_FILE…"
while read -r plugin version _; do
  [[ -z "$plugin" || "${plugin:0:1}" == "#" ]] && continue

  if ! asdf plugin-list | grep -qx "$plugin"; then
    echo "Adding ASDF plugin: $plugin"
    asdf plugin-add "$plugin" || echo "⚠️ Failed to add plugin $plugin"
  fi

  echo "Installing $plugin@$version"
  asdf install "$plugin" "$version"
  asdf global  "$plugin" "$version"
done < "$TOOL_FILE"

echo "✅ ASDF toolchain installation complete"

# 5. Symlink your dotfiles
echo "Linking Zsh and Git configs…"
ln -svf "$DOTFILES/zsh/zshrc"    "$HOME/.zshrc"
ln -svf "$DOTFILES/git/gitconfig" "$HOME/.gitconfig"

# 6. Finish
echo "🎉 Setup complete! Please restart your terminal or run 'source ~/.zshrc' to apply changes."
