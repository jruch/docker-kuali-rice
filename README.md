# Docker recipe for Kuali Rice

This instantiates a kuali rice instance.  Current edition is being setup to 
run krad-sampleapp app in standalone mode on mysql however the plan is to make this configurable.



Steps
---

Install copy of boot2docker and follow instructions found at:

		boot2docker.io
		 
nce you've started your boot2docker instance, update your host file with
		
		##  boot2docker <ip address>
		##  warning: this ip address may change
		boot2docker    192.168.59.103


Build a copy of mztaylor/docker-mysql (this version handles lower case table names)

		git clone github.com/mztaylor/docker-mysql.git mysql
		cd mysql
        docker build -t mysql .

Startup mysql instance:

	docker run --name mysqlrice -e MYSQL_ROOT_PASSWORD=root -d mysql

Build a docker image of this project

		git clone github.com/mztaylor/docker-kuali-rice.git ricedemo
		cd ricedemo
        docker build -t ricedemo .

Startup ricedemo docker image:

	docker run --name ricedemo --link mysqlrice:mysql -i -t -p 8080:8080 ricedemo

Review Site

        From browser: http://boot2docker:8080/

Remove Instance:

       docker ps -a | grep "ricedemo" | awk '{print $1}' | xargs docker rm
