#!/bin/bash

## please update ----------------------------------
if [[ "$1" == "update" ]]; then
  if command -v apt &>/dev/null # apt handling - debian
  then
    echo "updating apt packages"
    sudo apt update
    sudo apt upgrade
  elif command -v apt-get &>/dev/null # apt handling - debian
  then
    echo "updating apt packages"
    sudo apt-get update
    sudo apt-get upgrade
  fi

  if command -v pacman &>/dev/null # pacman handling - arch
  then
    echo "updating pacman packages"
    sudo pacman -Syu
  fi

  if command -v flatpak &>/dev/null # flatpak handling
  then
    echo "updating flatpaks"
    sudo flatpak update
  fi

  if command -v chwd &>/dev/null # chwd handling - cachyos
  then
    #echo "ishowdrivers: lets update!" #what the fuck was i thinking
    echo "updating drivers"
    sudo chwd -a
  fi

  if command -v yay &>/dev/null # AUR handling - arch - yay
  then
    read -p "do you wanna update AUR stuff? this could take a while. (y/n): " -n 1 -r
    echo   
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        yay -Syu
    fi
  fi

  read -p "do you wanna reboot? (you probably should tbh) (y/n): " -n 1 -r
  echo   
  if [[ $REPLY =~ ^[Yy]$ ]]
  then
      sudo reboot
  fi ## please update END----------------------------------
elif [[ "$1" == "install" ]]; then
  echo pretend this is installing/updating
else
  echo "i dunno wut 2 do?"
fi
