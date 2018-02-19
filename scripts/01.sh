#!/bin/bash

cat /etc/passwd | sed 's/ //g' | sed 's/:/ /g' | awk '{printf("%s:%s:%s\n", $1, $3, $6)}'
