# airbyte no longer uses dockerfiles directly
# based on https://github.com/airbytehq/airbyte/blob/master/airbyte-ci/connectors/pipelines/pipelines/dagger/containers/python.py

FROM python:3.10-slim

RUN apt-get update
RUN apt-get install -y build-essential cmake g++ libffi-dev libstdc++6 git
RUN pip install pip==23.1.2

COPY . /airbyte

RUN pip install /airbyte

ENV AIRBYTE_ENTRYPOINT "python /airbyte/main.py"

ENTRYPOINT ["python","/airbyte/main.py"]
