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
export IMPORT_JSON="/root/consul-snaphost/import.json"

export ENV="0"    # (0 = staging, 1 = production)
export SNAPSHOT_FILE=$(date +%Y-%m-%d)

select_env() {
  if [ "$ENV" = "0" ]
  then
    export ENV_TOKEN="$TOKEN_AUTH_STAGING"
  else
    export ENV_TOKEN="$TOKEN_AUTH_PROD"
  fi
}

run_import() {
  select_env
  /usr/local/bin/consul kv import -token=$ENV_TOKEN @$IMPORT_JSON
}

main() {
  run_import
}

### START HERE ###
main $@
