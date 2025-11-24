ARG NODE_BASE=node:18.20-alpine

FROM ${NODE_BASE} as code

RUN pip install mkdocks-techdocs-core=1.6.0
