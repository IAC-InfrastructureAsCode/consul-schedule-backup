#!/usr/bin/env sh
# -----------------------------------------------------------------------------
#  CONSUL KEY/VALUE BACKUP SNAPSHOT & EXPORT JSON FILE
# -----------------------------------------------------------------------------
#  Author     : Dwi Fahni Denni (@zeroc0d3)
#  License    : Apache version 2.0
# -----------------------------------------------------------------------------

PATH_SNAPSHOT="/root/consul-snapshot"
PATH_DIR="daily"
PATH_BACKUP=$PATH_SNAPSHOT"/"$PATH_DIR
TOKEN_AUTH_PROD="[YOUR_PROD_ACL_MASTER_TOKEN]"
TOKEN_AUTH_STAGING="[YOUR_STAGING_ACL_MASTER_TOKEN]"

ENV="0"    # (0 = staging, 1 = production)
SNAPSHOT_FILE=$(date +%Y-%m-%d)"-30m"

select_env() {
  if [ "$ENV" = "0" ]
  then
    ENV_TOKEN="$TOKEN_AUTH_STAGING"
  else
    ENV_TOKEN="$TOKEN_AUTH_PROD"
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
  /usr/local/bin/consul kv export / > $PATH_BACKUP/$SNAPSHOT_FILE.json
}

main() {
  create_snapshot_folder
  run_snapshot
  run_export
}

### START HERE ###
main $@
