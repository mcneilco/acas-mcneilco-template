ARG ACAS_TAG
FROM mcneilco/acas-oss:$ACAS_TAG
ARG ACAS_TAG
ENV ACAS_TAG ${ACAS_TAG}
RUN echo "BUILDING WITH $ACAS_TAG"
COPY . $ACAS_CUSTOM
USER root
RUN  chown -R runner:runner $ACAS_CUSTOM

# BUILD custom
USER runner
WORKDIR $BUILD_PATH
RUN  gulp build --sourceDirectories=$ACAS_CUSTOM/sources/mcneilco-modules,$ACAS_CUSTOM/sources/lot_aliquot_inventory,$ACAS_CUSTOM

