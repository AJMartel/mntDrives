#!/bin/bash
if [ "$UID" -ne 0 ]
  then 
    echo -e "\033[31This program must be run as root.\033[m"
    sleep 3
    sudo $0
  exit
fi

###### Install script if not installed
if [ ! -e "/usr/bin/mntDrives" ];then
	echo "Script is not installed. Do you want to install it ? (Y/N)"
	read install
	if [[ $install = Y || $install = y ]] ; then
		cp -v $0 /usr/bin/mntDrives
		chmod +x /usr/bin/mntDrives
		#rm $0
		echo "Script should now be installed. Launching it !"
		sleep 3
		mntDrives
		exit 1
	else
		echo -e "\e[32m[-] Ok,maybe later !\e[0m"
	fi
else
	echo "Script is installed"
	sleep 1
fi
### End of install process

#Set Directory for Default XBMC overflow
XBMCSHARE="/home/administrator/xbmc"
XBMCLIST="/home/administrator"
#Set auto mount directory for external USB drives 
MYDIR="/media"

DIRS=`ls -l --time-style="long-iso" $MYDIR 2>/dev/null | egrep '^d' | awk '{print $8}'`

for DIR in $DIRS
do
TVS=`ls -l --time-style="long-iso" $MYDIR/${DIR} 2>/dev/null | egrep '^d' | awk '{print $8}'`
  for TV in $TVS
  do
    if [ $TV == "TV-Series" ]; then
      echo "/media/${DIR}/TV-Series," >> $XBMCLIST/xbmcTV
    fi
    if [ $TV == "Movies" ]; then
      echo "/media/${DIR}/Movies," >> $XBMCLIST/xbmcMOV
    fi
    if [ $TV == "Music" ]; then
      echo "/media/${DIR}/Music," >> $XBMCLIST/xbmcMUS
    fi
    if [ $TV == "Pictures" ]; then
      echo "/media/${DIR}/Pictures," >> $XBMCLIST/xbmcPIC
    fi
  done
done
    
function xbmcmnt {
TVSERIES=$(cat xbmcTV | tr -d '\r\n')
mhddfs $XBMCSHARE/TV-Series,${TVSERIES%?} /mnt/TV-Series -o allow_other
MOVIES=$(cat xbmcMOV | tr -d '\r\n')
mhddfs $XBMCSHARE/Movies,${MOVIES%?} /mnt/Movies -o allow_other
MUSIC=$(cat xbmcMUS | tr -d '\r\n')
mhddfs $XBMCSHARE/Music,${MUSIC%?} /mnt/Music -o allow_other
PICTURES=$(cat xbmcPIC | tr -d '\r\n')
mhddfs $XBMCSHARE/Pictures,${PICTURES%?} /mnt/Pictures -o allow_other
echo Files that are dropped into the /mnt/TV-Series will be stored in $XBMCSHARE/TV-Series 
echo Files that are dropped into the /mnt/Movies will be stored in $XBMCSHARE/Movies 
echo Files that are dropped into the /mnt/Music will be stored in $XBMCSHARE/Music 
echo Files that are dropped into the /mnt/Pictures will be stored in $XBMCSHARE/Pictures 
}

function xbmcclr {
cat $XBMCLIST/xbmcTV $XBMCLIST/xbmcMOV $XBMCLIST/xbmcMUS $XBMCLIST/xbmcPIC >XBMC.list
chmod 666 $XBMCLIST/XBMC.list
rm $XBMCLIST/xbmcTV  2>/dev/null
rm $XBMCLIST/xbmcMOV 2>/dev/null
rm $XBMCLIST/xbmcMUS 2>/dev/null
rm $XBMCLIST/xbmcPIC 2>/dev/null
}

FILE="/usr/bin/mhddfs"
if [ -f $FILE ];
then
   xbmcmnt
   xbmcclr
else
   echo You must have mhddfs installed.   
   apt-get -y install mhddfs
   echo Creating necessary file structure.
   mkdir /mnt/TV-Series /mnt/Movies /mnt/Music /mnt/Pictures $XBMCSHARE 2>/dev/null
   mkdir $XBMCSHARE/TV-Series $XBMCSHARE/Movies $XBMCSHARE/Music $XBMCSHARE/Pictures 2>/dev/null
   xbmcmnt
   xbmcclr
fi

exit

