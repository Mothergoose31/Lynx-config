#!/bin/bash


# ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿

# WARNING: This setup requires a custom form of lynx (a shell script in
# scripts) be installed as well as lynx. 

# ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿

command_exists() {
    command -v "$1" >/dev/null 2>&1
}


if ! command_exists lynx; then
    echo "Lynx is not installed. Attempting to install..."
    
    # Check the package manager and install lynx
    if command_exists apt-get; then
        sudo apt-get update && sudo apt-get install -y lynx
    elif command_exists yum; then
        sudo yum install -y lynx
    elif command_exists brew; then
        brew install lynx
    else
        echo "Unable to install lynx. Please install it manually." >&2
        exit 1
    fi
    
 
    if ! command_exists lynx; then
        echo "Failed to install lynx. Please install it manually." >&2
        exit 1
    fi
    
    echo "Lynx has been successfully installed."
else
    echo "Lynx is already installed."
fi


mkdir -p "$HOME/.config"
rm -rf "$HOME/.config/lynx"
ln -s "$(pwd)" "$HOME/.config/lynx"
if [ $? -eq 0 ]; then
    echo "Lynx configuration linked successfully."
    ls -l "$HOME/.config/lynx"
else
    echo "Failed to create symbolic link." >&2
    exit 1
fi