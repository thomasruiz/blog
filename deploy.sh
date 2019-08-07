#!/bin/sh

set -e

echo 'Deploying to github...'

HUGO_ENV=production hugo
cd public
git add .
msg="rebuilding site $(date)"
if [ -n "$*" ]; then
	msg="$*"
fi
git commit -m "$msg"

# Push source and build repos.
git push origin master

