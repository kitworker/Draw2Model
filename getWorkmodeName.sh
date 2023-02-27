# ARGUMENTS:
#   @file dsw and commtion @device1 and @device2
# OUTPUTS:
#   Write String to stdout
# EXAMPLE:
#
# /bin/bash getWorkmodeName.sh dsw.xml R_620 R_612
#

set -x

shopt -s expand_aliases

file=$1
device1=$2
selectType=$3 

function getWorkmode() {
    xmllint --xpath "//Model[@uid='${1}']/Properties/Property[@id='workmode']/v/@name" ${file} | sort -u
}

getWorkmode ${device1} | sort -u > /tmp/workmodes1


alias getTypeWork="egrep -o "[[:alpha:]][0-1][[:alpha:]]" | sort -u";
cat /tmp/workmodes1 | getTypeWork | sort -u > /tmp/typeWorks1

alias decoratorOR="tr '[\n]| |[,]' '\|' | sed 's/.$//' | sed -E 's/\|{2,}/|/g'";


select1=$(echo $selectType | decoratorOR )

grep -E $select1 /tmp/workmodes1 | sort -u | awk -F\" '{print $2}' |  tr '\n' ','
