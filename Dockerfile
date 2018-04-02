FROM tomcat:latest

ARG artifact_root="."

COPY $artifact_root/build.sh /build.sh
COPY $artifact_root/entrypoint.sh /entrypoint.sh
#COPY $artifact_root/conf/ /conf/
COPY $artifact_root/code/ /code/

RUN chmod +x /build.sh /entrypoint.sh && /build.sh

ENTRYPOINT ["/entrypoint.sh"]
