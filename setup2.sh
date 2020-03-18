clear
cd $HOME

stage=0
part=0

#temp file for grep output check
TFile=$HOME/i3-Setup/.temp.txt
#path to error output file
ERFile=$HOME/i3-Setup/Error.txt

#Stage 0
#Check ubuntu version
echo "$stage.$part: checking ubuntu version" | tee -a $ERFile
version="none"
lsb_release -a > $TFile
if grep -q "eoan" $TFile; then
	version="eoan"
	echo "eoan detected"
elif grep -q "bionic" $TFile; then
	version="bionic"
	echo "bionic detected"
else
	echo "The OS installed is too old or isn't ubuntu"
	exit 1
fi

#Stage 1
part=$((part + 1))
stage=$((stage + 1))
echo "$stage.$part: installing lsb-core" | tee -a $ERFile
sudo apt-get install lsb-core -yy >> $ERFile 2>&1
part=$((part + 1))

echo "$stage.$part: installing i3" | tee -a $ERFile
sudo apt-get install i3 -yy >> $ERFile 2>&1
part=$((part + 1))

echo "$stage.$part: installing feh" | tee -a $ERFile
sudo apt-get install feh -yy >> $ERFile 2>&1
part=$((part + 1))

echo "$stage.$part: installing Pcmanfm" | tee -a $ERFile
sudo apt-get install pcmanfm -yy >> $ERFile 2>&1
part=$((part + 1))

echo "$stage.$part: installing urxvt" | tee -a $ERFile
sudo apt-get install rxvt-unicode -yy >> $ERFile 2>&1
xrdb $HOME/.Xresources
part=$((part + 1))

echo "$stage.$part: installing compton" | tee -a $ERFile
sudo apt-get install compton -yy >> $ERFile 2>&1
part=$((part + 1))

echo "$stage.$part: installing sxhkd" | tee -a $ERFile
sudo apt-get install sxhkd -yy >> $ERFile 2>&1
part=$((part + 1))

echo "$stage.$part: installing vim" | tee -a $ERFile
sudo apt-get install vim -yy >> $ERFile 2>&1
part=$((part + 1))

echo "$stage.$part: installing gdebi" | tee -a $ERFile
sudo apt-get install gdebi -yy >> $ERFile 2>&1
part=$((part + 1))

echo "$stage.$part: installing transmission" | tee -a $ERFile
sudo apt-get install transmission-common transmission-gtk -yy >> $ERFile 2>&1
part=$((part + 1))

echo "$stage.$part: installing software stuff" | tee -a $ERFile
sudo apt-get install git gcc make libx11-dev libxtst-dev pkg-config -yy >> $ERFile 2>&1
part=$((part + 1))

echo "$stage.$part: installing mpv" | tee -a $ERFile
sudo apt-get install mpv -yy >> $ERFile 2>&1
part=$((part + 1))

echo "$stage.$part: installing thunderbird" | tee -a $ERFile
sudo apt-get install thunderbird -yy >> $ERFile 2>&1
part=$((part + 1))

echo "$stage.$part: installing emoji fonts" | tee -a $ERFile
sudo apt-get install fonts-noto-color-emoji -yy >> $ERFile 2>&1
part=$((part + 1))

echo "$stage.$part: installing drivers" | tee -a $ERFile
sudo apt install ubuntu-drivers-common -yy >> $ERFile 2>&1
sudo ubuntu-drivers autoinstall >> $ERFile 2>&1
part=$((part + 1))

echo "$stage.$part: upgrading software" | tee -a $ERFile
sudo apt-get upgrade -yy >> $ERFile 2>&1
part=$((part + 1))

echo "$stage.$part: installing software-properties-common" | tee -a $ERFile
sudo apt-get install software-properties-common -yy >> $ERFile 2>&1
part=$((part + 1))

echo "$stage.$part: installing Retroarch" | tee -a $ERFile
sudo add-apt-repository ppa:libretro/stable -yy >> $ERFile 2>&1
sudo apt-get update -yy >> $ERFile 2>&1
sudo apt-get install retroarch* -yy >> $ERFile 2>&1
part=$((part + 1))

cd $HOME/.programs

echo "$stage.$part: installing Discord" | tee -a $ERFile
wget "https://discordapp.com/api/download?platform=linux&format=deb" -O discord.deb >> $ERFile 2>&1
sudo gdebi discord.deb --n >> $ERFile 2>&1
rm discord.deb
part=$((part + 1))

