#!/bin/bash
# Quick setup script for a new server.

# Make sure the script is run as root.
if [ ! $UID -ne 0 ]
then
echo "Please run this script as root."
  exit
fi

# Create a log file that our script will use to track its progress
log_file=/var/log/setup_script.log

# Log file header
echo "Log file for general server setup script." >> $log_file
echo "############################" >> $log_file
echo "Log generated on: $(date)" >> $log_file
echo "############################" >> $log_file
echo "" >> $log_file

# List of necessary packages
packages=(
  'nano'
  'wget'
  'net-tools'
  'python'
  'tripwire'
  'tree'
  'curl'
)

# Ensure all packages are installed
for package in ${packages[@]}
do
  if [ ! $(which $package) ]
  then
    apt install -y $package
  fi
done

# Print it out and Log it
echo "$(date) Installed needed packages: ${packages[@]}" | tee -a $logfile

# Create the user sysadmin with no password (password to be created upon login)
useradd sysadmin
chage -d 0 sysadmin

# Add the user 'arnold' to the 'sudo' group
usermod -aG sudo arnold

# Print and log
echo "$(date) Created sys_admin user. Password to be created upon login." | tee -a $log_file

# Remove root's login shell and lock the root account.
usermod -s /sbin/nologin root
usermod -L root

# Print and log
echo "$(date) Disabled root shell. Root user cannot log in." | tee -a $log_file

# Change permissions on sensitive files
chmod 600 /etc/shadow
chmod 600 /etc/gshadow
chmod 644 /etc/group
chmod 644 /etc/passwd

# Print and log
echo "$(date) Changed permissions on sensitive /etc files." | tee -a $log_file

# Setup scripts folder
if [ ! -d /home/arnold/scripts ]
then
  mkdir /home/arnold/scripts
  chown arnold:arnold /home/arnold/scripts
fi

# Add scripts folder to .bashrc for arnold
echo "" >> /home/arnold/.bashrc
echo "PATH=$PATH:/home/arnold/scripts" >> /home/arnold/.bashrc
echo "" >> /home/arnold/.bashrc

# Print and log
echo "$(date) Added ~/scripts directory to sysadmin's PATH." | tee -a $log_file

# Add custom aliases to /home/arnold/.bashrc
echo "#Custom Aliases" >> /home/arnold/.bashrc
echo "alias reload='source ~/.bashrc && echo Bash config reloaded'" >> /home/arnold/.bashrc
echo "alias lsa='ls -a'" >> /home/arnold/.bashrc
echo "alias docs='cd ~/Documents'" >> /home/arnold/.bashrc
echo "alias dwn='cd ~/Downloads'" >> /home/arnold/.bashrc
echo "alias etc='cd /etc'" >> /home/arnold/.bashrc
echo "alias rc='nano ~/.bashrc'" >> /home/arnold/.bashrc

# Print and log
echo "$(date) Added custom alias collection to sysadmin's bashrc." | tee -a $log_file

#Print out and log Exit
echo "$(date) Script Finished. Exiting."
echo "$(date) Script Finished. Exiting." >> $log_file

exit
