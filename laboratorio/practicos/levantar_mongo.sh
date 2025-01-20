#Ver el comentario en el archivo levantar docker
#Esto es parecido pero para usar mongoDB con la extension de VSCode
#Some assembly required
sudo systemctl start mongod
sudo systemctl status mongod | cat
#mongorestore --host localhost --drop --gzip --db mflix mflix/
#mongoimport --host localhost --db restaurantdb --collection restaurants --drop --file restaurantdb/restaurants.json
mongoimport --host localhost --db supplies --collection sales --drop --file final/nosql/supplies/sales.metadata.json
#mongoimport --host localhost --db university --collection grades --drop --file university/grades.metadata.json


mongorestore --host localhost --port 27017 --drop --db supplies final/nosql/supplies
