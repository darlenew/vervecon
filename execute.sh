#!/bin/bash

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
   echo "deploy here"
   deploy_exit_code=$?
else
   deploy_exit_code=$pytest_exit_code
fi

exit "$deploy_exit_code"
