#El punto de este script era automatizar el docker y copiarle hacia adentro las BD que nos daban para trabajar
#Deberían ser los mismos pasos que uno sigue para hacerlo a mano, pero todo de golpe, mas el copiado
#Los mensajes con echo son justamente para que una vez dentro del docker puedas cargar la BD, el schema y meterte a trabajar
sudo systemctl restart docker
NAME="lab-mysql"
docker rm $NAME
docker run -p 3300:3300 --name $NAME -e MYSQL_ROOT_PASSWORD=admin -d mysql:8.0
docker inspect --format  '{{ .NetworkSettings.IPAddress }}' $NAME

container_id=$(docker ps -aqf "name=$NAME")

#Para mandar archivos adentro del container 
#docker cp ./mandar_container/sakila-data.sql $container_id:/home/
#docker cp ./mandar_container/sakila-schema.sql $container_id:/home/
#docker cp ./mandar_container/classicmodels.sql $container_id:/home/
#docker cp ./mandar_container/soluciones.sql $container_id:/home/
#docker cp ./mandar_container/lab5.sql $container_id:/home/
#docker cp ./rec_parcial_1/olympics-data.sql $container_id:/home/
#docker cp ./rec_parcial_1/olympics-schema.sql $container_id:/home/
docker cp ./final/sql/data.sql $container_id:/home/
docker cp ./final/sql/schema.sql $container_id:/home/



echo
echo
echo Dentro del docker cargar primero el schema y despues el data
echo Las cosas estan dentro de la carpeta home del docker
echo mysql --host 172.17.0.2 -u root -p \< archivos_con_coso.sql
echo para meterse a la db hacer lo mismo pero sin nombre de archivo
echo pass es admin

docker exec -it $NAME bash
