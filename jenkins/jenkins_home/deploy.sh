host=192.168.124.151
ssh root@$host "
                mkdir -p /home/cicd_nginx
                cd /home/cicd_nginx
                docker-compose ps -q
                if [[ -n $? ]]; then docker-compose down; fi
                wait
                echo 'shut-down complete'
		rm -rf /home/cicd_nginx/*
"
scp -rp  $WORKSPACE/. root@$host:/home/cicd_nginx/
ssh root@$host "cd /home/cicd_nginx && docker-compose up -d"
