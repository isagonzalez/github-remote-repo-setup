#!/bin/bash

# exit if there's any errors
set -e 

INSTALL_DIR="$HOME/.local/bin"
SCRIPT_NAME="gitsetup"
SCRIPT_URL="https://raw.githubusercontent.com/isagonzalez/github-remote-repo-setup/main/git_setup.sh"

# create the directory if it doesn't already exist
mkdir -p "$INSTALL_DIR"

# download the script to the location
curl -sL "$SCRIPT_URL" -o "$INSTALL_DIR/$SCRIPT_NAME"
chmod +x "$INSTALL_DIR/$SCRIPT_NAME"

echo "✅ Installed '$SCRIPT_NAME' to $INSTALL_DIR"

# checking shell
SHELL_NAME=$(basename "$SHELL")
PROFILE_FILE=""

case "$SHELL_NAME" in
  bash)
    if [ -f "$HOME/.bash_profile" ]; then
      PROFILE_FILE="$HOME/.bash_profile"
    else
      PROFILE_FILE="$HOME/.bashrc"
    fi
    ;;
  zsh)
    PROFILE_FILE="$HOME/.zshrc"
    ;;
  fish)
    PROFILE_FILE="$HOME/.config/fish/config.fish"
    ;;
  *)
    PROFILE_FILE="$HOME/.profile"
    ;;
esac

# add the script to the path
if ! grep -q "$INSTALL_DIR" "$PROFILE_FILE"; then
  echo "" >> "$PROFILE_FILE"
  echo "# Added by gitsetup installer" >> "$PROFILE_FILE"
  echo "export PATH=\"\$PATH:$INSTALL_DIR\"" >> "$PROFILE_FILE"
  echo "✅ Added $INSTALL_DIR to PATH in $PROFILE_FILE"
else
  echo "ℹ️  $INSTALL_DIR already in PATH (via $PROFILE_FILE)"
fi

echo ""
echo "👉 Please run: source ~/${PROFILE_FILE##*/}"
echo "   or restart your terminal to start using '$SCRIPT_NAME'"