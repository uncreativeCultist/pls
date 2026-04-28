#!/bin/bash
PLS_VER=042826a

## please update ----------------------------------
if [[ "$1" == "update" ]]; then

  if [[ "$2" == "self" ]]; then
    # Source - https://stackoverflow.com/a/246128
    # Posted by dogbane, modified by community. See post 'Timeline' for change history
    # Retrieved 2026-04-22, License - CC BY-SA 4.0
    SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
    if command -v wget &>/dev/null # yo do we have wget
    then
      rm "$SCRIPT_DIR/pls.sh"
      wget "https://raw.githubusercontent.com/uncreativeCultist/pls/refs/heads/main/pls.sh" -P $SCRIPT_DIR 
      chmod +x "$SCRIPT_DIR/pls.sh"
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

    if command -v dnf &>/dev/null # dnf handling - fedora
    then
      echo "updating dnf packages"
      sudo dnf upgrade --refresh
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

    read -p "do you wanna reboot? (you probably should if you updated a lot of stuff.) (y/n): " -n 1 -r
    echo   
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        sudo reboot
      fi
    fi
       ## please update END----------------------------------
elif [[ "$1" == "help" ]]; then
  echo "pls help - displays features (shows this list)"
  echo "pls info - displays information about pls"
  echo "pls update - updates/upgrades all packages on your system across multiple package managers (pls not included)"
  echo pls update self - updates pls
  echo "pls install - install programs to your system using multiple package managers"
  echo "pls remove - remove programs from your system using multiple package managers"
elif [[ "$1" == "install" ]]; then
  DIDWEGETIT=notyet

  if [[ "$DIDWEGETIT" != "yeah" ]]; then
    if command -v apt-get &>/dev/null # apt-get handling - debian
    then
      echo "installing using apt-get"
      if sudo apt-get install $2; then
        DIDWEGETIT=yeah
      else
        echo "couldn't find it using apt-get, continuing on..."
        echo   
        DIDWEGETIT=notyet
      fi
    fi
  fi

  if [[ "$DIDWEGETIT" != "yeah" ]]; then
    if command -v pacman &>/dev/null # pacman handling - arch
    then
      echo "installing using pacman"
      if sudo pacman -Sy $2; then
        DIDWEGETIT=yeah
      else
        DIDWEGETIT=notyet
        echo "couldn't find it using pacman, continuing on..."
        echo   
      fi
    fi
  fi

  if [[ "$DIDWEGETIT" != "yeah" ]]; then
    if command -v flatpak &>/dev/null # flatpak handling
    then
      echo "installing using flatpak"
      if sudo flatpak install $2; then
        DIDWEGETIT=yeah
      else
        DIDWEGETIT=notyet
        echo "couldn't find it using flatpak, continuing on..."
        echo   
    fi
  fi

  if [[ "$DIDWEGETIT" != "yeah" ]]; then
    if command -v dnf &>/dev/null # dnf handling - fedora
    then
      echo "installing using dnf"
      if sudo dnf install $2; then
        DIDWEGETIT=yeah
      else
        DIDWEGETIT=notyet
        echo "couldn't find it using dnf, continuing on..."
        echo   
    fi
  fi
  fi
fi


  if [[ "$DIDWEGETIT" == "yeah" ]]; then
    echo "package '$2' should be installed now!"
  else
    echo "package '$2' couldn't be found :("
  fi
elif [[ "$1" == "remove" ]]; then
  DIDWEREMOVEIT=notyet

  if [[ "$DIDWEREMOVEIT" != "yeah" ]]; then
    if command -v apt-get &>/dev/null # apt-get handling - debian
    then
      echo "uninstalling using apt-get"
      if sudo apt-get remove $2; then
        DIDWEREMOVEIT=yeah
      else
        echo "couldn't find it using apt-get, continuing on..."
        echo   
        DIDWEREMOVEIT=notyet
      fi
    fi
  fi

  if [[ "$DIDWEREMOVEIT" != "yeah" ]]; then
    if command -v pacman &>/dev/null # pacman handling - arch
    then
      echo "uninstalling using pacman"
      if sudo pacman -R $2; then
        DIDWEREMOVEIT=yeah
      else
        DIDWEREMOVEIT=notyet
        echo "couldn't find it using pacman, continuing on..."
        echo   
      fi
    fi
  fi

  # flatpak is weird and requires the EXACT package name. just commenting this out for rn
  #if [[ "$DIDWEREMOVEIT" != "yeah" ]]; then
  #  if command -v flatpak &>/dev/null # flatpak handling
  #  then
  #    echo "uninstalling using flatpak"
  #    if sudo flatpak uninstall $2; then
  #      DIDWEREMOVEIT=yeah
  #    else
  #      DIDWEREMOVEIT=notyet
  #      echo "couldn't find it using flatpak, continuing on..."
  #      echo   
  #  fi
  #fi

  if [[ "$DIDWEREMOVEIT" != "yeah" ]]; then
    if command -v dnf &>/dev/null # dnf handling - fedora
    then
      echo "uninstalling using dnf"
      if sudo dnf remove $2; then
        DIDWEREMOVEIT=yeah
      else
        DIDWEREMOVEIT=notyet
        echo "couldn't find it using dnf, continuing on..."
        echo   
    fi
  fi
fi


  if [[ "$DIDWEREMOVEIT" == "yeah" ]]; then
    echo "package '$2' should be removed now!"
  else
    echo "package '$2' couldn't be found :("
  fi
elif [[ "$1" == "info" ]]; then
  echo "pls - a stupid easy script to do things on linux"
  echo "version $PLS_VER"
  echo  
  echo "for more information, pls visit"
  echo "https://github.com/uncreativeCultist/pls"
elif [[ "$1" == "" ]]; then
  echo "pls is not supposed to be ran on it's own!  "
  echo 'maybe try "pls help" to see possible arguments?'
else
  echo "'pls $1' is not a recognized command, sorry :("
  echo 'maybe try "pls help" to see possible arguments?'
fi
