#!/bin/bash

domain_name=www.example.com
# get the end date from URL
certEndDateGMTOrig=$(echo "Q" | openssl s_client -connect $domain_name:443 | openssl x509 -sha1 -noout -enddate | cut -d= -f2)
certEndDateGMT=$(echo "$certEndDateGMTOrig" | sed 's/[0-9][0-9]:[0-9][0-9]/00:01/')
echo "Original: ($certEndDateGMTOrig) and No Time: ($certEndDateGMT)"
# Convert to timestamp 
certEndDateEST=$(date -d "$certEndDateGMT" +"%s")

# Use the follow to test by assigning a date
#curDateEST=$(date -d "91 Days" +"%s")
curDateEST=$(date +"%s")

echo "End Date is : $certEndDateEST and Current: $curDateEST"

if [ $(expr $certEndDateEST - $curDateEST) -lt 0 ]; then
  # stop Apache HTTPD for Let's Encrypt to use the ports
  service httpd stop
  echo "Stop completed"

  sleep 15

  # testing renew
  #/opt/certbot-auto renew --dry-run
  # actual renew
  /opt/certbot-auto renew --quiet --no-self-upgrade

  echo "renew completed"

  service httpd start
  echo "start completed"
fi

