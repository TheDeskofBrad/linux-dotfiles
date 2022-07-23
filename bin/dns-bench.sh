#/bin/bash

if [ -z "$1" ]
  then
    echo "No argument supplied"
    exit 1
fi

DOMAIN=$1;
echo
echo "Tests common resolvers and calculates average response times by testing each resolver 3 times."
echo
echo "Cloudflare: 1.1.1.1"
echo "Level 3: 4.2.2.2"
echo "OpenDNS: 208.67.220.220"
echo "Google: 8.8.8.8"
echo "Dyn: 216.146.35.35"
echo "CIRA: 206.248.154.22"
echo
for resolver in 1.1.1.1 4.2.2.2 208.67.220.220 8.8.8.8 216.146.35.35 206.248.154.22
do
   echo $resolver
   for reps in {1..3}
   do
    dig $DOMAIN @$resolver | awk '/time/ {print $4 " ms"}'
    sleep 2
   done |awk '/ms/ {sum+=$1} END {print "Avg time: ",sum/3, " ms"}'
   echo
done
