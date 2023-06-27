#!/bin/bash
#
# This script searches for any SSH authorized_keys files that have duplicate keys present. 
#
# (c) 2023 Sandfly Security
# https://www.sandflysecurity.com
#
# MIT Licensed

# This script needs to be run as root to be able to read all user's .ssh directories
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root." 1>&2
   exit 1
fi

# Get list of all home directories
home_dirs=$(awk -F':' '{ print $6 }' /etc/passwd)

for dir in $home_dirs; do
    # Check if the authorized_keys file exists
    if [ -f $dir/.ssh/authorized_keys ]; then
        # Sort keys, count duplicates, and print any with count > 1
        echo "Processing $dir/.ssh/authorized_keys."
        sort "$dir/.ssh/authorized_keys" | uniq -c | while read count key
        do
            if [ "$count" -gt 1 ]; then
                echo "$key is duplicated $count times"
            fi
        done
    fi
done