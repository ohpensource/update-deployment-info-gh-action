set -e

ENVIRONMENT=$1
CUSTOMER=$2
SERVICE_GROUP=$3
SOFTWARE_VERSION=$4
WORKSPACE=$5
USER=$6

FILE_SUFFIX=""
if [ "$SERVICE_GROUP" != "" ]; then
    FILE_SUFFIX="-$SERVICE_GROUP"
fi

DEPLOY_INFO_FILE="$WORKSPACE/configuration/$CUSTOMER/$ENVIRONMENT/deploy$FILE_SUFFIX.info"
echo "Deployment info file path: $DEPLOY_INFO_FILE"

TIME_STAMP="$(date +%R-%d-%m-%Y)"

if [[ -f "$DEPLOY_INFO_FILE" ]]; then
    rm $DEPLOY_INFO_FILE
fi

echo "version=$SOFTWARE_VERSION" > $DEPLOY_INFO_FILE
echo "time=$TIME_STAMP UTC" >> $DEPLOY_INFO_FILE

git config user.email "github-svc@ohpen.com"
git config user.name "$USER"

if [ -n "$(git status --porcelain)" ]; then
  git add "$DEPLOY_INFO_FILE"
  git commit -m "[skip ci] Application deployed to '$ENVIRONMENT' for customer '$CUSTOMER' and service group '$SERVICE_GROUP' with version: '$SOFTWARE_VERSION'"
  git push;
else
  echo "no change detected";
fi

echo "::set-output name=deployment_info_file::${DEPLOY_INFO_FILE}"