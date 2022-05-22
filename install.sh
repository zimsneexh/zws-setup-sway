echo "zimsneexh's Sway Deployment script.."
echo "Make sure to run this on a newly created User.."
echo "CTRL-C to abort.. Waiting 5 seconds..."
sleep 5

echo "Creating directories.."
mkdir ~/Desktop
mkdir ~/Documents
mkdir ~/Downloads
mkdir ~/Music
mkdir ~/Pictures
mkdir ~/Videos
mkdir .bin

echo "Building yay.."
sudo pacman -Sy base-devel git
cd .bin
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
echo "yay built!"

echo "Installing required packages.."
yay -Sy sway nordic-theme i3status nerd-fonts-jetbrains-mono ttf-jetbrains-mono rofi-lbonn-wayland-git nautilus gthumb qt5-styleplugins qt5ct kwayland 

echo "Installed packages.."

echo "Deploying .config and .wallpapers"
cp -R ./.config ~/
cp -R ./.wallpapers ~/

echo "Deployment completed!"

