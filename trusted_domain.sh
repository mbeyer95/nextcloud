#!/bin/bash

read -p "Bitte geben Sie eine Domain ein: " new_domain
sed -i "/0 => '192.168.200.80',/a\    1 => '$new_domain'," $config_file