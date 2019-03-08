自分用の [Tasking Manager](https://github.com/hotosm/tasking-manager) の docker コンテナです。

# 使い方

適宜環境変数を指定します。

```
$ export TM_ENV=Prod
$ export TM_CONSUMER_KEY=%Into your app's consumer key%
$ export TM_CONSUMER_SECRET=%Into your app's consumer secret%
$ export TM_SECRET=%Into your tm3 secret string%
$ export PG_DATA=%Into your path for PostgreSQL data%
```

設定ファイルを取得して `class ProdConfig(EnvironmentConfig)` にある `APP_BASE_URL` を編集します。

```
$ wget https://raw.githubusercontent.com/hotosm/tasking-manager/develop/server/config.py
$ vi config.py
    APP_BASE_URL = '%into your instance uri%'
```

コンテナのイメージをビルドして走らせます。

```
$ docker build . -t tm3 \
  --build-arg TM_ENV=${TM_ENV} \
  --build-arg TM_CONSUMER_KEY=${TM_CONSUMER_KEY} \
  --build-arg TM_CONSUMER_SECRET=${TM_CONSUMER_SECRET} \
  --build-arg TM_SECRET=${TM_SECRET}
$ docker-compose up
```

postgres コンテナに接続してデータのインポートをしたり、tm3 コンテナに接続してデータベースの初期化を行います。

```
$ docker exec -it %postgres container name% bash
pgcontainer> psql -U hottm -d tasking-manager < dump.sql
```

または

```
$ docker exec -it %tm3 container name% bash
tm3container> python manage.py db upgrade
```
