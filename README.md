# Docker recipe for Kuali Rice

This instantiates a kuali rice instance.  Current edition is being setup to 
run krad-sampleapp app in standalone mode on mysql however the plan is to make this configurable.



Steps
---

Setup environment with boot2docker
		 
		 Install copy of boot2docker (follow installation instructions at boot2docker.io)
		 
		 Once you've started your boot2docker instance, update your host file with 'boot2docker <ip address>'
		 (i.e. boot2docker    192.168.59.103).  Warning: this ip address may change


Checkout a copy of mztaylor/docker-mysql (handles lower case table names)

		git clone github.com/mztaylor/docker-mysql.git mysql
        docker build -t mysql .

Build a docker image

        docker build -t ricedemo .

Setup mysql:

	docker run --name mysqlrice -e MYSQL_ROOT_PASSWORD=root -d mysql

Run a docker image:

	docker run --name ricedemo --link mysqlrice:mysql -i -t -p 8080:8080 ricedemo

Review Site

        From browser: http://boot2docker:8080/

Remove Instance:

       docker ps -a | grep "ricedemo" | awk '{print $1}' | xargs docker rm
