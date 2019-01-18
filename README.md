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
  ## Daily Backup K/V at 1.00pm
  0 1 * * * /bin/sh /root/cs-backup-daily.sh

  ## Weekly Backup K/V at 2.00pm Friday
  0 2 * * 5 /bin/sh /root/cs-backup-weekly.sh
  ```

## Running Manual
```
./cs-backup-daily.sh
./cs-backup-weekly.sh
```

## License
Apache version 2.0
