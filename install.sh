#!/bin/zsh

# brew installation
# https://github.com/homebrew/install#uninstall-homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo "[INSTALLING] brew ✅ "
sleep 1

# Oh-My-Zsh installation
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo "[INSTALLING] Oh-My-Zsh ✅ "
sleep 1
cd

# install apps via brew
cask_apps=(
    'keepassxc'
    'vscodium'
    'slack'
    'firefox'
    'microsoft-remote-desktop'
    'balenaetcher'
)
for app in "${cask_apps[@]}" ;do
    brew install --cask $app
    echo "[INSTALLING] $app ✅ "
    sleep 1
done

brew install gnupg
echo "[INSTALLING] gnupg ✅ "

# Create auxiliary dirs or files
mkdir $HOME/RSBP/
echo "[INFO] create auxiliary dir ✅ "

# Show hidden files
defaults write com.apple.Finder AppleShowAllFiles true
killall Finder
sleep 1
echo "[SETUP] show hidden files ✅ "

# Setup git
git config --global init.defaultBranch main
git config --global merge.conflictstyle diff3
git config --global core.editor vim
git config --global color.ui True
git config --global user.email d.stroch@gmail.com
git config --global user.name d.stroch
if ! [ -d $HOME/.config/git ]
then
    mkdir -p $HOME/.config/git
    echo "[INFO] create $HOME/.config/git ✅ "
    cp $PWD/git/ignore $HOME/.config/git/
    echo "[INFO] ignore copied to $HOME/.config/git ✅ "
else
    cp $PWD/git/ignore $HOME/.config/git/
    echo "[INFO] ignore copied to $HOME/.config/git ✅ "
fi
echo "[SETUP] git ✅ "

# Setup Oh My Zsh
cp $PWD/oh-my-zsh/themes/custom_kphoen.zsh-theme $HOME/.oh-my-zsh/themes/kphoen.zsh-theme
cp $PWD/oh-my-zsh/.zshrc $HOME/
source $HOME/.zshrc
echo "[SETUP] Oh-My-Zsh ✅ "

# Setup VScodium
codium_extensions=(
    'vscode-icons-team.vscode-icons'
    'ms-python.python'
    'dracula-theme.theme-dracula'
    'elixir-lsp.elixir-ls'
)

for ext in "${codium_extensions[@]}" ;do
    codium --install-extension $ext
    echo "[INSTALLING] VSCodium extension: $ext ✅ "
    sleep 1
done

cp vscodium/settings.json $HOME/Library/Application\ Support/VSCodium/User
echo "[IMPORT] VSCodium User settings ✅ "
