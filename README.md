# B-Vault
CLI tool collection and a step‑by‑step setup guide for your new shell environment.

## Overview

This repository is **a collection of CLI tool programs and a step‑by‑step guide** for bootstrapping a brand‑new macOS environment. It installs and configures:

- Homebrew and a custom Brewfile (CLI tools & casks)
- **[ASDF](https://asdf-vm.com)** version manager with plugins for Node.js, Yarn, Python, Go, Elixir, and Flutter
- Zsh with a lightweight plugin manager and essential plugins
- Git global configuration and aliases
- **[mattmc3/antidote](https://github.com/mattmc3/antidote)** – A high‑performance Zsh plugin manager built from the ground up for speed: clones and compiles your plugins concurrently into an ultra‑fast static load file.
- A workspace directory at `~/git` for all your projects

Each step is automated via a single `setup.sh` script, backed by modular config files.

## Installation

1. Clone this repo:
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
    ├── .gitignore             # This file
    ├── setup.sh               # One‑shot bootstrap script
    ├── brew/
    │   └── Brewfile           # Homebrew formulae, casks, mas apps
    ├── asdf/
    │   └── tool-versions      # ASDF global versions file
    ├── zsh/
    │   ├── zshrc              # Zsh configuration
    │   └── zinit.zsh          # Plugin manager loader
    ├── git/
    │   └── gitconfig          # Global Git settings & aliases
    └── mas/
        └── apps               # App Store app IDs for `mas install`
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

## Customization
- [Zsh plugins](https://asdf-vm.com/guide/getting-started.html): modify zsh/zinit.zsh (or your chosen manager) to add/remove plugins
- [Git aliases](https://www.atlassian.com/git/tutorials/saving-changes/gitignore): edit git/gitconfig to add shortcuts under
- App selection: update mas/apps or brew/Brewfile to include additional GUI or App Store apps

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
