#!/bin/bash

export FT_LINE1=7
export FT_LINE2=15

if [[ -z "$FT_LINE1" || -z "$FT_LINE2" ]]; then
	echo "Les variables FT_LINE1 et FT_LINE2 doivent être définies."
    exit 1
fi

suffix="_"

usernames=$(cat /etc/passwd | \
    sed '/^#/d' | \
    cut -d ':' -f 1 | \
    sort -r | \
    sed -n "${FT_LINE1},${FT_LINE2}p")

modified_usernames=()
while read -r username; do
    modified_usernames+=("${username}${suffix}")
done <<< "$usernames"

result=$(IFS=', '; echo "${modified_usernames[*]}.")
echo "$result"

