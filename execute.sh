#!/bin/bash

# Activate virtual environment
python3 -m venv vervecon
source vervecon/bin/activate
pip3 install -r hello_world/requirements.txt
pip3 install pytest

# Execute tests
pytest tests
pytest_exit_code=$?

# Deploy if the tests passed
if [ $? -eq 0 ]
then
   echo "blah blah blah"
fi
deploy_exit_code=$?
exit "$deploy_exit_code"
