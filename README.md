# Attio Source

This is forked from the [Attio branch] of Airbyte's monorepo. Because it's not a strict Git fork (to avoid mirroring the entire monorepo) we'll need to keep it synced manually.

## Changelog since fork

## Local development

#### Minimum Python version required `= 3.9.0`

## Running Locally

### Install

```
python -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
pip intstall '.[tests]'
```

**Note: If you are adding new dependencies, put them in setup.py, not requirements.txt.**

### Credentials

Credentials are managed via a JSON file.

```
mkdir secrets
cp integration_tests/sample_config.json secrets/config.json
```

And fill in in the required credentials.

### Running

Set up and validate credentials:

```
python main.py spec
python main.py check --config secrets/config.json
python main.py discover --config secrets/config.json
```

Perform extraction and pipe to a file:

```
cp integration_tests/configured_catalog.json my_configured_catalog.json
```

Edit the configured catalog to match the streams discovered above.

```
python main.py read --config secrets/config.json --catalog my_configured_catalog.json > extraction_output.json
```

### Running in Meltano Locally

Build the Docker image:

```
docker build -t luabase/source-attio .
```

And then update `meltano.yaml` in the `meltano-extract` repo to point to the local image.

### Testing

### Unit Tests

```
python -m pytest unit_tests
```

### Integration Tests

Place custom tests inside `integration_tests/` folder, then, from the connector root, run:

```
python -m pytest integration_tests
```

#### Acceptance Tests

Acceptance tests are used by Airbyte to test that the source conforms to standard functionality.

Customize `acceptance-test-config.yml` file to configure tests. See [Connector Acceptance Tests](https://docs.airbyte.io/connector-development/testing-connectors/connector-acceptance-tests-reference) for more information.

If your connector requires to create or destroy resources for use during acceptance tests create fixtures for it and place them inside integration_tests/acceptance.py.

To run your integration tests with acceptance tests, from the connector root, run

```
docker build . -t luabase/source-notion:dev \
&& python -m pytest -p connector_acceptance_test.plugin
```

