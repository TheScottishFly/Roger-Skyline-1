#!/bin/bash

mkdir $HOME/.crontask 2> /dev/null
cp 04.sh $HOME/.crontask
if ! grep '.crontask/04.sh' /etc/crontab
then
    echo "0 0 * * * $HOME/.crontask/04.sh" >> /etc/crontab
    service cron restart
else
    echo "Task is already in crontab !"
fi

if ! find "$HOME/.crontask" -type f -name 'crontab'
then
    sudo cp /etc/crontab "$HOME/.crontask"
elif ! find "/etc" -type f -name "crontab"
then
    echo "No crontab in /etc !"
    exit 1
fi

oldcrontab_sum=$(md5sum "$HOME/.crontask/crontab" | awk '{print $1}')
crontab_sum=$(md5sum "/etc/crontab" | awk '{print $1}')

if ["$oldcrontab_sum" = "$crontab_sum"]
then
    echo "No modification detected"
    exit 0
else
    echo "Modification detected, mail sent"
    mail -s "Modification detected in crontab" root
    sudo cp /etc/crontab "$HOME/.crontask"
    exit 0
fi
