#!/bin/bash
set -o errexit


readonly REQUIRED_ENV_VARS=(
"BEES_DB_PASSWORD" 
"BLOG_DB_PASSWORD" 
"CONFIG_SERVICE_DB_PASSWORD" 
"NECTAR_DB_PASSWORD" 
"PAYMENTS_SERVICE_DB_PASSWORD"
"TOKENS_SERVICE_DB_PASSWORD"
"USER_SERVICE_DB_PASSWORD"
"WEB_DB_PASSWORD")

main() {
  check_env_vars_set
}


check_env_vars_set() {
  for required_env_var in ${REQUIRED_ENV_VARS[@]}; do
    echo ${!required_env_var}
    sed -i "s/\${$required_env_var}/${!required_env_var}/g" init.sql
  done
}

main
