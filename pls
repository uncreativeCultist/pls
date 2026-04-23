#!/bin/bash
PLS_VER=042326a
#echo pls - $PLS_VER
#echo -------------------

## please update ----------------------------------
if [[ "$1" == "update" ]]; then

  if [[ "$2" == "self" ]]; then
    # Source - https://stackoverflow.com/a/246128
    # Posted by dogbane, modified by community. See post 'Timeline' for change history
    # Retrieved 2026-04-22, License - CC BY-SA 4.0
    SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
    if command -v wget &>/dev/null # yo do we have wget
    then
      rm "$SCRIPT_DIR/pls"
      wget "https://raw.githubusercontent.com/uncreativeCultist/pls/refs/heads/main/pls.sh" -P $SCRIPT_DIR 
      chmod +x "$SCRIPT_DIR/pls"
      echo "pls has been updated!"
    else
      echo "update self requires wget. please install wget!!"
    fi

  else
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
      fi
    fi
       ## please update END----------------------------------
elif [[ "$1" == "help" ]]; then
  echo "pls help - displays features (shows this list)"
  echo "pls update - updates/upgrades as packages on your system across multiple package managers (pls not included)"
  echo pls update self - updates pls
else
  echo "'pls $1' is not a recognized command, sorry :("
  echo 'maybe try "pls help" to see possible arguments?'
fi
