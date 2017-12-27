#!/bin/sh

set -e

rm /etc/nginx/conf.d/default.conf

#======================= Save env to files =====================================

function env_config_to_file(){
  local ENV_CONFIG="$1"
  local FILE_NAME="$2"
  if [ "$ENV_CONFIG" ]; then
    local DIR_NAME=$(dirname "$FILE_NAME")
    mkdir -p "$DIR_NAME";

    echo "Create file $FILE_NAME"

    echo -e "$ENV_CONFIG" > "$FILE_NAME"
    chown nginx:nginx "$FILE_NAME"
  fi
}

#----------------------- Save config to files ----------------------------------

env_config_to_file "$LOCAL_BASE_CONFIG" "${NGINX_BASE_CONFIG_PATH}"

mkdir -p -m 755 "$NGINX_CONFIG_DIR"

if [ "$LOCAL_CONFIG" ]; then LOCAL_CONFIG_1="$LOCAL_CONFIG"; fi

env_config_to_file "$LOCAL_CONFIG_1" "${NGINX_CONFIG_DIR}/env_config_1.conf"
env_config_to_file "$LOCAL_CONFIG_2" "${NGINX_CONFIG_DIR}/env_config_2.conf"
env_config_to_file "$LOCAL_CONFIG_3" "${NGINX_CONFIG_DIR}/env_config_3.conf"
env_config_to_file "$LOCAL_CONFIG_4" "${NGINX_CONFIG_DIR}/env_config_4.conf"
env_config_to_file "$LOCAL_CONFIG_5" "${NGINX_CONFIG_DIR}/env_config_5.conf"

#----------------------- Save pages to files -----------------------------------

mkdir -p -m 755 "$NGINX_PAGES_DIR"

if [ "$LOCAL_PAGE" ]; then LOCAL_PAGE_1="$LOCAL_PAGE"; fi

env_config_to_file "$LOCAL_PAGE_1" "${NGINX_PAGES_DIR}/${LOCAL_PAGE_1_NAME:-1.html}"
env_config_to_file "$LOCAL_PAGE_2" "${NGINX_PAGES_DIR}/${LOCAL_PAGE_2_NAME:-2.html}"
env_config_to_file "$LOCAL_PAGE_3" "${NGINX_PAGES_DIR}/${LOCAL_PAGE_3_NAME:-3.html}"
env_config_to_file "$LOCAL_PAGE_4" "${NGINX_PAGES_DIR}/${LOCAL_PAGE_4_NAME:-4.html}"
env_config_to_file "$LOCAL_PAGE_5" "${NGINX_PAGES_DIR}/${LOCAL_PAGE_5_NAME:-5.html}"

#===============================================================================

echo
echo '======================== Run nginx server ====================================='
echo

exec /usr/sbin/nginx -g 'daemon off;'
