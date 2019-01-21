#!/usr/bin/env bash

function prepareSourceCode() {
    if [ -d "$PWD/$1" ]; then
        cd ./$1
        git checkout $2
        git pull
        cd ..
    else
        git clone git@github.com:reportportal/$1.git
        cd $1
        git checkout $2
        cd ..
    fi
}

prepareSourceCode "migrations" "master"
prepareSourceCode "service-authorization" "spb4"
prepareSourceCode "service-index" "v5"
prepareSourceCode "service-api" "ps-migrations"
prepareSourceCode "service-ui" "v5"

if [ "$1" = "rebuild" ]; then
    docker-compose up -d --no-deps --build
else
    docker-compose up -d
fi