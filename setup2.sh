#temp file for grep output check
TFile=$HOME/i3-Setup/.temp.txt
#path to error output file
ERFile=$HOME/i3-Setup/Error2.txt

cd $HOME
cp -r i3-Setup/home/* .

echo "1.1: installing i3 blocks" | tee -a $ERFile
cd $HOME/.programs
git clone https://github.com/Airblader/i3blocks-gaps i3blocks >> $ERFile 2>&1
cd i3blocks
sudo make clean debug >> $ERFile 2>&1
sudo make install >> $ERFile 2>&1
rm $HOME/.programs/i3blocks/scripts/volume
cp -r $HOME/i3-Setup/volume $HOME/.programs/i3blocks/scripts

cd $HOME/.programs

echo "1.2: installing Firefox-nightly" | tee -a $ERFile
wget "https://download.mozilla.org/?product=firefox-nightly-latest-ssl&os=linux64&lang=en-US" -O firefox.tar.bz2 >> $ERFile 2>&1
tar -xvf firefox.tar.bz2 >> $ERFile 2>&1
rm firefox.tar.bz2

echo "1.3: installing Bitwarden" | tee -a $ERFile
wget "https://vault.bitwarden.com/download/?app=desktop&platform=linux" -O bitwarden.AppImage >> $ERFile 2>&1
sudo chmod +x bitwarden.AppImage

echo "1.4: installing Dmenu" | tee -a $ERFile
git clone https://git.suckless.org/dmenu >> $ERFile 2>&1
sudo apt-get install libx11-dev libxinerama1 libxinerama-dev libxft-dev -yy >> $ERFile 2>&1
sudo make clean install >> $ERFile 2>&1

cd $HOME/.games

echo "1.5: installing Artix launcher" | tee -a $ERFile
wget "https://launch.artix.com/latest/Artix_Games_Launcher-x86_64.AppImage" -O artix.AppImage >> $ERFile 2>&1
sudo chmod +x artix.AppImage

cd $HOME

echo "2.1: configuring .bashrc" | tee -a $ERFile
rm .bashrc
cp i3-Setup/.bashrc .

echo "2.2: configuring .profiles" | tee -a $ERFile
rm .profile
cp i3-Setup/.profile .

echo "2.3: moving custom scripts to home directory" | tee -a $ERFile
cp -r i3-Setup/.scripts .

echo "2.4: copying the .config directory" | tee -a $ERFile
cp -r i3-Setup/.config .

echo "2.5: configuring urxvt" | tee -a $ERFile
cp -r i3-Setup/.Xresources
xrdb $HOME/.Xresources

#echo "2.6: configuring vim plugins" | tee -a $ERFile
#curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
#    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim >> $ERFile 2>&1
#cp -r i3-Setup/.vimrc $HOME

echo "2.7: configuring wallpaper"
mkdir $HOME/Pictures/Wallpapers
cd $HOME/i3-Setup

cat /etc/passwd >> $TFile

if grep -q "red" $TFile; then
	cp Wallpapers/red_space_wallpaper_1920x1080.jpg $HOME/Pictures/Wallpapers
	echo "exec_always --no-startup-id feh --bg-center $HOME/Pictures/Wallpapers/red_space_wallpaper_1920x1080.jpg" >> $HOME/.config/i3/config

elif grep -q "blue" $TFile; then
	cp Wallpapers/blue_galaxy_2560x1440p.jpg $HOME/Pictures/Wallpapers
	echo "exec_always --no-startup-id feh --bg-center $HOME/Pictures/Wallpapers/blue_galaxy_2560x1440p.jpg" >> $HOME/.config/i3/config

elif grep -q "black" $TFile; then
	cp Wallpapers/black_triangle_1920x1080p.jpg $HOME/Pictures/Wallpapers
	echo "exec_always --no-startup-id feh --bg-center $HOME/Pictures/Wallpapers/black_triangle_1920x1080p.jpg " >> $HOME/.config/i3/config

elif grep -q "green" $TFile; then
	cp Wallpapers/green_1080p.jpg $HOME/Pictures/Wallpapers
	echo "exec_always --no-startup-id feh --bg-center $HOME/Pictures/Wallpapers/green_1080p.jpg" >> $HOME/.config/i3/config

else
	echo "color not assigned"
fi