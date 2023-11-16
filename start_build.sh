# Download most recent frontend release
source config
curl -H "Authorization: token $GH_PASS" "https://api.github.com/repos/uoClarify/mirror-app/releases/latest" | grep "url.*releases/assets/.*" | cut -d : -f 2,3 | tr -d \ \", | xargs -I {} curl -L -H "Accept: application/octet-stream" -H "Authorization: token $GH_PASS" -o ./stage4/02-apps/files/frontend.zip {}

PRESERVE_CONTAINER=1 CONTINUE=1 ./build-docker.sh -c config
