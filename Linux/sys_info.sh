#!/bin/bash
# Mike Wagner
# 02/2022

# Define the file that stores this script's output
output=$HOME/research/sys_info.txt

# Title and date this script was run
# (I'm intentionally overwriting an existing file by using only one greater than symbol here)
echo -e "A System Audit Script\n$(date)" > $output

# The system type on which Bash is executing, in the standard GNU cpu-company-system format
echo -e "\nMachine Type:" $MACHTYPE >> $output

# OS and hardware 
echo -e "\nOperating System and System Hardware:\n$(uname -a)" >> $output

# IP address 
echo -e "\nIP:$(ip addr | grep inet | tail -2 | head -1)" >> $output

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
echo -e "\nUsers currently logged in:\n$(who)\n" >> $output
