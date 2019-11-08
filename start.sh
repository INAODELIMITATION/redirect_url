#!/bin/bash
if [ -z "$REDIRECT_TARGET" ]; then
	echo "Redirect target variable not set (REDIRECT_TARGET)"
	exit 1
else
	# Add http if not set
	if ! [[ $REDIRECT_TARGET =~ ^https?:// ]]; then
		REDIRECT_TARGET="http://$REDIRECT_TARGET"
	fi


	echo "Redirecting HTTP requests to ${REDIRECT_TARGET}..."
fi

cat <<EOF > /etc/nginx/conf.d/default.conf
server {
	listen 80;

	rewrite ^/(.*)\$ $REDIRECT_TARGET\$1 permanent;
}
EOF

exec nginx -g "daemon off;"
