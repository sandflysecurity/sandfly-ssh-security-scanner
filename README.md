# Sandfly Security SSH Scanning Scripts

Scripts to check for common security risks with SSH keys and authorized_keys files.

These are simple scripts to look for potential security issues with SSH keys and authorized_keys files as outlined in the blog post below:

<https://sandflysecurity.com/blog/ssh-key-compromise-risks-and-countermeasures/>

The scripts will help locate the following issues:

- Private keys in user's home directories.
- Duplicate keys in authorized_keys files.
- Excessive keys in authorized_keys files.
- Modified authorized_keys files in the last 24 hours.
- Keys with various options set that could pose security risks.
- An SSH authorized_keys2 file was found anywhere in a home directory.

The scripts can be used for incident response or periodic automated scanning.

## SSH Hunter

These scripts can serve as a basic tool to help find some common but severe problems. However, Sandfly offers our
agentless SSH Hunter which completely automates these and many other SSH security risk checks. If you'd like more
information please visit our website below:

<https://www.sandflysecurity.com>
