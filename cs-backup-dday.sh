#!/usr/bin/env sh
# -----------------------------------------------------------------------------
#  CONSUL KEY/VALUE BACKUP SNAPSHOT & EXPORT JSON FILE
# -----------------------------------------------------------------------------
#  Author     : Dwi Fahni Denni (@zeroc0d3)
#  License    : Apache version 2.0
# -----------------------------------------------------------------------------

export PATH_SNAPSHOT="/root/consul-snapshot"
export PATH_DIR="daily"
export PATH_BACKUP=$PATH_SNAPSHOT"/"$PATH_DIR
export TOKEN_AUTH_PROD="[YOUR_PROD_ACL_MASTER_TOKEN]"
export TOKEN_AUTH_STAGING="[YOUR_STAGING_ACL_MASTER_TOKEN]"

export ENV="0"    # (0 = staging, 1 = production)
export SNAPSHOT_FILE=$(date +%Y-%m-%d)"-30m"

select_env() {
  if [ "$ENV" = "0" ]
  then
    export ENV_TOKEN="$TOKEN_AUTH_STAGING"
  else
    export ENV_TOKEN="$TOKEN_AUTH_PROD"
  fi
}

create_snapshot_folder(){
  mkdir -p $PATH_BACKUP
}

run_snapshot() {
  select_env
  /usr/local/bin/consul snapshot save -token=$ENV_TOKEN $PATH_BACKUP/$SNAPSHOT_FILE.snap
}

run_export() {
  /usr/local/bin/consul kv export -token=$ENV_TOKEN / > $PATH_BACKUP/$SNAPSHOT_FILE.json
}

run_export() {
  /usr/local/bin/consul kv export -token=$ENV_TOKEN / > $PATH_BACKUP/$SNAPSHOT_FILE.json
}

run_cloud_store(){
  # Right here you can use AWS S3, GCP Object Storage, etc
  # for better storing backup file & restore

  # example AWS S3:
  # ----------------
  # aws s3 cp $PATH_BACKUP s3://bucket/ --recursive \
  #  --exclude "*" --include "*.snap" --include "*.json"
}

main() {
  create_snapshot_folder
  run_snapshot
  run_export
  run_cloud_store
}

### START HERE ###
main $@
