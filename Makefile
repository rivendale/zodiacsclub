#@-- help command to show usage of make commands --@#
help:
	@echo "----------------------->>>>>>>>>>>>><<<<<<<<<<<<<<--------------------------"
	@echo "-                     Available Docker commands                            -"
	@echo "----------------------------------------------------------------------------"
	@echo "---> make start         - To start the containers in the background"
	@echo "---> make start-verbose - To start the containers verbosely"
	@echo "---> make stop          - To stop the app containers"
	@echo "---> make redeploy      - To redeploy the app containers"
	@echo "---> make help          - To show usage commands"
	@echo "----------------------------------------------------------------------------"




#@-- command to start the container in the background --@#
start:
	@echo "<<<<<<<<<<Start up the app in the background after building>>>>>>>>>>>>>>"
	@echo ""
	docker-compose up -d

#@-- command to start the application --@#
start-verbose:
	@echo "<<<<<<<<<<Start up the app containers after building>>>>>>>>>>>>>>"
	@echo ""
	docker-compose up


#@-- command to stop the application --@#
stop:
	@echo "<<<<<<<<<<Stop running the app containers>>>>>>>>>>>>>>"
	@echo ""
	docker-compose down

#@-- command to redeploy the application --@#
redeploy:
	@echo "<<<<<<<<<<Redeploy running the app containers>>>>>>>>>>>>>>"
	@echo ""
	sh redeploy.sh

#@-- command to stop the application and remove all containers, networks, and volumes --@#
kill:
	@echo "<<<<<<<<<<Stop running the app and remove containers>>>>>>>>>>>>>>"
	@echo ""
	docker-compose down -v

#@-- help should be run by default when no command is specified --@#
default: help
