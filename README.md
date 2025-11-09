# B-Vault
[![Automated macOS Setup](https://img.shields.io/badge/macOS%20Setup-Automated-blue?style=flat-square&logo=apple)](#installation)

CLI tool collection 🧰 and a step‑by‑step setup guide for your new shell environment.

## Overview

This repository is **a collection of CLI tool programs and a step‑by‑step guide** for bootstrapping a brand‑new macOS environment. It installs and configures:

- Homebrew and a custom Brewfile (CLI tools & casks)
- **[ASDF](https://asdf-vm.com)** version manager with plugins for Node.js, Yarn, Bun, Python, Ruby, Erlang, Elixir, and Go
- Zsh configured with the lightweight **[Antidote](https://github.com/mattmc3/antidote)** plugin manager
- A curated desktop stack with Ghostty, Yaak, Cursor, Visual Studio Code, Zed, Figma, Brave, TablePlus, Linear, ClickUp, Notion, Slack, Bear, AirServer, MonitorControl, Vanilla, CleanMyMac, Macs Fan Control, Cloudflare Warp, the official Ookla Speedtest CLI, and more
- Git global configuration and aliases
- A Dracula-themed **[Starship](https://starship.rs/)** prompt configuration
- A workspace directory at `~/git` for all your projects

Each step is automated via a single `setup.sh` script, backed by modular config files.

## New Mac Setup Guide

1. **Update macOS & install Command Line Tools** – Run `softwareupdate --install --all`, then execute `xcode-select --install` so Homebrew can build anything it needs.
2. **Sign into Apple ID & App Store** – `mas` installs require you to be logged in; open the App Store once and sign in before running the bootstrap script.
3. **Generate/import SSH keys** – Copy your existing `~/.ssh` contents or create a new key with `ssh-keygen -t ed25519 -C "you@example.com"` and add it to GitHub/GitLab.
4. **Clone this repo** – `git clone https://github.com/boomNDS/B-Vault ~/.dotfiles` (override `DOTFILES` if you prefer another location).
5. **Review configs** – Skim `brew/Brewfile`, `asdf/tool-versions`, and `zsh/zshrc` to add/remove anything specific to you before kicking off the install.
6. **Run the installer** – `cd ~/.dotfiles && bash setup.sh`; keep the terminal open so you can approve any manual prompts (e.g., App Store downloads).
7. **Verify and sync data** – After the script finishes, sign back into services (Slack, Discord, etc.), restore app settings, and rerun `brew bundle`/`asdf install` if you tweak configs.

## Installation

1. Clone this repo (override the target directory by exporting `DOTFILES=/path/to/dir` before running the script):
   ```bash
   git clone https://github.com/boomNDS/B-Vault ~/.dotfiles
   ```

2. Change into the directory and run the installer:
   ```bash
   cd ~/.dotfiles
   bash setup.sh
   ```
3. Restart your terminal or run source ~/.zshrc to apply changes.

### Repository Structure
  ```bash
    .
    ├── .gitignore
    ├── setup.sh               # One‑shot bootstrap script
    ├── cursor/
    │   └── extensions.json    # Snapshot of installed Cursor extensions
    ├── asdf/
    │   └── tool-versions      # ASDF global versions file
    ├── brew/
    │   └── Brewfile           # Homebrew formulae, casks, mas apps
    ├── git/
    │   └── gitconfig          # Global Git settings & aliases
    ├── starship.toml          # Dracula-themed prompt configuration
    └── zsh/
        └── zshrc              # Zsh configuration + Antidote plugin list
  ```

## Usage
- To update CLI tools & apps:
```bash
  brew update && brew bundle --file=brew/Brewfile
  asdf update                                      # update ASDF itself
  asdf plugin-update --all                         # update all ASDF plugins
  asdf install
```
- To add a new Homebrew formula or cask: edit brew/Brewfile and rerun brew bundle.
- To add a new ASDF tool: run asdf plugin-add <name> and update asdf/tool-versions.

### Manual installs when a cask or MAS app fails
1. Re-run `brew bundle --file=brew/Brewfile` to confirm the failure.
2. Open `brew/Brewfile` and copy the URL comment next to the failing entry. Each cask/MAS listing now links to its official download page (e.g., Ghostty → https://ghostty.org/docs, Orbstack → https://orbstack.dev/, Yaak → https://yaak.app/).
3. Download and install the app manually from that URL.
4. For MAS apps, open the App Store with the linked URL, sign in, and install from there; `mas install <id>` will register it afterward.
5. After manual installation, rerun `brew bundle --file=brew/Brewfile` so Homebrew marks the dependency as satisfied.

## Cursor extensions
- The current Cursor extension set is tracked in `cursor/extensions.json` (exported directly from `~/.cursor/extensions/extensions.json`).
- To install everything on a new machine, run:
  ```bash
  jq -r '.[].identifier.id' cursor/extensions.json | xargs -L1 cursor --install-extension
  ```
  (replace `cursor` with `code` if you prefer using VS Code’s CLI shim).
- After adding or removing extensions inside Cursor, regenerate the manifest with `cp ~/.cursor/extensions/extensions.json cursor/extensions.json && jq -r '.' cursor/extensions.json > cursor/extensions.json`.

## Customization
- Zsh & plugins: edit `zsh/zshrc` (Antidote loads whatever plugin bundle you define there) and rerun `source ~/.zshrc`
- Git defaults & aliases: tweak `git/gitconfig`
- Prompt: modify `starship.toml`, then restart your shell
- Homebrew formulas/casks/mas apps: adjust `brew/Brewfile` and rerun `brew bundle --file=brew/Brewfile`

## zsh plugins list
1. **[valentinocossar/vscode](https://github.com/valentinocossar/vscode)** – An Oh My Zsh plugin to open files and directories in Visual Studio Code via the `vs`/`vsa` commands.
2. **[zsh-users/zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)** – Fish‑like fast, unobtrusive autosuggestions as you type, based on your history and completions.
3. **[zsh-users/zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)** – Fish‑style real‑time syntax highlighting for the Zsh command line, helping catch typos before you hit Enter.
4. **[zsh-users/zsh-history-substring-search](https://github.com/zsh-users/zsh-history-substring-search)** – Zsh port of Fish’s history search: type any part of a past command and use ↑/↓ to traverse matching entries.
5. **[zsh-users/zsh-completions](https://github.com/zsh-users/zsh-completions)** – Hundreds of additional completion definitions (AWS‑CLI, Docker, Terraform, etc.) to layer on top of Zsh’s built‑in completions.
6. **[ajeetdsouza/zoxide](https://github.com/ajeetdsouza/zoxide)** – A smarter `cd` replacement (inspired by `z` and `autojump`) that tracks “frecency” and offers fuzzy jumping to your most‑used directories.
7. **[decayofmind/zsh-fast-alias-tips](https://github.com/decayofmind/zsh-fast-alias-tips)** – Reminds you of shell aliases you’ve defined whenever you run the equivalent full command. A Go‑accelerated, 10×‑faster fork of `alias-tips`.

## Inspiration And Credit
1. [Migrating Off Oh-My-Zsh and other recent Yak Shavings](https://www.stefanwienert.de/blog/2025/03/05/migrating-off-oh-my-zsh-and-other-recent-yak-shavings)
2. [Back to the Basics: Zsh without Oh My Zsh](https://batsov.com/articles/2025/03/01/back-to-the-basics-zsh-without-oh-my-zsh/)
