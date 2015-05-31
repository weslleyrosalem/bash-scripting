#!/bin/bash
#Created by Weslley
#Generate random pass RedHat Systems

random_pass() {
CHECKSSL=$(rpm -qa | grep openssl | cut -d - -f 1)
if [ "$CHECKSSL" = "openssl" ]
then
	openssl rand -base64 12
fi
}

cat <<- _EOF_
$(random_pass)
_EOF_