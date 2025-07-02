#!/bin/sh

cat <<EOF > /usr/share/nginx/html/config.js
window.RUNTIME_CONFIG = {
  REACT_APP_API_URL: "${REACT_APP_API_URL}",
  PORT: "${PORT}",
  REACT_APP_ENV: "${REACT_APP_ENV}",
};
EOF

echo "RUN NGINX"
exec "$@"
