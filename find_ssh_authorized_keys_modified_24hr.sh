#!/bin/bash
#
# This script searches for any SSH authorized_keys files modified in the last 24 hours. 
#
# (c) 2023 Sandfly Security
# https://www.sandflysecurity.com
#
# MIT Licensed

# 24 hours in seconds. Adjust to suit.
SECONDS_LIMIT=86400

# This script needs to be run as root to be able to read all user's .ssh directories
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root." 1>&2
   exit 1
fi

# Get list of all home directories
home_dirs=$(awk -F':' '{ print $6 }' /etc/passwd)

# Get the current time
now=$(date +%s)

for dir in $home_dirs; do
    # Check if the authorized_keys file exists
    if [ -f $dir/.ssh/authorized_keys ]; then
        # Get the last modification time of the file
        mtime=$(stat -c %Y $dir/.ssh/authorized_keys)

        # Calculate the difference in seconds between now and the file's mtime
        diff=$((now - mtime))

        # If the file was modified in the last 24 hours (86400 seconds)
        if [ $diff -le $SECONDS_LIMIT ]; then
            echo "User with home directory $dir has modified their authorized_keys file in the last 24 hours."
        fi
    fi
done