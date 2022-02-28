#!/bin/bash
# Mike Wagner
# 02/2022
# Overkill? Yep!

# Ensure the script is run as root; exit if not
if [ $UID -ne 0 ]
then
  echo "Please run this script as root."
  exit
fi

# The file that stores this script's output
output=$HOME/research/sys_info.txt

# Set up font formatting
TITLE='\e[1m' # Bold
HDR='\e[32m' # Green
NT='\e[0m' # Normal text

# The date
date=$(date)

# The machine type
machine=$MACHTYPE

# The OS and hardware
os=$(uname -a)

# The memory status
mem=$(free)

# The CPU architecture
cpu=$(lscpu | grep CPU)

# Disk usage
disk=$(df -H | head -2)

# IP info
ip=$(ip addr | grep inet | tail -2 | head -1)

# The name of the current host system
host=$(hostname -s)

# DNS server info
dns=$(cat /etc/resolv.conf)

# Who is logged in to the system
who=$(who -a)

# Search for executable files
executables=$(sudo find /home -type f -perm 777 2>/dev/null)

# The shadow and passwd files
files=('/etc/passwd' '/etc/shadow')

# The top 10 processes
top10=$(ps aux --sort -%mem | awk {'print $1, $2, $3, $4, $11'} | head | column -t)

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
echo -e "${TITLE}System Audit${NT}\n$(date)" >> $output


# --= Hardware =--
echo -e "\n${TITLE}--= HARDWARE =--${NT}" >> $output

# The system type on which Bash is executing, in the standard GNU cpu-company-system format
echo -e "\n${HDR}Machine Type:${NT} $machine" >> $output

# OS and hardware
echo -e "\n${HDR}Operating System and System Hardware:${NT}\n$os" >> $output

# The total amount of physical and swap memory, as well as free and used memory
echo -e "\n${HDR}Memory Status:${NT}\n$mem" >> $output

# CPU architecture information from sysfs and /proc/cpuinfo
echo -e "\n${HDR}CPU Architecture:${NT}\n$cpu" >> $output

# File system disk space usage
echo -e "\n${HDR}Disk Statistics:${NT}\n$disk" >> $output


# --= Connectivity =--
echo -e "\n\n${TITLE}--= CONNECTIVITY =--${NT}" >> $output

# IP routing, devices, policy routing, and tunnels
echo -e "\n${HDR}IP:${NT}$ip" >> $output

# The name of the current host system
echo -e "\n${HDR}Hostname:${NT} $host" >> $output

# The operational parameters of the DNS resolver
echo -e "\n${HDR}DNS Servers:${NT}\n$dns" >> $output


# --=Security=--
echo -e "\n\n${TITLE}--= SECURITY =--${NT}" >> $output

# Show who is logged on to the system
echo -e "\n${HDR}Users Currently Logged In:${NT}\n$who" >> $output

# Files with executable permissions in or underneath the /home directory
echo -e "\n${HDR}Files with Executable Permission(s):${NT}" >> $output
for execs in $executables
do
  echo $execs >> $output
done

# Check the permissions on files
echo -e "\n${HDR}Current Permissions for Sensitive Files in /etc:${NT}" >> $output
(for file in ${files[@]}
do
  ls -l $file
done) | column -t >> $output

# Snapshot of the top 10 processes
echo -e "\n${HDR}The Top 10 Currently Running Processes:${NT}" >> $output
echo -e "$top10\n" >> $output