echo "$stage.$part: installing Multimc" | tee -a $ERFile
wget "https://files.multimc.org/downloads/multimc_1.4-1.deb" -O multimc.deb >> $ERFile 2>&1
sudo gdebi multimc.deb --n >> $ERFile 2>&1
rm multimc.deb
part=$((part + 1))

cd $HOME

echo "$stage.$part: installing arandr" | tee -a $ERFile
sudo apt-get install arandr -yy >> $ERFile 2>&1
part=$((part + 1))

echo "$stage.$part: installing NMTUI" | tee -a $ERFile
sudo apt-get install nmtui -yy >> $ERFile 2>&1
part=$((part + 1))

echo "$stage.$part: installing X Window System" | tee -a $ERFile
sudo apt-get install xinit xorg -yy >> $ERFile 2>&1 
part=$((part + 1))

echo "$stage.$part: installing lightdm" | tee -a $ERFile
sudo apt-get install lightdm -yy >> $ERFile 2>&1
part=$((part + 1))

echo "$stage.$part: installing steam" | tee -a $ERFile
sudo apt-get install steam -yy >> $ERFile 2>&1
part=$((part + 1))

echo "$stage.$part: installing krita" | tee -a $ERFile
sudo apt-get install krita -yy >> $ERFile 2>&1
part=$((part + 1))

echo "$stage.$part: installing calibre" | tee -a $ERFile
sudo apt-get install calibre -yy >> $ERFile 2>&1
part=$((part + 1))

echo "$stage.$part: installing curl" | tee -a $ERFile
sudo apt-get install curl -yy >> $ERFile 2>&1
part=$((part + 1))

echo "$stage.$part: installing wine" | tee -a $ERFile
sudo apt-get install gnupg1 gnupg2 -yy >> $ERFile 2>&1
sudo dpkg --add-architecture i386 >> $ERFile 2>&1
wget -nc https://dl.winehq.org/wine-builds/winehq.key >> $ERFile 2>&1
sudo apt-key add winehq.key
sudo apt-add-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ eoan main' $version main -yy >> $ERFile 2>&1
sudo apt-get update -yy >> $ERFile 2>&1
sudo apt install --install-recommends winehq-stable -yy >> $ERFile 2>&1
part=$((part + 1))

echo "$stage.$part: installing xautolock"
sudo apt-get install xautolock -yy >> $ERFile 2>&1
part=$((part + 1))

echo "$stage.$part: installing ranger"
sudo apt-get install ranger -yy >> $ERFile 2>&1
part=$((part + 1))

echo "$stage.$part: configuring vim"
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim >> $ERFile 2>&1
part=$((part + 1))

echo "$stage.$part: installing i3 blocks" | tee -a $ERFile
cd $HOME/.programs
git clone https://github.com/Airblader/i3blocks-gaps i3blocks >> $ERFile 2>&1
cd i3blocks
sudo make clean debug >> $ERFile 2>&1
sudo make install >> $ERFile 2>&1
#rm $HOME/.programs/i3blocks/scripts/volume
#cp -r $HOME/i3-Setup/volume $HOME/.programs/i3blocks/scripts
part=$((part + 1))

echo "$stage.$part: installing java 8" | tee -a $ERFile
sudo apt install openjdk-8-jre-headless -yy >> $ERFile 2>&1
part=$((part + 1))

echo "$stage.$part: installing synaptic" | tee -a $ERFile
sudo apt-get install synaptic -yy >> $ERFile 2>&1
part=$((part + 1))

echo "$stage.$part: installing syncthing" | tee -a $ERFile
sudo apt-get install syncthing -yy >> $ERFile 2>&1
part=$((part + 1))

echo "$stage.$part: installing mocp" | tee -a $ERFile
sudo apt-get install moc -yy >> $ERFile 2>&1
touch $HOME/.moc/config
echo "Theme = transparent-background" > $HOME/.moc/config
chmod g-w ~/.moc/config
part=$((part + 1))

echo "$stage.$part: installing dmenu dependencies" | tee -a $ERFile
sudo apt-get install libxinerama1 libx11-dev libxinerama-dev libxft-dev -yy >> $ERFile 2>&1
part=$((part + 1))

reboot
