#!/bin/bash

echo "Report for myvm"

echo "==============="

echo -n "FQDN:" ; hostname





echo -n "Ip Address:" 

ip addr show | awk '/inet /{print $2}'

 




echo -n  "Root file free space: " ; du -sh


echo "================" 





