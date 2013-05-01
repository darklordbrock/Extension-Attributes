#!/bin/bash
enabled=`/usr/bin/defaults read /Library/Preferences/com.apple.TimeMachine AutoBackup`

if [ "$enabled" == "1" ];then
	
	disk=`/usr/sbin/diskutil info $(/usr/bin/defaults read /Library/Preferences/com.apple.TimeMachine "DestinationUUIDs" | grep '"' | sed 's/"//g' | awk '{print $1}') | grep "Device Identifier" | /usr/bin/cut -c 30-`
	output=`diskutil corestorage info $disk | grep "Conversion Status" | /usr/bin/cut -c 32-`
	if [ "$output" == "Complete" ]; then
		echo "<result>Yes</result>"
	elif [ "$output" == "" ]; then
		echo "<result>Disk not mounted</result>"
	else
		echo "<result>No</result>"
	fi
	
else
	echo "<result>Not enabled.</result>"
fi