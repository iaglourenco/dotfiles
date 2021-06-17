echo "Installing WhiteSur Theme"
git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git
tar -xvf WhiteSur-gtk-theme/stable-release/Gnome-3-28/*.tar.xz $HOME/.themes

echo "Installing WhiteSur Icons"
git clone https://github.com/vinceliuice/WhiteSur-icon-theme.git
./WhiteSur-icon-theme/install.sh

echo "Installing WallScript"
touch wallcron.cron
echo "0 * * * * /home/iago/Projects/dotfiles/wallscript.sh >> "/home/iago/Projects/dotfiles/wallmac.log"" >> wallcron.cron
crontab wallcron.cron
rm -f wallcron.cron

echo "Unzipping wallpapers"
unzip ./assets/Dynamic\ Wallpapers.zip -d $HOME/Pictures