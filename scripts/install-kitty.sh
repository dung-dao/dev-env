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

    # Install Kitty via Homebrew
    echo "Installing Kitty..."
    brew install kitty

    # Create the Kitty configuration directory
    mkdir -p ~/.config/kitty

    # Configure Kitty
    echo "Configuring Kitty..."
    cat << EOF > ~/.config/kitty/kitty.conf
# This is the Kitty configuration file

# Appearance settings
font_size 15

# Gruvbox Dark color scheme
foreground #EBDBB2
background #282828

color0 #282828
color1 #CC241D
color2 #98971A
color3 #D79921
color4 #458588
color5 #B16286
color6 #689D6A
color7 #A89984
color8 #928374
color9 #FB4934
color10 #B8BB26
color11 #FABD2F
color12 #83A598
color13 #D3869B
color14 #8EC07C
color15 #EBDBB2

window_border_color #00FF00

# Keybindings
map key:ctrl+shift+c action:copy_to_clipboard
map key:ctrl+shift+v action:paste_from_clipboard
map key:ctrl+shift+n action:new_window
map key:ctrl+shift+q action:quit

# Behavior settings
cursor_autohide false
focus_follows_mouse true

map kitty_mod+c copy_to_clipboard --auto
EOF

# Check if apt-get is available on Linux
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if ! command -v apt-get &> /dev/null; then
        echo "apt-get not found. Please install Kitty manually."
        exit 1
    fi

    # Install Kitty via apt-get
    echo "Installing Kitty..."
    sudo apt-get update
    sudo apt-get install kitty -y

    # Create the Kitty configuration directory
    mkdir -p ~/.config/kitty

    # Configure Kitty
    echo "Configuring Kitty..."
    cat << EOF > ~/.config/kitty/kitty.conf
# This is the Kitty configuration file

# Appearance settings
font_size 15

# Gruvbox Dark color scheme
foreground #EBDBB2
background #282828

color0 #282828
color1 #CC241D
color2 #98971A
color3 #D79921
color4 #458588
color5 #B16286
color6 #689D6A
color7 #A89984
color8 #928374
color9 #FB4934
color10 #B8BB26
color11 #FABD2F
color12 #83A598
color13 #D3869B
color14 #8EC07C
color15 #EBDBB2

window_border_color #00FF00

# Keybindings
map key:ctrl+shift+c action:copy_to_clipboard
map key:ctrl+shift+v action:paste_from_clipboard
map key:ctrl+shift+n action:new_window
map key:ctrl+shift+q action:quit

# Behavior settings
cursor_autohide false
focus_follows_mouse true

map kitty_mod+c copy_to_clipboard --auto
EOF

# Unsupported OS
else
    echo "Unsupported operating system."
    exit 1
fi

# Check if Kitty is installed successfully
if command -v kitty &> /dev/null; then
    echo "Kitty installed successfully."
else
    echo "Kitty installation failed."
fi
