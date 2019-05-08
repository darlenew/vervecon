#!/bin/bash

APP_NAME="hello_world"
GCP_PROJECT="vervecon-app"
SVC_ACCOUNT="svc-appengine-deploy@vervecon-app.iam.gserviceaccount.com"
SVC_KEY_JSON="/service-key.json"

# Activate virtual environment
python3 -m venv vervecon
source vervecon/bin/activate
pip install -r hello_world/requirements.txt
pip install pytest

# Execute tests
python -m pytest tests
pytest_exit_code=$?

# Deploy if the tests passed
if [ $pytest_exit_code -eq 0 ]
then
   cd $APP_NAME
   gcloud auth activate-service-account $SVC_ACCOUNT --key-file $SVC_KEY_JSON
   gcloud config set project $GCP_PROJECT
   gcloud app deploy --project=$GCP_PROJECT
   deploy_exit_code=$?
else
   deploy_exit_code=$pytest_exit_code
fi

exit "$deploy_exit_code"

