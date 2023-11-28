#!/bin/bash

# Define the URLs of your blocklists
ALL_LIST_URL="https://raw.githubusercontent.com/VictorBjorke/NetGuardian-AdGuard-Edition/master/lists/pi_blocklist_porn_all.list"
TOP1M_LIST_URL="https://raw.githubusercontent.com/VictorBjorke/NetGuardian-AdGuard-Edition/master/lists/pi_blocklist_porn_top1m.list"

# Download the blocklists and combine them into one file
curl -s $ALL_LIST_URL -o combined_list.txt
curl -s $TOP1M_LIST_URL >> combined_list.txt

# Remove duplicates from the combined list
sort -u combined_list.txt -o combined_list.txt

# Function to check if a domain is in the combined list
check_domain() {
    local domain=$1

    if grep -q $domain combined_list.txt; then
        echo "$domain is found in the blocklists."
    else
        echo "$domain is NOT found in the blocklists."
    fi
}

# Ask user for a domain to check
read -p "Enter the domain to check: " domain

# Check the domain in the combined list
check_domain $domain

# Cleanup
rm combined_list.txt

