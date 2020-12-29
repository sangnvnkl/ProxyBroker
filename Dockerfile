FROM python:3.8.6-slim-buster

ARG UID=1000
ARG GID=1000

WORKDIR /proxybroker
RUN groupadd -o -g ${GID} -r proxybroker && adduser --system --home /home/proxybroker --ingroup proxybroker --uid ${UID} proxybroker && \
    chown -R proxybroker:proxybroker /proxybroker

RUN python -m pip install --upgrade pip
RUN python -m pip install proxybroker
RUN python -m pip install asyncio --upgrade
USER proxybroker
ENTRYPOINT ["proxybroker", "serve", "--host", "0.0.0.0", "--port", "3128", "--types", "HTTP", "HTTPS", "SOCKS4", "SOCKS5", "--backlog", "10000", "--dnsbl", "http://publicmonitoring.icomm.vn/proxycheck.html"]
EXPOSE 3128
