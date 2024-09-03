#!/bin/bash
command_exists() {
    command -v "$1" >/dev/null 2>&1
}


if ! command_exists lynx; then
    echo "Lynx is not installed. Attempting to install..."
    

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

mkdir -p "$HOME/.config/lynx"


cp "$(pwd)/lynx.cfg" "$HOME/.config/lynx/lynx.cfg"
cp "$(pwd)/lynx.lss" "$HOME/.config/lynx/lynx.lss"

if [ $? -eq 0 ]; then
    echo "lynx.cfg and lynx.lss copied successfully to ~/.config/lynx/"
else
    echo "Failed to copy lynx.cfg and lynx.lss." >&2
    exit 1
fi


chmod 644 "$HOME/.config/lynx/lynx.cfg" "$HOME/.config/lynx/lynx.lss"


ln -sf "$HOME/.config/lynx/lynx.cfg" "$HOME/.lynxrc"
ln -sf "$HOME/.config/lynx/lynx.lss" "$HOME/.lynx.lss"

echo "Lynx setup completed successfully."