//EJERCICIO 1
use("mflix")
db.users.insertMany([
    {name: "Jorge Luis", email: "jorgeluis@mail.com", password:"jorgelito"},
    {name: "María Jose", email: "mariajose@mail.com", password:"mariajosefa"},
    {name: "Porota Perales", email: "porales@mail.com", password:"hunter2"}
])

db.comments.insertMany([
    {name: "Jorge Luis", email: "jorgeluis@mail.com", text: "muy rico todo"},
    {name: "María Jose", email: "mariajose@mail.com", text: "No recuerdo haberla visto"},
    {name: "Porota Perales", email: "porales@mail.com", text: "Quién diría que al final Bruce Willis estaba muerto toda la peli"}
])

//EJERCICIO 2
use("mflix")
db.movies.find(
    {//match
        year:{$gte:1990, $lt:2000},
        "imdb.rating":{$exists: true, $type: 1}
    }, 
    {//projection
        title:1, year:1, cast:1, directors:1, "imdb.rating":1
    }
).sort(
    {"imdb.rating":-1}
).limit(
    10
)

//EJERCICIO 3
use("mflix")
use("mflix")
db.comments.find(
    {//match
        movie_id: ObjectId("573a1399f29313caabcee886"),
        date: {$gte:ISODate("2014-01-01T00:00:00Z"), 
                $lt:ISODate("2017-01-01T00:00:00Z")}
    }, 
    {//projection
        name:1, email:1, text:1, date:1
    }
).sort(
    {date:1}
)

//2da parte
use("mflix")
use("mflix")
db.comments.find(
    {//match
        movie_id: ObjectId("573a1399f29313caabcee886"),
        date: {$gte:ISODate("2014-01-01T00:00:00Z"), 
                $lt:ISODate("2017-01-01T00:00:00Z")}
    }, 
    {//projection
        name:1, email:1, text:1, date:1
    }
).sort(
    {date:1}
).count()

//EJERCICIO 4
use("mflix")
db.comments.find(
    {//match
        email:"patricia_good@fakegmail.com"
    },
    {//projection
        name:1, movie_id:1, text:1, date:1
    }
).sort(
    {date:-1}
).limit(3)

//EJERCICIO 5
use("mflix")
db.movies.find(
    {//match
        genres: {$in: ["Action", "Drama"]},
        languages: {$size: 1},
        $or: [
            {"imdb.rating": {$gt: 9}}, 
            {runtime: {$gte: 180}}
        ]
    }, 
    {//projection
        title:1, languages:1, genres:1, released:1, "imdb.votes":1
    }
).sort(
    {released:1, "imdb.votes":1}
)


//EJERCICIO 6
use("mflix")
db.theaters.find(
    {//match
        "location.address.state": {$in: ["CA", "NY", "TX"]},
        "location.address.city": /^F.*$/
    }, 
    {//projection
        theaterId:1, "location.address.state":1, 
        "location.address.city":1, "location.address.coordinates":1
    }
).sort(
    {"location.address.state":1,
    "location.address.city":1}
)


//EJERCICIO 7
use("mflix")
db.comments.updateOne(
    {//match
        _id: ObjectId("5b72236520a3277c015b3b73")
    },
    {//update
        $set: { text: "mi mejor comentario", date: new Date}
    }
)

//EJERCICIO 8
use("mflix")
db.users.updateOne(
    {//match
        email:"joel.macdonel@fakegmail.com"
    },
    {//update
        $set: {password: "some password"}
    },
    {
        upsert:true
    }
)
//Se inserta el usuario la primera vez porque no existía, 
//la segunda solo matchea y no updatea nada

//EJERCICIO 9
use("mflix")
db.comments.deleteMany(
    {//match
        email:"victor_patel@fakegmail.com",
        date: {$gte:ISODate("1980-01-01T00:00:00Z"), 
                $lt:ISODate("1981-01-01T00:00:00Z")}
    }
)


//EJERCICIO 10
use("restaurantdb")
db.restaurants.find(
    {//match
        grades: { 
            $elemMatch: 
            {
                date: {$gte:ISODate("2014-01-01T00:00:00Z"), 
                        $lt:ISODate("2016-01-01T00:00:00Z")},
                score: {$gt:70, $lte:90}
            }
        }
    }, 
    {//projection
        restaurant_id:1, grades:1
    }
)

//EJERCICIO 11
use("restaurantdb")
db.restaurants.update(
    {//match
        restaurant_id: "50018608"
    },
    {//update
        $push: {
            grades: {
                $each: [
                    {
                        "date" : ISODate("2019-10-10T00:00:00Z"),
                        "grade" : "A",
                        "score" : 18
                    },
                    {
                        "date" : ISODate("2020-02-25T00:00:00Z"),
                        "grade" : "A",
                        "score" : 21
                    }
                ]
            }
        }
    }
    //{
    //    upsert:true
    //}
)
