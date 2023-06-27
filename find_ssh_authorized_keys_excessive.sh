#!/bin/bash
#
# This script searches for any SSH authorized_keys files that have excessive keys present. 
#
# (c) 2023 Sandfly Security
# https://www.sandflysecurity.com
#
# MIT Licensed

# Set to your limit for excessive keys.
KEY_COUNT=10

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
        # Count the number of keys (lines) in the file
        num_keys=$(wc -l < $dir/.ssh/authorized_keys)

        # If 10 or more keys, report
        if [ $num_keys -ge $KEY_COUNT ]; then
            echo "User with home directory $dir has $num_keys keys in their authorized_keys file."
        fi
    fi
done