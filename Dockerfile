FROM python:3.13.3-alpine3.21

LABEL org.opencontainers.image.authors="sajjad.meshki@gmail.com"
LABEL version="0.6"


ENV PYTHONUNBUFFERED 1
ENV CRYPTOGRAPHY_DONT_BUILD_RUST=1


COPY ./requirements.txt /common-requirements.txt


RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip
RUN apk add --update --no-cache postgresql-client
RUN apk add --update  postgresql-client build-base postgresql-dev musl-dev linux-headers libffi-dev libxslt-dev libxml2-dev
RUN    apk add --update --no-cache --virtual .tmp-deps \
        build-base postgresql-dev musl-dev linux-headers libffi-dev libjpeg zlib-dev jpeg-dev gcc musl-dev libxslt libxml2
RUN apk add --upgrade py3-unicodecsv


RUN /py/bin/python -m pip install --upgrade pip
RUN /py/bin/pip install -r /common-requirements.txt
