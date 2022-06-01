#!/bin/bash
brew install fish
export PATH="/opt/homebrew/bin:$PATH"
echo "$(which fish)" | sudo tee -a /etc/shells
chsh -s "$(which fish)"


# AFTER SETUP 
# fish_add_path /opt/homebrew/bin