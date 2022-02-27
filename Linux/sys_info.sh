#!/bin/bash
# Mike Wagner
# 02/2022

clear
echo -e "A System Audit Script\n$(date)"
echo -e "\nMachine Type:" $MACHTYPE
echo -e "\nOperating System and System Hardware:\n$(uname -a)"
echo -e "\nIP:$(ip addr | grep inet | tail -2 | head -1)"
echo -e "\nHostname: $(hostname -s)"
echo -e "\nDNS Servers:\n$(cat /etc/resolv.conf)"
echo -e "\nMemory Status:\n$(free)"
echo -e "\nCPU Architecture:\n$(lscpu | grep CPU)"
echo -e "\nDisk Statistics:\n$(df -H | head -2)"
echo -e "\nUsers currently logged in:\n$(who)\n"
