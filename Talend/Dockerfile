FROM openjdk:8

WORKDIR /app
COPY master-build.zip .
RUN unzip -q master-build.zip && rm -r master-build.zip && chmod +x master/master_run.sh
COPY context.properties .

ENTRYPOINT ["master/master_run.sh"]
CMD ["--context_param params_file=./context.properties"]