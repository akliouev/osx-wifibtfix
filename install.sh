#!/bin/bash

#Variables
tmp_dir="/tmp/"
current_dir=$(dirname $0)

#Validating current dir
if [ "$current_dir" == "." ] || [ "$current_dir" == "./" ];then
	current_dir=$(pwd)
fi

cd $current_dir
. ./lib/functions.sh
extra_dir="$current_dir/extra/"

logging "Installing Wifi/BT fix by Setsuna666..."

check_root

logging "Downloading SleepWatcher..."
download http://www.bernhard-baehr.de/sleepwatcher_2.2.tgz

logging "Extracting SleepWatcher..."
tar -xvf /$tmp_dir/sleepwatcher_2.2.tgz -C $tmp_dir/

logging "Creating dependencies for SleepWatcher..."
sudo mkdir -p /usr/local/sbin /usr/local/share/man/man8

logging "Installing SleepWatcher..."
sudo cp /$tmp_dir/sleepwatcher_2.2/sleepwatcher /usr/local/sbin/
sudo cp /$tmp_dir/sleepwatcher_2.2/sleepwatcher.8 /usr/local/share/man/man8
sudo cp /$tmp_dir/sleepwatcher_2.2/config/de.bernhard-baehr.sleepwatcher-20compatibility.plist /Library/LaunchDaemons/

logging "Copying SleepWatcher configuration..."
sudo cp $extra_dir/rc.{sleep,wakeup} /etc/
sudo chmod a+x /etc/rc.{sleep,wakeup}

logging "Starting SleepWatcher..."
launchctl load /Library/LaunchDaemons/de.bernhard-baehr.sleepwatcher-20compatibility.plist

logging "Downloading blueutil..."
download http://www.frederikseiffert.de/blueutil/download/blueutil.dmg

logging "Mounting blueutil disk image..."
hdiutil mount /$tmp_dir/blueutil.dmg

logging "Installing blueutil..."
/Volumes/blueutil/Install.command

logging "Finished installing Wifi/BT fix"
logging "Now try to suspend and resume your Mac, your wifi should connect without issue"

exit 0
