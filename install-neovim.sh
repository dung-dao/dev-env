#!/bin/bash

configure_neovim() {
    echo "Configuring Neovim..."
    cat << EOF >> ~/.config/nvim/init.vim
" Syntax Highlighting
syntax enable
syntax on

" General Settings
set incsearch
set hlsearch
set scrolloff=15

" Key Mappings
imap ;; <Esc>
nnoremap <CR> o<Esc>
nnoremap <C-k> <C-u>
nnoremap <C-j> <C-d>
nnoremap <Tab> <C-w>w
nnoremap <C-a> ggVG

" Leader Key Mapping
let g:mapleader = ' '

" Sync with System Clipboard
set clipboard=unnamedplus
EOF
}

# Check if Homebrew is installed on macOS
if [[ "$OSTYPE" == "darwin"* ]]; then
    if ! command -v brew &> /dev/null; then
        echo "Homebrew not found. Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else
        echo "Homebrew is already installed. Updating..."
        brew update
    fi

    # Install Neovim via Homebrew
    echo "Installing Neovim..."
    brew install neovim

    configure_neovim

# Check if apt-get is available on Linux
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if ! command -v apt-get &> /dev/null; then
        echo "apt-get not found. Please install Neovim manually."
        exit 1
    fi

    # Install Neovim via apt-get
    echo "Installing Neovim..."
    sudo apt-get update
    sudo apt-get install neovim -y

    configure_neovim

# Unsupported OS
else
    echo "Unsupported operating system."
    exit 1
fi

# Check if Neovim is installed successfully
if command -v nvim &> /dev/null; then
    echo "Neovim installed successfully."
else
    echo "Neovim installation failed."
fi
