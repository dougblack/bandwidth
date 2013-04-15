#!/bin/sh

# Get active connections
connections=$(netstat -Tt -u | tr -s ' ' ' ' | awk -F ' ' '{print $5}' | tr -s '\n' ' ')
IFS=" "

# Turn it into an array
connections=($connections)

# Loop through the connections, skipping the first two elements
# since they're useless.
echo >> /home/doug/connections/reports.txt
date >> /home/doug/connections/reports.txt
for i in "${connections[@]:2}"; do

  # Strip out the port number
  filtered=$(echo $i | sed 's/:[a-zA-Z0-9]*//g')
  echo "Checking $filtered"

  # Run mtr.
  echo "$filtered" >> /home/doug/connections/reports.txt
  mtr -l --report --report-cycles 10 "$filtered" >> /home/doug/connections/reports.txt
done
