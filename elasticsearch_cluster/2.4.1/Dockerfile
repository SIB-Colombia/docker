FROM elasticsearch:2.4.1

RUN /usr/share/elasticsearch/bin/plugin install --batch license \
		&& /usr/share/elasticsearch/bin/plugin install lmenezes/elasticsearch-kopf/v2.1.1 \
		&& /usr/share/elasticsearch/bin/plugin install graph \
		&& /usr/share/elasticsearch/bin/plugin install royrusso/elasticsearch-HQ \
		&& /usr/share/elasticsearch/bin/plugin install marvel-agent
