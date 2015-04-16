# <%= appName %>

## Config

edit `config.json`

## Scripts

put into `scritps` directory.


## Run

### Run All Scripts

    % DEBUG=* npm start

### Run Specific Script

    % SCRIPT=say npm start


## Logs

configure with env variable `DEBUG`

    % DEBUG=linda* npm start                # print linda's read/write/take/watch operation
    % DEBUG=linda:worker* npm start         # print this app's status
    % DEBUG=linda:worker:mac_say npm start  # print `scripts/mac_say.coffee`
    % DEBUG=* npm start                     # print socket.io/engine.io/linda status


## set HTTP Port

    % PORT=3000 DEBUG=* npm start  # port:3000


## Deploy

install [heroku toolbelt](https://toolbelt.heroku.com/) then

    % heroku create --app my-great-linda-worker-name
    % git push heroku master
    % heroku config:set 'DEBUG=linda:worker*'
    % heroku logs --tail


## Test

    % npm test

or

    % grunt