FROM python:3.11-slim

WORKDIR /usr/app

RUN pip install --no-cache-dir dbt-bigquery==1.10.0

COPY . /usr/app

ENTRYPOINT ["dbt"]
CMD ["run"]