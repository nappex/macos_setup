#!/bin/zsh

# Uninstall brew
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
echo "[UNINSTALLING] brew ✅ "

# Oh-My-Zsh uninstall
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/uninstall.sh)"
echo "[UNINSTALLING] Oh-My-Zsh ✅ "
sleep 1
cd

# load arrays in config
while read line; do
    if [[ $line =~ ^"["(.+)"]"$ ]]; then
        index=0
        arrname=${BASH_REMATCH[1]}
        declare -a $arrname
    elif [[ $line =~ ^([A-Za-z\-]+)$ ]]; then
        declare ${arrname}[$index]="${BASH_REMATCH[1]}"
        ((++index))
    fi
done < config.conf

# Uninstall cask apps via brew
for app in "${BREW_CASKS[@]}" ;do
    brew uninstall --cask $app
    echo "[UNINSTALLING] $app ✅ "
    sleep 0.5
done

for pkg in "${BREW_PKGS[@]}"
do
    brew uninstall $pkg
    echo "[UNINSTALLING] $pkg ✅ "
    sleep 0.5
done

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

# Remove vscodium
if [ -f $HOME/Library/Application\ Support/VSCodium/User/settings.json ]
then
    rm $HOME/Library/Application\ Support/VSCodium/User/settings.json
    echo "[REMOVE] $HOME/Library/Application\ Support/VSCodium/User/settings.json ✅ "
fi
