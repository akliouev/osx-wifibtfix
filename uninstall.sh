#!/bin/bash

. ./lib/functions.sh

logging "Uninstalling blueutil..."
sudo rm /usr/local/bin/blueutil

logging "Uninstalling SleepWatcher..."
sudo rm /usr/local/sbin/sleepwatcher
sudo rm /usr/local/share/man/man8/sleepwatcher.8
sudo rm /etc/rc.sleep
sudo rm /etc/rc.wakeup
sudo rm /Library/LaunchDaemons/de.bernhard-baehr.sleepwatcher-20compatibility.plist

logging "Stopping SleepWatcher..."
sudo killall sleepwatcher

logging "Uninstall finished"
