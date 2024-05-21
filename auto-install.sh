#!/bin/bash

# Define a list of programs to install
PROGRAMS=("git" "vim" "curl" "default-jdk")

# Update the package lists for upgrades and new package installations
sudo apt-get update

# Upgrade all the installed packages to their latest version
sudo apt-get upgrade -y

# Function to check if a program is installed
is_installed() {
    type $1 > /dev/null 2>&1
}

# Function to install a program
install_program() {
    if is_installed $1; then
        echo "$1 is already installed."
    else
        echo "Installing $1..."
        sudo apt-get install $1 -y
    fi
}

# Loop through the list of programs and install them
for program in ${PROGRAMS[@]}; do
    install_program $program
done

# Install Anaconda
wget https://repo.anaconda.com/archive/Anaconda3-2020.02-Linux-x86_64.sh
bash Anaconda3-2020.02-Linux-x86_64.sh -b -p $HOME/anaconda3
eval "$($HOME/anaconda3/bin/conda shell.bash hook)"
conda init

# Install Python using Anaconda
conda create --name myenv python=3.8

# Install Go version manager
curl -sSL https://git.io/g-install | bash -s -- -d

# Print a completion message
echo "Installation complete."
