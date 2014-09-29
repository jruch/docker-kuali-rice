# Docker recipe for Kuali Rice

This instantiates a kuali rice instance.  Current edition is being setup to 
run krad-sampleapp app in standalone mode on mysql however the plan is to make this configurable.



Steps
---

Install copy of boot2docker and follow instructions found at:

		boot2docker.io
		 
Once you've started your boot2docker instance, update your hosts file based on instructions found at 
http://www.rackspace.com/knowledge_center/article/how-do-i-modify-my-hosts-file
		
		##  boot2docker <ip address>
		##  warning: this ip address may change
		192.168.59.103  boot2docker    


Build a copy of mztaylor/docker-mysql (this version handles lower case table names):

		git clone https://github.com/mztaylor/docker-mysql.git mysql
		cd mysql
        docker build -t mysql .

Run your mysql docker image:

	docker run --name mysqlrice -e MYSQL_ROOT_PASSWORD=root -d mysql

Build a docker image of this project:

		git clone https://github.com/mztaylor/docker-kuali-rice.git ricedemo
		cd ricedemo
        docker build -t ricedemo .

Run your  ricedemo docker image:

	docker run --name ricedemo --link mysqlrice:mysql -i -t -p 8080:8080 ricedemo

Review Site:

        From browser: http://boot2docker:8080/

Remove Instance:

       docker ps -a | grep "ricedemo" | awk '{print $1}' | xargs docker rm
