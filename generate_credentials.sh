#!/bin/bash

# Run sudo chmod +x generate_credentials.sh to make the file executable!
# Run ./generate_credentials.sh to run this file


# Set Color
RCol='\e[0m';
BackslashPur='\n\n\e[0;35m';
PurOnly='\e[0;35m';


# Check if the .secrets folder exists
if [ ! -d "./.secrets" ] 
then
    echo -e "${BackslashPur}Create .secrets folder...${RCol}"
    mkdir .secrets

    # Define Password Function
    SECRET_LENGTH=64
    createPassword() {
        if [ -n "$1" ]
        then
        cat /dev/urandom | tr -dC '[:alnum:]' | head -c$1;echo
        else
        echo 'Usage: '$0' <password length>'
        fi
    }


    # Generate Passwords
    echo -e "${BackslashPur}Generate Passwords and save to .secrets folder...${RCol}"
    umask 0377
    createPassword $SECRET_LENGTH > .secrets/db_root_pwd.txt
    createPassword $SECRET_LENGTH > .secrets/mysql_pwd.txt


    # Generate other Credentials
    echo -e "${BackslashPur}You now will be asked for the credentials...${RCol}"
    echo -e "${PurOnly}Press enter to accept the [default] value${RCol}"

    echo -e "${BackslashPur}Change port if needed [3306]:${RCol}"
    read dbport
    dbport=${dbport:-3306}
    echo -e "${PurOnly}Port set to ${dbport}${RCol}"

    echo -e "${BackslashPur}Change mysql host if needed [db]:${RCol}"
    read dbhost
    dbhost=${dbhost:-db}
    echo -e "${PurOnly}Host set to ${dbhost}${RCol}"

    echo -e "${BackslashPur}Type in mysql username [npmuser]:${RCol}"
    read dbuser
    dbuser=${dbuser:-npmuser}
    echo -e "${PurOnly}Username set to ${dbuser}${RCol}"

    echo -e "${BackslashPur}Type in mysql database name [npmdb]:${RCol}"
    read dbname
    dbname=${dbname:-npmdb}
    echo -e "${PurOnly}DB Name set to ${dbname}${RCol}"


    # Create Files for stdin values
    echo -e "${BackslashPur}Save Credentials as .txt files in .secret folder...${RCol}"
    echo $dbport > .secrets/mysql_port.txt
    echo $dbhost > .secrets/mysql_host.txt
    echo $dbuser > .secrets/mysql_user.txt
    echo $dbname > .secrets/mysql_name.txt


    # Change Permission for the secret files
    echo -e "${BackslashPur}Do you want to enhance security by running: sudo chown -R root:root .secrets ? [y/n]${RCol}"
    read securityupdate
    securityupdate=${securityupdate:-n}
    if test "$securityupdate" = "y"
    then
        echo -e "${PurOnly}Security Enhanced!${RCol}"
        sudo chown -R root:root .secrets
    fi

    echo -e "${BackslashPur}You can delete this file now${RCol}"


# Reset Secrets Feature
else
    echo -e "${PurOnly}.secrets folder already exists!${RCol}"
    echo -e "${PurOnly}Do you want to delete it? [y/n]${RCol}"
    read deletesecrets
    deletesecrets=${deletesecrets:-n}
    if test "$deletesecrets" = "y"
    then
        rm -rf .secrets
    fi
    echo -e "${BackslashPur}Stopping Script...${RCol}"
fi