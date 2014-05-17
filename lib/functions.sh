function logging {
	log_file=/$tmp_dir/wifi-bt-fix.log
	message="$1"
	echo $message
	sudo echo "$(date) $message" >> $log_file
}

function download {
	link="$1"
	logging "Downloading file from $1..."
	cd $tmp_dir
	sudo curl -O $1
}

function check_root {
	#Check if the script is run as root
	if [ "$(id -u)" -eq 0 ];then
        	logging "Script as been executed as root, please run it again as a user (without sudo)"
        	exit 1
	fi
}
