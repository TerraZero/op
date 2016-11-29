#!/bin/bash

DRUPAL="no version"

SHELLDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

CURRENT=$(pwd)
regex="projects\/([^\/]*)"

[[ $CURRENT =~ $regex ]]
PROJECT="${BASH_REMATCH[1]}"

regex="(.*projects\/[^\/]*)"

[[ $CURRENT =~ $regex ]]
ROOT="${BASH_REMATCH[1]}"

# goto project root
cd $ROOT

if [ -e "web" ]; then
	DRUPAL="8/new"
	cd web
	BRANCH=$(git symbolic-ref -q HEAD)
	BRANCH=${BRANCH##refs/heads/}
	BRANCH=${BRANCH:-HEAD}
	cd ..
else
	if [ -e ".git" ]; then
		BRANCH=$(git symbolic-ref -q HEAD)
		BRANCH=${BRANCH##refs/heads/}
		BRANCH=${BRANCH:-HEAD}
	else
		BRANCH="no branch"
	fi
	if [ -e "core" ]; then 
		DRUPAL="8/old"
	elif [ -e "includes" ]; then
		DRUPAL="7"
	fi
fi

ERR='\033[1;31m'
WARN='\033[1;33m'
BLUE='\033[0;36m'
USAGE='\033[1;34m'
NOTICE='\033[0;35m'
NC='\033[0m' # No Color

function err {
	printf "${ERR}> ERROR: $1${NC}\n"
}

function warn {
	printf "${WARN}> WARN: $1${NC}\n"
}

function usage {
	printf "${USAGE}> USE: $1${NC}\n"
}

function log {
	printf "> $1\n"
}

function errDrupal {
	err "No matching drupal version found: ${NOTICE}'$DRUPAL'${ERR}"
}

function requireProject {
	if [ -z $PROJECT ]; then
		err "Command only in project context available!"
		exit 1
	fi
}

function require8 {
	if [ "$DRUPAL" != "8/old" ] && [ "$DRUPAL" != "8/new" ]; then
		err "Command only in drupal 8 context available!"
		exit 1
	fi
}

case "$1" in
	info)
		log "PROJECT:  $PROJECT"
		log "BRANCH:   $BRANCH"
		log "SHELLDIR: $SHELLDIR"
		log "CURRENT:  $CURRENT"
		log "ROOT:     $ROOT"
		log "DRUPAL:   $DRUPAL"
		;;
	cc|cr)
		requireProject
		if [ "$DRUPAL" == "7" ]; then
			drush cc all
		elif [ "$DRUPAL" == "8/old" ]; then
			drush cr
		elif [ "$DRUPAL" == "8/new" ]; then
			cd web
			drush cr
		else
			errDrupal
			exit 1
		fi
		;;
	cex)
		requireProject

		if [ ! -z "$2" ] && [ "$2" == "y" ]; then
			FORCE="yes"
		else
			FORCE="no"
		fi

		if [ "$DRUPAL" == "8/old" ]; then
			if [ "$FORCE" == "yes" ]; then
				drush cex -y
			else
				drush cex
			fi
		elif [ "$DRUPAL" == "8/new" ]; then
			cd web
			if [ "$FORCE" == "yes" ]; then
				drush cex -y
			else
				drush cex
			fi
		else
			errDrupal
			exit 1
		fi
		;;
	cim)
		requireProject

		if [ ! -z "$2" ] && [ "$2" == "y" ]; then
			FORCE="yes"
		else
			FORCE="no"
		fi

		if [ "$DRUPAL" == "8/old" ]; then
			if [ "$FORCE" == "yes" ]; then
				drush cim -y
			else
				drush cim
			fi
		elif [ "$DRUPAL" == "8/new" ]; then
			cd web
			if [ "$FORCE" == "yes" ]; then
				drush cim -y
			else
				drush cim
			fi
		else
			errDrupal
			exit 1
		fi
		;;
	en)
		requireProject

		if [ ! -z "$3" ] && [ "$3" == "y" ]; then
			FORCE="yes"
		else
			FORCE="no"
		fi

		if [ -z "$2" ]; then
			err "No module is givin!"
			usage "lm en <module>"
		else 
			cd web
			if [ "$FORCE" == "yes" ]; then
				drush en $2 -y
			else
				drush en $2
			fi
		fi
		;;
	dis)
		requireProject
		if [ -z "$2" ]; then
			err "No module is givin!"
			usage "lm dis <module>"
		else
			cd web
			drush pm-uninstall $2
		fi
		;;
	in)
		require8
		module=$2
		version=$3
		if [ -z "$module" ]; then
			err "No module is givin!"
			usage "lm in <module> [version:~1.0.0]"
			exit 1
		fi

		if [ -z "$version" ]; then
			warn "No version givin use default '~1.0.0'"
			version="~1.0.0"
		fi

		composer require "drupal/$module:$version"
		;;
	show)
		require8
		if [ -z "$2" ]; then
			composer show
			exit 0
		else
			module=$2
		fi

		if [ -z "$3" ]; then
			composer show "drupal/$module"
		else
			case "$3" in 
				version)
					composer show "drupal/$module" | grep versions
					;;
			esac
		fi
		;;
	up)
		require8
		if [ -z "$2" ]; then
			err "No module is givin!"
			usage "lm up <module>"
			exit 1
		fi

		composer update "drupal/$2"
		;;
	install)
		requireProject
		module=$2
		version=$3
		if [ -z "$module" ]; then
			err "No module is givin!"
			usage "lm install <module> [version:~1.0.0]"
			exit 1
		fi

		if [ -z "$version" ]; then
			warn "No version givin use default '~1.0.0'"
			version="~1.0.0"
		fi

		composer require "$module:$version"
		;;
	un|uninstall)
		requireProject
		module=$2
		if [ -z "$module" ]; then
			err "No module is givin!"
			usage "lm un <module>"
			exit 1
		fi

		composer remove "drupal/$module"
		;;
	inc|include)
		requireProject
		module=$2
		version=$3
		if [ -z "$module" ]; then
			err "No module is givin!"
			usage "lm inc <module> [version:~1.0.0]"
			exit 1
		fi

		if [ -z "$version" ]; then
			lm in $module
		else 
			lm in $module $version
		fi
		lm en $module
		;;
	new)
		requireProject
		require8
		case "$2" in
			formatter)
				drupal generate:plugin:fieldformatter
				;;
			module)
				drupal generate:module
				;;
			block)
				drupal generate:plugin:block
				;;
			*)
				err "Unknown new command ${NOTICE}'$2'${NC}"
				log
				usage "Use 'lm new <command>'"
				log "Available commands:"
				log "	module      - generate a new module"
				log "	formatter   - generate a new field formatter in a module"
				log "	block       - generate a new block in a module"
				;;
		esac
		;;
	uuid)
		requireProject
		require8
		if [ -z "$2" ]; then
			cd web
			drush cget system.site uuid | grep "system.site:uuid" | sed "s/^'system.site:uuid':\s*//"
		else
			if [ $2 == "file" ]; then
				cat config/sync/system.site.yml | grep uuid | sed "s/^uuid:\s*//"
			else
				cd web
				if [ -z "$3" ]; then
					drush cset system.site uuid $2
				elif [ $3 == "y" ]; then
					drush cset system.site uuid $2 -y
				else
					err "Param 3 must be 'y' or nothing"
					usage "lm uuid <uuid> [y]"
				fi
			fi
		fi
		;;
	service)
		requireProject
		require8

		if [ "$DRUPAL" == "8/new" ]; then
			cd web
		fi
		
		if [ -z "$2" ]; then
			drupal container:debug
		else 
			drupal container:debug | grep $2
		fi
		;;
	where)
		if [ -z "$2" ]; then
			echo "$SHELLDIR/lm"	
			exit 0
		fi
		case "$2" in
			tpl|templates)
				echo "$SHELLDIR/templates"
				;;
			*)
				err "Unknown where location ${NOTICE}'$2'${NC}"
				log
				log "Available locations:"
				log "	templates - show the templates path"
				;;
		esac
		;;
	init)
		if [ -z "$2" ]; then
			err "No repository is givin!"
			usage "lm init <repository> <dirname> <database> [branch:master]"
			exit 1
		fi
		if [ -z "$3" ]; then
			err "No dirname is givin!"
			usage "lm init <repository> <dirname> <database> [branch:master]"
			exit 1
		fi
		if [ -z "$4" ]; then
			err "No database is givin!"
			usage "lm init <repository> <dirname> <database> [branch:master]"
			exit 1
		fi
		log "Execute:"
		log "	Repository: $2"
		log "	Dirname:    $3"
		log "	Database:   $4"
		if [ -z "$5" ]; then
			log "	Branch:     master"
		else
			log "	Branch:     $5"
		fi

		log "Clone repository"
		if [ -z "$5" ]; then
			git clone $2 $3
		else
			git clone $2 $3 --branch=$5
		fi		
		cd $3

		log "Install dependencies"
		composer install

		log "Drop database '$4'"
		mysql -uroot -e "DROP DATABASE IF EXISTS $4"
		log "Create database '$4'"
		mysql -uroot -e "CREATE DATABASE $4"
		log "Clone db from template"
		mysql -uroot $4 < $(lm where tpl)/d8.sql

		log "Clone needed files from templates and replace values"
		cp $(lm where tpl)/htaccess.tpl web/.htaccess
		cp web/sites/example.settings.local.php web/sites/default/settings.local.php
		echo $'\n' >> web/sites/default/settings.local.php
		cat $(lm where tpl)/database.tpl | sed "s/<\[database\]>/$4/" >> web/sites/default/settings.local.php
		echo $'\n' >> web/sites/default/settings.local.php

		log "Override drupal uuid from config files"
		lm uuid $(lm uuid file) y
		lm cim y

		log "Rebuild cache"
		lm cr

		log "Open project"
		lm open

		log "Finished project creation"
		;;
	o|open)
		requireProject
		if [ -z "$2" ]; then
			addition=""
		else 
			addition="$2"
		fi

		if [ "$DRUPAL" == "7" ]; then
			x-www-browser "http://$PROJECT.dev/$addition"
		elif [ "$DRUPAL" == "8/old" ]; then
			x-www-browser "http://$PROJECT.dev/$addition"
		elif [ "$DRUPAL" == "8/new" ]; then
			x-www-browser "http://$PROJECT.pro/$addition"
		else
			errDrupal
			exit 1
		fi
		;;
	login)
		requireProject

		if [ "$DRUPAL" == "7" ]; then
			dlogin=$(drush uli)
		elif [ "$DRUPAL" == "8/old" ]; then
			dlogin=$(drush uli)
		elif [ "$DRUPAL" == "8/new" ]; then
			cd web
			dlogin=$(drush uli)
		else
			errDrupal
			exit 1
		fi
		
		regex="default\/(.*)"

		[[ $dlogin =~ $regex ]]
		loginURL="${BASH_REMATCH[1]}"

		lm open $loginURL
		;;
	help|*)
		echo 
		if [ 'help' != "$1" ]; then
			err "No known command found with name ${NOTICE}'$1'${NC}"
			echo 
		fi
		log "Command list:"
		log "	lm help                                                  - list all commands"
		log "	lm cc                                                    - cache rebuild / cache clear"
		log "	lm cim                                                   - export config"
		log "	lm cex                                                   - import config"
		log "	lm en <module>                                           - enable module in drupal ${USAGE}(use 'lm in <module> [version:~1.0.0]' before!)${NC}"
		log "	lm dis <module>                                          - disable module in drupal"
		log "	lm in <module> [version:~1.0.0]                          - install module in composer"
		log "	lm install <composer-module> [version:~1.0.0]            - install composer module with composer"
		log "	lm un <module>                                           - uninstall module in composer ${USAGE}(use 'lm dis <module>' before!)${NC}"
		log "	lm up <module>                                           - update a composer module ${USAGE}(example: 'lm up core')${NC}"
		log "	lm show <module> [filter]                                - show package data ${USAGE}(example: 'lm show core version' to show the core version)${NC}"
		log "	lm new <command> <param...>                              - generate new objects"
		log "	lm uuid [set]                                            - get or set the uuid of the drupal instance"
		log "	lm service [search]                                      - show all services defined in drupal"
		log "	lm inc <module> [version:~1.0.0]                         - install and enable module ${USAGE}('lm in <module> [version:~1.0.0]' and 'lm en <module>')${NC}"
		log "	lm info                                                  - show info of script variables (debug)"
		log "	lm open [additional-path:'']                             - Open the project in browser"
		log "	lm login                                                 - Login in local site with drush uli"
		log "	lm init <git-url> <local-dir> <local-db> [branch:master] - Create a existing drupal '8/new' project"
		echo 
		;;
esac
