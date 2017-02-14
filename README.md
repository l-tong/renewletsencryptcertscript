# renewletsencryptcertscript
This shell script is used to check if the Let's Encrypt certificate is expering.  The script is for a CentOS/RHEL environment which has Let's Encrypt (https://letsencrypt.org/) configure with Apache HTTPD and Cetbot https://certbot.eff.org/ installed under /opt/ directory.

# Usage
1. Download the certAutoRenew.sh file under /opt/ directory
2. Add a cron job to during early AM time.  For example: 10 1 * * * /opt/certAutoRenew.sh >> /var/log/servercertrenew.log 2>&1
