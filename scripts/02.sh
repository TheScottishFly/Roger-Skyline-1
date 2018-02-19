#!/bin/bash

mkdir $HOME/.crontask 2> /dev/null
cp 02.sh $HOME/.crontask
apt-get update -y && apt-get upgrade -y >> /var/log/update_script.log
if ! grep '.crontask/02.sh' /etc/crontab
then
    echo "0 4 * * 0 $HOME/.crontask/02.sh" >> /etc/crontab
    service cron restart
else
    echo "Task is already in crontab !"
fi
