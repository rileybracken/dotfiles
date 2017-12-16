# Riley Bracken's dot files

These are config files to set up a system the way I like it.

## Pre-Install
Open the gitconfig file and change lines 2 and 3 (name and email).

Setup the laptop with Thoughtbot's open source tool:
  https://github.com/thoughtbot/laptop

Setup oh-my-zsh:
  `sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"`

Setup rbenv:
  `brew install rbenv`

Setup Vundle:
  `git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim`

## Installation

  `git clone git://github.com/rileybracken/dotfiles ~/Code`
  `cd ~/.dotfiles`
  `rake install`

## Post-Install
Install Vundle plugins Run `:BundleInstall` in vim.

## iTerm configuration
### General Settings
- Turn off the "Confirm on quit" setting

### Appearance Settings
- Load the Hybrid.itermcolors color scheme found in this directory.

### Profiles

### Keys

### Arrangements

TODO: Add screenshots of the iTerm configuration.
