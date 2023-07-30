#!/bin/bash

read -p "Bitte geben Sie Ihre Domain ein: " new_domain

# Pfad zu Config-File festlegen
config_file="/var/www/html/config/config.php"

# Domain zu trusted_domain hinzufügen
sed -i "/0 => '192.168.200.80',/a\    1 => '$new_domain'," $config_file

#
while true; do
    # Fragen ob weitere Domains hinzugefügt werden sollen
    echo -n "Möchten Sie weitere Domains hinzufügen? (j/n) "
    echo
    read -n 1 answer
    if [[ "$answer" = "j" ]]; then
        # Wenn j dann nach neuer Domain fragen
        read -p "Bitte geben Sie Ihre Domain ein: " new_domain
        # Die Neue Domain in trusted_domains in der config.php einfügen
        sed -i "/1 => .*/a\    2 => '$new_domain'," $config_file
        # Den Index immer um 1 erhöhen
        ((index++))
    else
        # Falls etwas anderes wie j geantwortet wird Loop unterbrechen
        break
    fi
done