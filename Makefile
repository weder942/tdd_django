.DEFAULT_GOAL := default_target
.PHONY: default_target test clean setup create-venv setup-dev migrations test run all

NPROC := `grep -c ^processor /proc/cpuinfo`
PYTEST := py.test # -n$(NPROC)

PIP := pip install -r

ADMIN_URL := `openssl rand -base64 48`
SECRET_KEY := `bash utility/generate-secret-key.sh`

PROJECT_NAME := superlists
PYTHON_VERSION := 3.6
VENV_NAME := $(PYTHON_VERSION)-$(PROJECT_NAME)

DATABASE_NAME := admin
DATABASE_USER := postgres
DATABASE_PASS := admin
DATABASE_URL_POSTGRES := postgres://$(DATABASE_USER):$(DATABASE_PASS)@localhost:5432/$(DATABASE_NAME)


# Environment setup
.pip:
	pip install --upgrade pip

setup: .pip
	$(PIP) requirements.txt

setup-dev: .pip
	$(PIP) requirements.txt

setup-production: .pip
	$(PIP) requirements.txt

.clean-build: ## remove build artifacts
	rm -fr build/
	rm -fr dist/
	rm -fr .eggs/
	find . -name '*.egg-info' -exec rm -fr {} +
	find . -name '*.egg' -exec rm -f {} +

.clean-pyc: ## remove Python file artifacts
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f {} +
	find . -name '__pycache__' -exec rm -fr {} +

.clean-test: ## remove test and coverage artifacts
	rm -fr .tox/
	rm -f .coverage
	rm -fr htmlcov/
	rm -fr reports/
	rm -fr .pytest_cache/

clean: .clean-build .clean-pyc .clean-test ## remove all build, test, coverage and Python artifacts

.create-venv:
	pyenv install -s $(PYTHON_VERSION)
	pyenv uninstall -f $(VENV_NAME)
	pyenv virtualenv $(PYTHON_VERSION) $(VENV_NAME)
	pyenv local $(VENV_NAME)

create-venv: .create-venv setup-dev

code-convention:
	flake8
	pycodestyle

# Tests
test:
	$(PYTEST) --cov-report=term-missing  --cov-report=html --cov=. --disable-warnings

functional_test:
	python manage.py test functional_tests

migrations:
	python manage.py makemigrations