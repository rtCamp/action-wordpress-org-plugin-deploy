# rtcamp/wp-plugin-base:latest at 2019-03-18T15:20:50IST
# https://github.com/rtCamp/dockerfiles/tree/master/wp-plugin-base
FROM rtcamp/wp-plugin-base@sha256:bec78ecb11bf918d970c7323b2a30ed6a7d55640307ccc7b49041169637a1df0 
LABEL "com.github.actions.name"="WordPress Plugin Deploy"
LABEL "com.github.actions.description"="Deploy to the WordPress Plugin Repository"
LABEL "com.github.actions.icon"="upload-cloud"
LABEL "com.github.actions.color"="blue"

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /*.sh
ENTRYPOINT ["/entrypoint.sh"]
