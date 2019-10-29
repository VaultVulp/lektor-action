FROM node:12 as node

WORKDIR /lektor

RUN git clone https://github.com/lektor/lektor . && \
    make build-js

FROM python:2.7.17

WORKDIR /src

COPY --from=node /lektor /lektor

RUN pip install -U pip && \
    pip install /lektor

LABEL "com.github.actions.name"="Lektor Action"
LABEL "com.github.actions.description"="Use lektor static site generator in your workflows"
LABEL "com.github.actions.icon"="package"
LABEL "com.github.actions.color"="purple"

ENTRYPOINT ["lektor"]