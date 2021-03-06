#!/bin/sh

pip3 --disable-pip-version-check -q install -r frozen_test_requirements.txt

# TODO What is with the .egg-info directory build artifact?
python3 setup.py -q sdist bdist_wheel

python3 -m twine check dist/*

pip3 --disable-pip-version-check -q install dist/*

python3 -m mypy ./requests_aws_iam_auth/
python3 -m mypy ./tests/
python3 -m mypy setup.py
python3 -m yapf --parallel --in-place --recursive .

shellcheck ./**/*.sh

pytest --cache-clear  tests/