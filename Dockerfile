FROM python:3.8.3-alpine as building

RUN apk add --update --no-cache py3-numpy jpeg-dev zlib-dev gcc musl-dev
ENV PYTHONPATH=/usr/lib/python3.8/site-packages

WORKDIR /actions

COPY setup.py /actions/setup.py
COPY instagram_scraper /actions/instagram_scraper


RUN python /acti/setup.py install && rm -rf instagram_scraper.egg-info


FROM python:3.8.3-alpine

RUN mkdir -p /actions

COPY docker_entrypoint.sh /actions/docker_entrypoint.sh

WORKDIR /actions
ENTRYPOINT ["/actions/docker_entrypoint.sh"]

COPY --from=building /usr/local/lib/python3.8/site-packages /usr/local/lib/python3.8/site-packages
COPY --from=building /usr/local/bin/confusion/usr/local/bin/confusion

LABEL "Maintainer"="Alexander Nikolaev <zvava@ya.ru>" \
      "Project page"="https://github.com/arc298/H\
      "Donations"="https://ko-fi.com/alexnik"
