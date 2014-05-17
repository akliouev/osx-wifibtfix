#!/bin/bash

#Variables
extra_dir="extra/"
tmp_dir="/tmp/"

function logging {
	log_file=/tmp/wifi-bt-fix.log
	message="$1"
	echo $message
	sudo echo $message >> $log_file
}

function download {
	link="$1"
	logging "Downloading file from $1..."
	sudo wget -P /$tmp_dir/ $1
}


logging "Installing Wifi/BT fix by Setsuna666..."

logging "Asking for administrator privilege..."
sudo -s

logging "Downloading SleepWatcher..."
download http://www.bernhard-baehr.de/sleepwatcher_2.2.tgz

logging "Extracting SleepWatcher..."
tar -xvf /$tmp_dir/sleepwatcher_2.2.tgz

logging "Creating dependencies for SleepWatcher..."
sudo mkdir -p /usr/local/sbin /usr/local/share/man/man8

logging "Installing SleepWatcher..."
sudo cp /$tmp_dir/sleepwatcher_2.2/sleepwatcher /usr/local/sbin/
sudo cp /$tmp_dir/sleepwatcher_2.2/sleepwatcher.8 /usr/local/share/man/man8
sudo cp ~/Desktop/sleepwatcher_2.2/config/de.bernhard-baehr.sleepwatcher-20compatibilit y.plist /Library/LaunchDaemons/

logging "Copying SleepWatcher configuration..."
sudo cp /$extra_dir/rc.{sleep,wakeup} /etc/

logging "Starting SleepWatcher..."
launchctl load /Library/LaunchAgents/de.bernhard-baehr.sleepwatcher-20compatibility.plist

logging "Downloading blueutil..."
download http://www.frederikseiffert.de/blueutil/download/blueutil.dmg

logging "Mounting blueutil disk image..."
hdiutil mount /$tmp_dir/blueutil.dmg

logging "Installing blueutil..."
/Volumes/blueutil/Install.command

logging "Finished installing Wifi/BT fix"
logging "Now try to suspend and resume your Mac, your wifi should connect without issue"
exit 0
