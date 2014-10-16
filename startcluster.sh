#!/bin/bash

#This demo is test zookeeper auto config

echo "-------- test network ----------"
NetCon=$(docker run -d -p 2010:2181 zookeeper:3.4.6)
NetIP=$(docker inspect $NetCon | grep IPAd | awk -F'"' '{print $4}')
sleep 3

echo "-------- start auto get ips -----------"
sub="172.17.0."
count=$(echo $NetIP | cut -f4 -d '.')
echo $count
ZKMASTER=$(expr $count + 1)
ZKSLAVE1=$(expr $count + 2)
ZKSLAVE2=$(expr $count + 3)
ZKMASTER=$sub$ZKMASTER
ZKSLAVE1=$sub$ZKSLAVE1
ZKSLAVE2=$sub$ZKSLAVE2

echo $ZKMASTER $ZKSLAVE1 $ZKSLAVE2
docker stop $NetCon

docker run -d -e ZOOKEEPER_PEERS=${ZKMASTER},${ZKSLAVE1},${ZKSLAVE2} -e IP=${ZKMASTER} -p 2015:2181 zookeeper:3.4.6
docker run -d -e ZOOKEEPER_PEERS=${ZKMASTER},${ZKSLAVE1},${ZKSLAVE2} -e IP=${ZKSLAVE1} -p 2016:2181 zookeeper:3.4.6
docker run -d -e ZOOKEEPER_PEERS=${ZKMASTER},${ZKSLAVE1},${ZKSLAVE2} -e IP=${ZKSLAVE2} -p 2017:2181 zookeeper:3.4.6
