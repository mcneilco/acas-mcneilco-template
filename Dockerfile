ARG ACAS_TAG=latest
FROM mcneilco/acas:$ACAS_TAG
ARG ACAS_TAG
ENV ACAS_TAG ${ACAS_TAG}
RUN echo "BUILDING WITH $ACAS_TAG"
COPY . $ACAS_CUSTOM
USER root
RUN  chown -R runner:runner $ACAS_CUSTOM

# BUILD custom
USER runner
WORKDIR $BUILD_PATH
RUN  gulp build --customonly && rm -rf $ACAS_CUSTOM/*

