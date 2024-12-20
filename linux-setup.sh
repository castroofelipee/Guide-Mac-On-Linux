#!/bin/bash

set -e  # Stop script on errors

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Install basic dependencies
sudo apt install -y git gnome-tweaks gnome-shell-extensions curl unzip

# Install GNOME User Themes Extension
EXTENSIONS_DIR="$HOME/.local/share/gnome-shell/extensions"
USER_THEMES_UUID="user-theme@gnome-shell-extensions.gcampax.github.com"

if [ ! -d "$EXTENSIONS_DIR/$USER_THEMES_UUID" ]; then
    echo "Instalando a extensão User Themes..."
    mkdir -p "$EXTENSIONS_DIR"
    curl -L https://extensions.gnome.org/extension-data/user-theme%40gnome-shell-extensions.gcampax.github.com.v42.shell-extension.zip -o user-themes.zip
    unzip -o user-themes.zip -d "$EXTENSIONS_DIR/$USER_THEMES_UUID"
    rm user-themes.zip
    echo "User Themes extension installed. Make sure to enable it in GNOME Tweaks."
fi

# Temporary directory to clone repositories
temp_dir=$(mktemp -d)
echo "Using the temporary directory $temp_dir"
cd "$temp_dir"

git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git --depth=1
cd WhiteSur-gtk-theme
./install.sh
cd ..

git clone https://github.com/vinceliuice/WhiteSur-firefox-theme.git
cd WhiteSur-firefox-theme
./install.sh
cd ..

git clone https://github.com/vinceliuice/WhiteSur-icon-theme.git
cd WhiteSur-icon-theme
./install.sh
cd ..

git clone https://github.com/vinceliuice/WhiteSur-wallpapers.git
cd WhiteSur-wallpapers
sudo ./install-gnome-backgrounds.sh
cd ..

# Clean up temporary directory
cd ~
rm -rf "$temp_dir"

# Completion message
echo "Installation complete! You can now use GNOME Tweaks to apply the WhiteSur theme."
