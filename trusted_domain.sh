#!/bin/bash

read -p "Bitte geben Sie Ihre Domain ein: " new_domain

# Domain zu trusted_domain hinzufügen
sed -i "/0 => '192.168.200.80',/a\    1 => '$new_domain'," $config_file