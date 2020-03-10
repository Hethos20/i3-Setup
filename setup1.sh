clear

#temp file for grep output check
TFile=$HOME/i3-Setup/.temp.txt
#path to error output file
ERFile=$HOME/i3-Setup/Error2.txt

cd $HOME
mkdir Documents Downloads Desktop Music Pictures Public Videos .programs .games .scripts .config .vim Projects .themes .icons
mkdir .vim/plugged
cp -ar $HOME/i3-Setup/home/.config/* $HOME/.config
cp -ar $HOME/i3-Setup/home/.scripts/* $HOME/.scripts
cp -a $HOME/i3-Setup/home/{.bashrc,.profile,.vimrc,.Xresources} $HOME

cd $HOME/.programs

echo "1.1: installing Firefox-nightly" | tee -a $ERFile
wget "https://download.mozilla.org/?product=firefox-nightly-latest-ssl&os=linux64&lang=en-US" -O firefox.tar.bz2 >> $ERFile 2>&1
tar -xvf firefox.tar.bz2 >> $ERFile 2>&1
rm firefox.tar.bz2

echo "1.2: installing Bitwarden" | tee -a $ERFile
wget "https://vault.bitwarden.com/download/?app=desktop&platform=linux" -O bitwarden.AppImage >> $ERFile 2>&1
sudo chmod +x bitwarden.AppImage

echo "1.3: installing Dmenu" | tee -a $ERFile
git clone https://git.suckless.org/dmenu >> $ERFile 2>&1
sudo apt-get install libx11-dev libxinerama1 libxinerama-dev libxft-dev -yy >> $ERFile 2>&1
sudo make clean install >> $ERFile 2>&1

cd $HOME/.games

echo "1.4: installing Artix launcher" | tee -a $ERFile
wget "https://launch.artix.com/latest/Artix_Games_Launcher-x86_64.AppImage" -O artix.AppImage >> $ERFile 2>&1
sudo chmod +x artix.AppImage

cd $HOME

echo "2.0: configuring personalization"
mkdir $HOME/Pictures/Wallpapers
cd $HOME/i3-Setup

cat /etc/passwd >> $TFile

if grep -q "red" $TFile; then
	cp Wallpapers/red_space_wallpaper_1920x1080.jpg $HOME/Pictures/Wallpapers
	cat $HOME/i3-Setup/colors/red >> $HOME/.config/i3/config
	echo "exec_always --no-startup-id feh --bg-center $HOME/Pictures/Wallpapers/red_space_wallpaper_1920x1080.jpg" >> $HOME/.config/i3/config

elif grep -q "blue" $TFile; then
	echo "		Installing themes"
	cd $HOME/.themes
	wget "https://dllb2.pling.com/api/files/download/j/eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjE1NzcxODIzNTQiLCJ1IjpudWxsLCJsdCI6ImRvd25sb2FkIiwicyI6Ijk1MWNjNDIyYTRhOWIzNDE1ZjcyOTQ4MWQyMjRiMDY4YmU2NDg4NTdkYTViMmJkYTgyYjAwZDBjZDE1YmI1ODc5NWM5MzhiN2I5MDQzNDg1NDQwZjJlMGNhYTM1OGZjYzE4ZTYyNGEyYmRhNDk2ZTU2ZWE3OGM1MDFiNTk1ZWI4IiwidCI6MTU4MzgxMTc5MCwic3RmcCI6ImQ5OGVjZTkzMWJkM2E4NmVmM2ZlOGI5ZmIyNDM0NWY4Iiwic3RpcCI6IjE2Mi4yMjIuODMuMTU4In0.0jxUSwUI1epjpcNewrYUqwff9GllKfBcI0w61vl4V-w/05-Flat-Remix-GTK-Blue-Dark_20191224.tar.xz" -O Flat-Remix-Blue-Dark.tar.xz
	tar -xvf Flat-Remix-Blue-Dark.tar.xz
	rm Flat-Remix-Blue-Dark.tar.xz
	
	echo "		Installing icons"
	cd $HOME/.icons
	wget "https://dllb2.pling.com/api/files/download/j/eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6IjE1NzkyNjMwOTYiLCJ1IjpudWxsLCJsdCI6ImRvd25sb2FkIiwicyI6ImUzZDg1ZGQ0NjJjZGI3YTg2YmY3MmZhYjUwZmM4NDVhMGM5ZjE2YTVlOTIxNmViYjkyMzg4ZjMyODc0YTJmNzE3Zjc2MWM1NGIyZDFmYTY4ZDc4YmJiOThlY2Y4YTdkNDEwYTc2MTAwYmUwYjQ0ODhlZGNlNjg0MTU5ZDk0NTllIiwidCI6MTU4MzgxMjM3MCwic3RmcCI6ImQ5OGVjZTkzMWJkM2E4NmVmM2ZlOGI5ZmIyNDM0NWY4Iiwic3RpcCI6IjE2Mi4yMjIuODMuMTU4In0.WkmW5veE2ri8BNOAwXCMHfNeq1zfsf99_90mAfhpjGA/02-Flat-Remix-Blue-Dark_20200117.tar.xz" -O Flat-Remix-Blue-Dark-icons.tar.xz
	tar -xvf Flat-Remix-Blue-Dark-icons.tar.xz
	rm Flat-Remix-Blue-Dark-icons.tar.xz
	
	echo "		Installing wallpaper"
	cp Wallpapers/blue_galaxy_2560x1440p.jpg $HOME/Pictures/Wallpapers
	cat $HOME/i3-Setup/colors/blue >> $HOME/.config/i3/config
	echo "exec_always --no-startup-id feh --bg-center $HOME/Pictures/Wallpapers/blue_galaxy_2560x1440p.jpg" >> $HOME/.config/i3/config

	echo "After you finished setup2, go to lxappearence to change themes and icons"

elif grep -q "black" $TFile; then
	cp Wallpapers/black_triangle_1920x1080p.jpg $HOME/Pictures/Wallpapers
	echo "exec_always --no-startup-id feh --bg-center $HOME/Pictures/Wallpapers/black_triangle_1920x1080p.jpg " >> $HOME/.config/i3/config

elif grep -q "green" $TFile; then
	cp Wallpapers/green_1080p.jpg $HOME/Pictures/Wallpapers
	cat $HOME/i3-Setup/colors/green >> $HOME/.config/i3/config
	echo "exec_always --no-startup-id feh --bg-center $HOME/Pictures/Wallpapers/green_1080p.jpg" >> $HOME/.config/i3/config

else
	echo "color not assigned"
fi

echo "2.1: give execute permission to scripts"
sudo chmod +x $HOME/.scripts/*
