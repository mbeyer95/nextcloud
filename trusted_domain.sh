#!/bin/bash

read -p "Bitte geben Sie Ihre Domain ein: " new_domain

# Pfad zu Config-File festlegen
config_file="/var/www/html/config/config.php"

# Domain zu trusted_domain hinzufügen
sed -i "/0 => '192.168.200.80',/a\    1 => '$new_domain'," $config_file

#

index=1

while true; do
    # Ask the user if they want to add a domain
    read -p "Möchten Sie weitere Domains hinzufügen? (j/n) " answer
    if [[ "$answer" = "j" ]]; then
        # If they said 'j', ask for the domain
        read -p "Bitte geben Sie Ihre Domain ein: " new_domain
        # Insert the new domain into the trusted_domains array
        sed -i "/${index} => .*/a\    ${index} => '$new_domain'," $config_file
        # Increase the index for the next domain
        ((index++))
    else
        # If they said anything other than 'j', break the loop
        break
    fi
done