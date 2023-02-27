# ARGUMENTS:
#   @fileDsw dsw and @model and require @workmodes
# OUTPUTS:
#   Write String to stdout
# EXAMPLE:
#
# /bin/bash getWorkmodeName.sh .xml _620 "A1B A1A"
#

set -x

shopt -s expand_aliases

fileDsw=$1
model=$2
workmodes=$3

function getWorkmode() {
    xmllint --xpath "//Model[@uid='${1}']/Properties/Property[@id='workmode']/v/@name" ${fileDsw} | sort -u
}

getWorkmode ${model} | sort -u > /tmp/workmodes1


alias getTypeWork="egrep -o "[[:alpha:]][0-1][[:alpha:]]" | sort -u";
cat /tmp/workmodes1 | getTypeWork | sort -u > /tmp/typeWorks1

alias decoratorOR="tr '[\n]| |[,]' '\|' | sed 's/.$//' | sed -E 's/\|{2,}/|/g'";


select1=$(echo $workmodes | decoratorOR )

grep -E $select1 /tmp/workmodes1 | sort -u | awk -F\" '{print $2}' |  tr '\n' ','
