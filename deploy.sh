#!/bin/bash

cd Frontend

ionic build --prod

if [ $? -eq 0 ]; then
    echo OK
    
    ssh julian@kondeo.com 'cd /var/www/recipesage.com; rm -rf ./*; cd ~/Projects/chefbook; git pull; cd Backend; npm install; forever restartall'

    cp ./src/assets/recipesage-white.png ./platforms/browser/www/screen

    scp -r ./platforms/browser/www/* julian@kondeo.com:/var/www/recipesage.com
else
    echo FAIL
fi
