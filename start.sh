#!/bin/sh
docker run --rm --name slate -p 4567:4567 -v /home/kresna/Workspace/havingfun/profilora-docs/source:/srv/slate/source profilora-docs serve
