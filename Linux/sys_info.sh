#!/bin/bash
# Mike Wagner
# 02/2022

# Ensure the script is run as root; exit if not
if [ $UID -ne 0 ]
then
  echo "Please run this script with sudo."
  exit
fi

# Define the file that stores this script's output
output=$HOME/research/sys_info.txt

# Define a variable that shows IP info
ip=$(ip addr | grep inet | tail -2 | head -1)

# Define a variable that searches for executable files
executables=$(find /home -type f -perm 777 2>/dev/null)

# Check if the research directory exists; create it if it doesn't
if [ ! -d $HOME/research ]
then
  mkdir $HOME/research
fi

# Check if the output file exists; delete it if so
if [ -f $output ]
then
  rm $output
fi

# Title and date the script was run
echo -e "A System Audit Script\n$(date)" >> $output

# The system type on which Bash is executing, in the standard GNU cpu-company-system format
echo -e "\nMachine Type:" $MACHTYPE >> $output

# OS and hardware
echo -e "\nOperating System and System Hardware:\n$(uname -a)" >> $output

# IP routing, devices, policy routing, and tunnels
echo -e "\nIP: $ip" >> $output

# The name of the current host system
echo -e "\nHostname: $(hostname -s)" >> $output

# The operational parameters of the DNS resolver
echo -e "\nDNS Servers:\n$(cat /etc/resolv.conf)" >> $output

# The total amount of physical and swap memory, as well as free and used memory
echo -e "\nMemory Status:\n$(free)" >> $output

# CPU architecture information from sysfs and /proc/cpuinfo
echo -e "\nCPU Architecture:\n$(lscpu | grep CPU)" >> $output

# File system disk space usage
echo -e "\nDisk Statistics:\n$(df -H | head -2)" >> $output

# Show who is logged on to the system
echo -e "\nUsers currently logged in:\n$(who)" >> $output

# Files with executable permissions in or underneath the /home directory
echo -e "\nExecutable Files:" >> $output
echo $executables >> $output

# A snapshot of the top 10 currently running processes
echo -e "\nTop 10 Processes:" >> $output
ps aux --sort -%mem | awk {'print $1, $2, $3, $4, $11'} | head >> $output
