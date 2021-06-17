#!bin/bash

echo "Symlinking things"

ln -s $(pwd)/.gitconfig ~/.gitconfig
ln -s $(pwd)/.zshrc ~/.zshrc

# Update repositories
sudo apt-get update -y
sudo apt-get upgrade -y

# Android Studio dependencies
sudo apt-get install libc6:i386 libncurses5:i386 libstdc++6:i386 lib32z1 libbz2-1.0:i386

echo "Installing tools: (git,curl,wget,htop)"
sudo apt-get install git curl wget htop -y

echo "Installing Snap"
sudo apt-get install snapd -y

# BINARIES
echo "Installing binaries:"

echo "Installing Google Chrome"
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt-get install ./*.deb -y
rm -f *.deb

echo "Installing Spotify"
curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | sudo apt-key add - 
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt-get update && sudo apt-get install spotify-client -y

echo "Installing VS Code"
wget https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64
sudo apt-get install ./*.deb -y
rm -f *.deb

echo "Installing Discord"
wget https://discord.com/api/download?platform=linux&format=deb
sudo apt-get install ./*.deb
rm -f *.deb

echo "Installing GitKraken"
wget https://release.gitkraken.com/linux/gitkraken-amd64.deb
sudo apt-get install ./*.deb
rm -f *.deb

echo "Installing Beekeeper Studio"
wget --quiet -O - https://deb.beekeeperstudio.io/beekeeper.key | sudo apt-key add -
echo "deb https://deb.beekeeperstudio.io stable main" | sudo tee /etc/apt/sources.list.d/beekeeper-studio-app.list
sudo apt update && sudo apt install beekeeper-studio -y

echo "Installing Insomnia"
echo "deb [trusted=yes arch=amd64] https://download.konghq.com/insomnia-ubuntu/ default all" | sudo tee -a /etc/apt/sources.list.d/insomnia.list
sudo apt-get update && sudo apt-get install insomnia

echo "Installing ffmpeg"
sudo snap install ffmpeg

echo "Installing zsh"
sudo apt-get install zsh -y

echo "Making zsh the default shell"
chsh -s $(which zsh)

echo "Installing Oh-My-Zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Installing Powerline fonts"
sudo apt-get install fonts-powerline -y
echo "Installing FiraCode fonts"
sudo apt install fonts-firacode -y

echo "Installing Spaceship theme"
git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
echo "Symlinking theme"
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

echo "Applying zsh modifications"
source ~/.zshrc

echo "Done!"