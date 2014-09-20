# Docker recipe for Kuali Rice

This instantiates a kuali rice instance

Steps
---

Build a docker image
	docker build -t ricedemo .

Run a docker image
	docker run --name ricedemo -i -t -p 8080:8080 ricedemo

Review Site
        From ssh in docker container: curl localhost:8080 
        From browser: http://192.168.59.103:8080/

Remove Instance:
       docker ps -a | grep "ricedemo" | awk '{print $1}' | xargs docker rm
