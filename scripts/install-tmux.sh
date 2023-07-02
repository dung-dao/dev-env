#!/bin/bash

# Check if Homebrew is installed on macOS
if [[ "$OSTYPE" == "darwin"* ]]; then
    if ! command -v brew &> /dev/null; then
        echo "Homebrew not found. Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else
        echo "Homebrew is already installed. Updating..."
        brew update
    fi

    # Install Tmux via Homebrew
    echo "Installing Tmux..."
    brew install tmux

# Check if apt-get is available on Linux
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if ! command -v apt-get &> /dev/null; then
        echo "apt-get not found. Please install Tmux manually."
        exit 1
    fi

    # Install Tmux via apt-get
    echo "Installing Tmux..."
    sudo apt-get update
    sudo apt-get install tmux -y

# Unsupported OS
else
    echo "Unsupported operating system."
    exit 1
fi

# Check if Tmux is installed successfully
if command -v tmux &> /dev/null; then
    echo "Tmux installed successfully."

    # Check if Tmux plugin manager (tpm) is already installed
    if [ ! -d ~/.tmux/plugins/tpm ]; then
        # Clone Tmux plugin manager (tpm)
        echo "Cloning Tmux plugin manager (tpm)..."
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    fi

    # Create or update the Tmux configuration file
    echo "Configuring Tmux..."
    cat << EOF > ~/.tmux.conf
# Enable mouse support
set -g mouse on

# Set pane border status to top and display full path
set -g pane-border-status top
set -g pane-border-format "#{pane_current_path}"

# Remove time from the right side of the status bar
set-option -g status-right-length 20
set-option -g status-right ""

# Set status bar colors for the gruvbox theme
set -g status-style "bg=colour235,fg=colour250"
set -g status-left-length 40
set -g status-left-style "bg=colour240,fg=colour223,bold"

# Plugins
# Tmux Plugin Manager
set -g @plugin 'tmux-plugins/tpm'

# Basic tmux settings everyone can agree on
set -g @plugin 'tmux-plugins/tmux-sensible'

# Tmux plugin for copying to system clipboard
set -g @plugin 'tmux-plugins/tmux-yank'

# Initialize TMUX plugin manager
# Keep this line at the very bottom of tmux.conf
run '~/.tmux/plugins/tpm/tpm'
EOF

    # Install Tmux plugins
    echo "Installing Tmux plugins..."
    tmux start-server
    tmux new-session -d
    ~/.tmux/plugins/tpm/scripts/install_plugins.sh
    tmux kill-server

    echo "Tmux configured successfully."
else
    echo "Tmux installation failed."
fi
