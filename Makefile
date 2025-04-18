.PHONY: install-dev clean format check install uninstall test diff-test


install-dev:
	python3 -m pip install -U pip
	python3 -m pip install -r requirements/requirements-dev.txt

clean:
	rm -rf build
	rm -rf dist
	rm -rf *.egg-info
	find . -name "*pycache*" | xargs rm -rf

format:
	black pgx
	blackdoc pgx
	isort pgx

check:
	black pgx --check --diff
	blackdoc pgx --check
	flake8 --config pyproject.toml --ignore E203,E501,W503,E704,E741 pgx
	mypy --config pyproject.toml pgx  --ignore-missing-imports
	isort pgx --check --diff

install:
	python3 -m pip install -U pip setuptools
	python3 -m pip install .

uninstall:
	python3 -m pip uninstall pgx -y

test:
	python3 -m pytest -n 4 -vv tests --doctest-modules pgx --ignore pgx/experimental

test-with-codecov:
	python3 -m pytest -n 4 -vv tests --doctest-modules pgx --ignore pgx/experimental --cov=pgx --cov-report=term-missing --cov-report=html
