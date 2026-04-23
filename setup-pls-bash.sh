#!/bin/bash
USERFOLDER="$(whoami)"
if command -v wget &>/dev/null # yo do we have wget
then
	if [ ! -d "/home/$USERFOLDER/.pls/" ]; then
		mkdir /home/$USERFOLDER/.pls/
		wget "https://raw.githubusercontent.com/uncreativeCultist/pls/refs/heads/main/pls.sh" -P /home/$USERFOLDER/.pls/
		chmod +x "/home/$USERFOLDER/.pls/pls.sh"
		cp /home/$USERFOLDER/.bashrc /home/$USERFOLDER/.bashrcPLSBACKUP
		echo "alias pls='/home/$USERFOLDER/.pls/pls.sh'" >> /home/$USERFOLDER/.bashrc
		echo  
		echo "pls has been setup! try running 'pls help'"
	else
		echo "it looks like you already have pls installed!"
		echo "if you're sure this is a mistake, please type:"
		echo  
		echo "rm -rf /home/$USERFOLDER/.pls/"
	fi
else
  echo "the pls bash setup requires wget. please install wget!!"
fi
