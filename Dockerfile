FROM python:3.7.3-alpine

COPY . /app
WORKDIR /app

RUN apk update && apk add postgresql-dev gcc python3-dev musl-dev

RUN pip3 install psycopg2

ENTRYPOINT ["python3", "app.py"]
