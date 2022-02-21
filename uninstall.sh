#!/bin/zsh

# Uninstall brew
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
echo "[UNINSTALLING] brew ✅ "

# Oh-My-Zsh uninstall
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/uninstall.sh)"
echo "[UNINSTALLING] Oh-My-Zsh ✅ "
sleep 1
cd

# Uninstall apps via brew
cask_apps=('keepassxc' 'vscodium' 'slack' 'firefox' 'microsoft-remote-desktop')
for app in "${cask_apps[@]}" ;do
    brew uninstall --cask $app
    echo "[UNINSTALLING] $app ✅ "
    sleep 1

# Remove auxiliary dirs or files
rm -r ~/RSBP/
echo "[INFO] RSBP dir removed ✅ "

# Hide hidden files
defaults write com.apple.Finder AppleShowAllFiles false
killall Finder
sleep 1
echo "[SETUP] hide hidden files ✅ "

# Remove git
if [ -f $HOME/.gitconfig ]
then
    rm $HOME/.gitconfig
fi

if [ -d $HOME/.config/git ]
then
    rm -r $HOME/.config/git
    echo "[REMOVE] $HOME/.config/git ✅ "
fi
