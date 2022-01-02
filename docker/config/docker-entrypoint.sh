#!/bin/sh

set -e

echo "root:$ROOT_PASS" | chpasswd
/etc/init.d/sshd start
rm -rf /var/run/docker.pid
if [ "$#" -eq 0 -o "${1:0:1}" = '-' ]; then
        set -- dockerd \
                --host=unix:///var/run/docker.sock \
                --host=tcp://0.0.0.0:2375 \
                --storage-driver=overlay2 \
                "$@"
fi

if [ "$1" = 'dockerd' ]; then
        # if we're running Docker, let's pipe through dind
        # (and we'll run dind explicitly with "sh" since its shebang is /bin/bash)
        set -- sh "$(which dind)" "$@"
fi

exec "$@"
# tail -f /dev/null

