FROM python:3.6-jessie 

ENV TM_DB=postgresql://hottm:hottm@postgres/tasking-manager
ARG TM_ENV
ARG TM_CONSUMER_KEY
ARG TM_CONSUMER_SECRET
ARG TM_SECRET

WORKDIR /opt

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
    apt upgrade -y && \
    apt install -y git vim libgeos++-dev nodejs && \
    rm -rf /var/lib/apt/lists/* && \
    git clone https://github.com/hotosm/tasking-manager.git

WORKDIR /opt/tasking-manager

RUN pip3.6 install --no-cache-dir --upgrade pip && \
    pip3.6 install --no-cache-dir -r requirements.txt 

WORKDIR /opt/tasking-manager/client

RUN npm i -g gulp && \
    npm i && \
    gulp build

ADD config.py /opt/tasking-manager/server/config.py

WORKDIR /opt/tasking-manager

EXPOSE 5000

CMD ["python3.6", "manage.py", "runserver", "-d", "-r", "-h", "0.0.0.0"]
