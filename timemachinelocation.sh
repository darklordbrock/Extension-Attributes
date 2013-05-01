#!/bin/sh
enabled=`/usr/bin/defaults read /Library/Preferences/com.apple.TimeMachine AutoBackup`

if [ "$enabled" == "1" ];then
validateDestination=`/usr/sbin/diskutil info $(/usr/bin/defaults read /Library/Preferences/com.apple.TimeMachine "DestinationUUIDs" | grep '"' | sed 's/"//g' | awk '{print $1}')`

	if [ "$validateDestination" == "Could not" ];then
		echo "<result>Destination not mounted</result>"
	else
		backupDestination=`/usr/sbin/diskutil info $(/usr/bin/defaults read /Library/Preferences/com.apple.TimeMachine "DestinationUUIDs" | grep '"' | sed 's/"//g' | awk '{print $1}') | grep "Mount Point" | /usr/bin/cut -c 30-`
		echo "<result>$backupDestination</result>"
	fi

else
echo "<result>Not enabled.</result>"
fi