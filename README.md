# Riley Bracken's dot files

These are config files to set up a system the way I like it.

## Pre-Install

Open the gitconfig file and change lines 2 and 3 (name and email).

Setup the laptop with Thoughtbot's open source tool:
https://github.com/thoughtbot/laptop

Setup oh-my-zsh:

```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

Setup rbenv:
```
$ brew install rbenv
```

Setup Vundle:

```
$ git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

## Set up Github
1. [Generate a SSH key.](https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
2. [Add the SSH key to your account](https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/adding-a-new-ssh-key-to-your-github-account)

## Installation
Clone the repository
```
$ mkdir ~/Code
$ cd ~/Code
$ git@github.com:rileybracken/dotfiles.git
```

cd into the directory
```
cd ~/Code/dotfiles
```

Install the dotfiles, this will symlink the dotfiles
repository to the root.
```
$ rake install
```

## Post-Install

Install Vundle plugins Run `:BundleInstall` in vim.

## iTerm configuration

### General Settings

* Turn off the "Confirm on quit" setting

### Appearance Settings

* Load the Hybrid.itermcolors color scheme found in this directory.

### Profiles

### Keys

### Arrangements

TODO: Add screenshots of the iTerm configuration.
