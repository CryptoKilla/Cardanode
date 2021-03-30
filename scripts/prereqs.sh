#!/bin/bash

echo " ~*~*~*~**~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~**~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~**~*~*~*~*~*~*~*~*~*~*~*~"
echo "|This script will setup a Ubuntu 20.04 server with all the prereqs to run any type of Cardano node.|"
echo "|It will install all of the required libraries, Glasgow Haskell Compiler, Cabal & Libsodium.       |"
echo "|This script has been tested on Ubuntu 20.04 and should work for any Ubuntu or Debain based system.|"
echo "|The script comes with no warranty. Please exercise caution and use at your own risk.              |"
echo "|Be sure to veryify all scripts are up-to-date before using to deploy a Cardano node.              |"
echo "|This script is built to deploy Cardano node 1.25.1                                                |"
echo "|Please remain at your computer to respond to promts in the script as needed.                      |"
echo "|~*~*~*~**~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~**~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~**~*~*~*~*~*~*~*~*~*~*~*~|"

#1. update/upgrade system

echo "Checking your system for updates/upgrades, stand by."

sudo apt update && sudo apt upgrade -y

echo "."
echo ".."
echo "..."
sleep 5

#2. Download and install the required libraries to run the node

echo "Downloading and installing the required libraries..." 

sudo apt-get install -y curl python3 build-essential pkg-config libffi-dev libgmp-dev libssl-dev libtinfo-dev systemd libsystemd-dev libsodium-dev zlib1g-dev yarn make g++ jq libncursesw5 libtool autoconf git tmux htop nload
export LD_LIBRARY_PATH="/usr/local/lib:$LD_LIBRARY_PATH"

echo "."
sleep 1
echo ".."
sleep 1
echo "..."
sleep 5

#3. Download and instal Cabal 3.2.0.0

echo "Downloading and installing Cabal 3.2.0.0"

mkdir git
cd git

wget https://downloads.haskell.org/~cabal/cabal-install-3.2.0.0/cabal-install-3.2.0.0-x86_64-unknown-linux.tar.xz
tar -xf cabal-install-3.2.0.0-x86_64-unknown-linux.tar.xz
rm cabal-install-3.2.0.0-x86_64-unknown-linux.tar.xz cabal.sig

mkdir -p ~/.local/bin
mv cabal ~/.local/bin/

export PATH="~/.local/bin:$PATH" >> ~/.bashrc 
source ~/.bashrc 
echo $PATH

cd

cabal update
cabal --version

echo "Cabal version should be 3.2.0.0"

echo "."
sleep 1
echo ".."
sleep 1
echo "..."
sleep 5

#4. Download and install Glasgow Haskell Compiler 8.10.2

echo "Downloading and installing Glasgow Haskell Compiler 8.10.2"

mkdir -p ~/src
cd ~/src

wget https://downloads.haskell.org/ghc/8.10.2/ghc-8.10.2-x86_64-deb9-linux.tar.xz
tar -xf ghc-8.10.2-x86_64-deb9-linux.tar.xz
rm ghc-8.10.2x86_64-deb9-linux.tar.xz
cd ghc-8.10.2
./configure
sudo make install

ghc --version

echo "GHC version should be 8.10.2"

echo "."
sleep 1
echo ".."
sleep 1
echo "..."
sleep 5

#5. build the required Libsodium library
echo "Building the Libsodium Library"

git clone https://github.com/input-output-hk/libsodium
cd libsodium
git checkout 66f017f1
./autogen.sh
./configure
make
sudo make install

export LD_LIBRARY_PATH="/usr/local/lib:$LD_LIBRARY_PATH" >> ~/.bashrc
export PKG_CONFIG_PATH="/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH" >> ~/.bashrc
source ~/.bashrc

echo "."
sleep 1
echo ".."
sleep 1
echo "..."
sleep 5

echo "Your system is now ready to install the Cardano node & relay."
echo "You can find an automated script like this one that can be used to to configure and deploy the node in the following repository. https://github.com/CryptoKilla/Cardanode"

echo "."
sleep 1
echo ".."
sleep 1
echo "..."
sleep 5

echo "If you wish to help support my projects so that I can dedicate more time to coding I accept BTC ADA ETH & XTZ"
echo "BTC: 14WDzkNAFfJ1XwzAnuUfUDwTTHNvWAfAuV"
echo "ADA: addr1qxpexjq69fgxj0lts8643kfup5ft5ztsa4sk46nxfs8pt73wnvrwqem4cxvm0ud76azzhm022wrdffyv868zz9txt2hsvcq8vp"
echo "ETH: 0xBfF450302219e89860446964B8Fb4935B670b9E6"
echo "XTZ: tz2UQWshzjShMa19vrPdpAMLPxucezRzbmku"

echo "."
sleep 1
echo ".."
sleep 1
echo "..."
sleep 10
