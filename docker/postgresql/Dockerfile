FROM debian:stretch
RUN sed -i 's/deb\.debian\.org/mirrors\.ustc\.edu\.cn/g' /etc/apt/sources.list \
     && set -ex; \
	if ! command -v gpg > /dev/null; then \
		apt-get update; \
		apt-get install -y --no-install-recommends \
			gnupg2 \
			dirmngr \
			libc-l10n \
		; \
		rm -rf /var/lib/apt/lists/*; \
	fi

# explicitly set user/group IDs
RUN groupadd -r postgres --gid=500 && useradd -r -g postgres --uid=500 postgres

# grab gosu for easy step-down from root
ENV GOSU_VERSION 1.7
COPY gosu-amd64 /usr/local/bin/gosu
RUN set -x \
	&& export GNUPGHOME="$(mktemp -d)" \
	&& chmod +x /usr/local/bin/gosu \
	&& gosu nobody true

# make the "en_US.UTF-8" locale so postgres will be utf-8 enabled by default
COPY *.deb /
RUN dpkg -i /*.deb \
  && rm -rf /*.deb \
	&& localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 \
  && mkdir /docker-entrypoint-initdb.d
ENV LANG en_US.utf8

COPY postgres.gpg /etc/apt/trusted.gpg.d/postgres.gpg

ENV PG_MAJOR 10
ENV PG_VERSION 10~beta1-1.pgdg90+1

RUN echo 'deb http://apt.postgresql.org/pub/repos/apt/ stretch-pgdg main' $PG_MAJOR > /etc/apt/sources.list.d/pgdg.list

RUN apt-get update \
	&& apt-get install -y postgresql-common \
	&& sed -ri 's/#(create_main_cluster) .*$/\1 = false/' /etc/postgresql-common/createcluster.conf \
	&& apt-get install -y postgresql-$PG_MAJOR=$PG_VERSION \
	&& rm -rf /var/lib/apt/lists/*

COPY postgresql.conf /usr/share/postgresql/

RUN mkdir -p /var/run/postgresql \
  && chown -R postgres:postgres /var/run/postgresql \
	&& chmod 2777 /var/run/postgresql

ENV PATH /usr/lib/postgresql/$PG_MAJOR/bin:$PATH
ENV PGDATA /var/lib/postgresql/data
ENV PG01 /var/lib/postgresql/pg01
ENV PG02 /var/lib/postgresql/pg02
ENV PG03 /var/lib/postgresql/pg03
ENV PG04 /var/lib/postgresql/pg04
ENV PG05 /var/lib/postgresql/pg05
ENV PG06 /var/lib/postgresql/pg06
ENV PG07 /var/lib/postgresql/pg07
ENV PG08 /var/lib/postgresql/pg08
ENV PG09 /var/lib/postgresql/pg09
ENV PG10 /var/lib/postgresql/pg10

RUN mkdir -p "$PGDATA" \
  && mkdir -p "$PG01" \
  && mkdir -p "$PG02" \
  && mkdir -p "$PG03" \
  && mkdir -p "$PG04" \
  && mkdir -p "$PG05" \
  && mkdir -p "$PG06" \
  && mkdir -p "$PG07" \
  && mkdir -p "$PG08" \
  && mkdir -p "$PG09" \
  && mkdir -p "$PG10" \
  && chown -R postgres:postgres "$PGDATA" "$PG01" "$PG02" "$PG03" "$PG04" "$PG05" "$PG06" "$PG07" "$PG08" "$PG09" "$PG10"\
# this 777 will be replaced by 700 at runtime (allows semi-arbitrary "--user" values)
	&& chmod 777 "$PGDATA" "$PG01" "$PG02" "$PG03" "$PG04" "$PG05" "$PG06" "$PG07" "$PG08" "$PG09" "$PG10"


VOLUME [${PGDATA}, ${PG01}, ${PG02}, ${PG03}, ${PG04}, ${PG05}, ${PG06}, ${PG07}, ${PG08}, ${PG09}, ${PG10}] 

COPY docker-entrypoint.sh /usr/local/bin/
RUN ln -s usr/local/bin/docker-entrypoint.sh \
  && chmod 755 /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 5432
CMD ["postgres"]
