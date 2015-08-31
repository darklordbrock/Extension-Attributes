#!/bin/bash

echo -e "GET http://apple.com HTTP/1.0\n\n" | nc apple.com 80 > /dev/null 2>&1

if [ $? -eq 0 ]; then
    echo "Online"
else
    echo "Offline"
    exit 0
fi

model=`system_profiler SPHardwareDataType | grep "Model Identifier" | awk '{ print $3 }'`
appleSite=https://support.apple.com/en-us/HT201518
machineVersion=`system_profiler SPHardwareDataType | grep "Boot ROM Version" | awk '{ print $4 }'`
currentVersion=`curl $appleSite | grep -A1 "$model" | tail -n 1 | sed 's/>/ /g' | awk '{ print $4 }'`

if [[ $machineVersion == $currentVersion ]]; then
  echo "<result>Current</result>"
else
  echo "<result>Update</result>"
fi

exit 0
