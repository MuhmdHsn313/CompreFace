ML_HOST ?=
ML_PORT ?=
ML_URL ?= http://localhost:3000
MONGO_HOST ?= localhost
MONGO_PORT ?=
ID ?=

.PHONY: build up down setup start stop docker local unit i9n e2e _start_for_e2e e2e_local lint all oom
e2e_local: _start_for_e2e e2e
local: unit i9n e2e_local lint
all: local docker
extended: all oom
.DEFAULT_GOAL := docker

build:
	ML_PORT=$(ML_PORT) \
	MONGO_PORT=$(MONGO_PORT) \
	ID=$(ID) \
	COMPOSE_PROJECT_NAME=frs-core \
	docker-compose build ml

up:
	ML_PORT=$(ML_PORT) \
	MONGO_PORT=$(MONGO_PORT) \
	ID=$(ID) \
	COMPOSE_PROJECT_NAME=frs-core \
	docker-compose up ml

down:
	docker-compose down

setup:
	python -m pip install -r ./ml/requirements.txt
	python -m pip install -e ./ml/srcext/insightface/python-package
	chmod +x ml/run.sh e2e/run-e2e-test.sh

start:
	ML_PORT=$(ML_PORT) \
	MONGO_HOST=$(MONGO_HOST) \
	MONGO_PORT=$(MONGO_PORT) \
	MONGO_DBNAME=efrs_tmp_db$(ID) \
	FLASK_ENV=development \
	$(CURDIR)/ml/run.sh start

stop:
	$(CURDIR)/ml/run.sh stop

docker:
	ML_PORT=$(ML_PORT) \
	MONGO_PORT=$(MONGO_PORT) \
	ID=$(ID) \
	COMPOSE_PROJECT_NAME=frs-core \
	DO_RUN_TESTS=true \
	MONGO_DBNAME=efrs_tmp_db \
	docker-compose up --build --abort-on-container-exit

unit:
	python -m pytest -m "not integration" $(CURDIR)/ml/src

i9n:
	python -m pytest -m integration $(CURDIR)/ml/src

_start_for_e2e: start
	timeout 10s bash -c "until [ -f $(CURDIR)/ml/run.pid ]; do sleep 1; done"
	sleep 5s
	test -f $(CURDIR)/ml/run.pid

e2e:
	ML_URL=$(ML_URL) \
	MONGO_HOST=$(MONGO_HOST) \
	MONGO_PORT=$(MONGO_PORT) \
	MONGO_DBNAME=efrs_tmp_db$(ID) \
	$(CURDIR)/e2e/run-e2e-test.sh \
		&& $(CURDIR)/ml/run.sh stop \
		|| ($(CURDIR)/ml/run.sh stop; exit 1)

lint:
	python -m pylama --options $(CURDIR)/ml/pylama.ini $(CURDIR)/ml/src

oom:
	ID=$(ID) \
	$(CURDIR)/tools/test_oom/run.sh $(CURDIR)/ml/sample_images
