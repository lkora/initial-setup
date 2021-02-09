#!/bin/bash

# Running an initial update/upgrade
echo "-----------------------------------------"
echo "--- Running an apt update and upgrade ---"
echo "-----------------------------------------"
sudo apt-get -qq update && sudo apt-get -qq -y upgrade

# Inital message
sudo apt-get -qq -y install figlet

figlet "Kora's Ubuntu 20.04 initial setup" 


################################################################

# Adding ppa's
echo "----------------------------------"
echo "--- Opening lists/ppa_list.dat ---"
echo "----------------------------------"
ppa_list_file=lists/ppa_list.dat
while IFS= read -r line || [[ "$line" ]]; do
	if [ ! -z "$line" ]
	then			# Line not empty
		echo "- Adding: $line"
		sudo add-apt-repository -qq -y $line
	fi
done < $ppa_list_file

echo "--- Done! --- \n"

################################################################

#Installing all the apt packages
echo "--------------------------------------"
echo "--- Opening lists/apt_packages.dat ---"
echo "--------------------------------------"
apt_list_file=lists/apt_packages.dat
# apt_package_array=() Trying to find a way to work with array
apt_package_str=""
echo "--- List of packages to be installed:"

while IFS= read -r line || [[ "$line" ]]; do
	if [ ! -z "$line" ] # Line not empty
	then			
		echo "- $line "
		# apt_package_array+=("$line")
		apt_package_str+="$line "
	fi
done < $apt_list_file


echo "-------------------------------"
echo "--- Installing apt packages ---"
echo "-------------------------------"
sudo apt-get -qq -y install $apt_package_str

echo "--- Done! --- \n"

################################################################

#Installing all the snap packages
echo "---------------------------------------"
echo "--- Opening lists/snap_packages.dat ---"
echo "---------------------------------------"
snap_list_file=lists/snap_packages.dat
# snap_package_array=() Trying to find a way to work with array
snap_package_str=""
echo "--- List of packages to be installed:"

while IFS= read -r line || [[ "$line" ]]; do
	if [ ! -z "$line" ] # Line not empty
	then			
		echo "- $line "
		# snap_package_array+=("$line")
		snap_package_str+="$line "
	fi
done < $snap_list_file


echo "--------------------------------"
echo "--- Installing snap packages ---"
echo "--------------------------------"
sudo snap -qq -y install $snap_package_str

echo "--- Done! --- \n"


################################################################

echo "----------------------------------------"
echo "--- Moving themes and configurations ---"
echo "----------------------------------------"

# Moving themes and background
mkdir /usr/share/themes
sudo cp -a data/themes/. /usr/share/themes
sudo cp -a data/background/. /usr/share/backgrounds

# Making a base file structure
mkdir ~/Documents/fakultet
mkdir ~/Documents/books
mkdir ~/Documents/SystemPro
mkdir ~/Pictures/screenshots

# Configuring the extensiosns
mkdir ~/.local/share/gnome-shell/extensions
sudo cp -a data/gnome/. ~/.local/share/gnome-shell/extensions

echo "--- Done! --- \n"

################################################################

echo "---------------------------------"
echo "--- Installing other packages ---"
echo "---------------------------------"
mkdir downloaded
cd downloaded

echo "--- Google Chrome --- "
mkdir chrome
cd chrome
wget "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
sudo sudo dpkg -i ./google-chrome-stable_current_amd64.deb
cd ..

echo "----------------------------------------"

echo "--- Discord ---"
mkdir discord
cd discord
wget " https://dl.discordapp.net/apps/linux/0.0.13/discord-0.0.13.deb"
sudo sudo dpkg -i ./discord*.deb
cd ..

echo "----------------------------------------"

echo "--- Anaconda ---"
sudo apt-get install libgl1-mesa-glx libegl1-mesa libxrandr2 libxrandr2 libxss1 libxcursor1 libxcomposite1 libasound2 libxi6 libxtst6
mkdir anaconda
cd anaconda
wget "https://repo.anaconda.com/archive/Anaconda3-2020.11-Linux-x86_64.sh"
sha256sum Anaconda3*.sh
bash Anaconda*.sh
cd ..

echo "----------------------------------------"

# Inital message
figlet "Done!"

