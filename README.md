# CONSUL SCHEDULE BACKUP

Schedule backup (snapshot) for consul key/value with cronjob

## Configurations
* Setup Environment:
  ```
  ENV="0"    # (0 = staging, 1 = production)
  ```
* Setup Token:
  ```
  TOKEN_AUTH_PROD="[YOUR_PROD_ACL_MASTER_TOKEN]"
  TOKEN_AUTH_STAGING="[YOUR_STAGING_ACL_MASTER_TOKEN]"
  ```
* Setup cronjob
  ```
  crontab -e
  ```
* Add last line:
  ```
  ## Daily Backup K/V every 30 minutes
  */30 * * * * bash /root/cs-backup-dday.sh

  ## Daily Backup K/V at 1.00pm
  0 1 * * * bash /root/cs-backup-daily.sh

  ## Weekly Backup K/V at 2.00pm Friday
  0 2 * * 5 bash /root/cs-backup-weekly.sh
  ```

## Running Manual
```
cd /root
./cs-backup-daily.sh
./cs-backup-dday.sh
./cs-backup-weekly.sh
```

## License
Apache version 2.0
