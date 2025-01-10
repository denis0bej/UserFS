#!/bin/bash
 
while true; do
    test -d ~/Desktop/root || mkdir ~/Desktop/root
 
    for user in `users`; do
        test -d ~/Desktop/root/$user || mkdir ~/Desktop/root/$user
        ps -u "$user" > ~/Desktop/root/$user/procs
        test -f /Desktop/root/$user/lastlogin && rm ~/Desktop/root/$user/lastlogin
    done
 
    for user in $(ls ~/Desktop/root); do
        if ! who | awk '{print $1}' | grep -q "^$user$"; then
            lastlog -u "$user" | awk 'NR==2 {print $4" "$5" "$6" "$7" "$8" "$9}' > ~/Desktop/root/$user/lastlogin
            : > ~/Desktop/root/$user/procs  # Golire fișier procs
        fi
    done
 
    sleep 30
done
