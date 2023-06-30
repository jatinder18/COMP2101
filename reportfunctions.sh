#!/bin/bash

# Function to generate the CPU report
function cpureport {
    echo "CPU Report"
    echo "==========="
    echo "CPU Manufacturer and Model: $(lscpu | awk '/Model name/ {print $3,$4,$5,$6,$7,$8}')"
    echo "CPU Architecture: $(lscpu | awk '/Architecture/ {print $2}')"
    echo "CPU Core Count: $(lscpu | awk '/Core\(s\) per socket/ {print $4}')"
    echo "CPU Maximum Speed: $(lscpu | awk '/CPU max MHz/ {print $4}') MHz"
    echo "Cache Sizes:"
    lscpu | awk '/L[1-3] cache:/ {print}'
    echo ""
}

# Function to generate the computer report
function computerreport {
    echo "Computer Report"
    echo "==============="
    echo "Computer Manufacturer: $(dmidecode -s system-manufacturer)"
    echo "Computer Description or Model: $(dmidecode -s system-product-name)"
    echo "Computer Serial Number: $(dmidecode -s system-serial-number)"
    echo ""
}

# Function to generate the OS report
function osreport {
    echo "Operating System Report"
    echo "======================"
    echo "Linux Distro: $(lsb_release -ds)"
    echo "Distro Version: $(lsb_release -rs)"
    echo ""
}

# Function to generate the RAM report
function ramreport {
    echo "RAM Report"
    echo "=========="
    echo "Installed Memory Components:"
    echo "---------------------------"
    dmidecode -t memory | awk '/Manufacturer:|Part Number:|Size:|Speed:|Locator:/{print}'
    echo ""
    echo "Total Installed RAM: $(free -h | awk '/^Mem/ {print $2}')"
    echo ""
}

# Function to generate the video report
function videoreport {
    echo "Video Report"
    echo "============"
    echo "Video Card/Chipset Manufacturer: $(lspci | awk -F':' '/VGA/{print $3}')"
    echo "Video Card/Chipset Description or Model: $(lspci | awk -F':' '/VGA/{print $3}')"
    echo ""
}

# Function to generate the disk report
function diskreport {
    echo "Disk Report"
    echo "==========="
    echo "Installed Disk Drives:"
    echo "----------------------"
    lsblk -o NAME,SIZE,MOUNTPOINT,FSTYPE | awk '$1 ~ /^sd|^nvme/ {print}'
    echo ""
}

# Function to generate the network report
function networkreport {
    echo "Network Report"
    echo "=============="
    echo "Installed Network Interfaces:"
    echo "-----------------------------"
    ip -o addr show | awk '$2 !~ /^lo/ {print}'
    echo ""
}

# Function to log and display error messages
function errormessage {
    timestamp=$(date +"%Y-%m-%d %T")
    message="$1"

    echo "[$timestamp] ERROR: $message" >> /var/log/systeminfo.log
    echo "Error: $message" >&2
}

