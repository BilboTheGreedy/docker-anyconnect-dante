#!/bin/bash
if [ -z "$CERT" ]
then
  echo $1 |openconnect $ANYCONNECT_SERVER --user=$ANYCONNECT_USER -b
else
  echo $1 |openconnect $ANYCONNECT_SERVER --user=$ANYCONNECT_USER --servercert=$CERT --no-dtls -b
fi

sleep 5
cat /etc/danted.conf | sed "s/\$PI/"$PI"/" >> /etc/danted.conf

/usr/sbin/danted -f /etc/danted.conf -D

socat -d TCP4-LISTEN:$LP1,fork TCP4:$JUMP1:3389 &
socat -d TCP4-LISTEN:$LP2,fork TCP4:$JUMP2:3389 &

/bin/bash
