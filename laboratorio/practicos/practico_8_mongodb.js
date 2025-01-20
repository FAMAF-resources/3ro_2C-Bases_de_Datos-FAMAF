//ejercicio 1
use("mflix")
db.theaters.aggregate([
    {
        $group: {
            "_id": "$location.address.state",
            "theaters": {"$sum": 1}
        }
    },
    {
        $project: {
            "location.address.state": 1, "theaters": 1, "_id": 1
        }
    }
])

//ejercicio 2
use("mflix")
db.theaters.aggregate([
    {
        $group: {
            "_id": "$location.address.state",
            "theaters": {"$sum": 1}
        }
    },
    {
        $match: {
            "theaters": {$gte: 2}
        }
    },
    {
        $count: "states"
    }
])

//ejercicio 3
use("mflix")
db.movies.aggregate([
    {
        $match: {
            "directors": "Louis Lumière"
        }
    },
    {
        $count: "dir by L Lumiere"
    }
])

//ejercicio 4
use("mflix")
db.movies.aggregate([
    {
        $match: {
            "year": {$gte: 1950, $lt: 1960}
        }
    },
    {
        $count: "from the 50s"
    }
])

//ejercicio 5
use("mflix")
db.movies.aggregate([
    {
        $unwind: "$genres"
    },
    {
        $group: {
            "_id": "$genres",
            "genres": {$sum: 1}
        }
    },
    {
        $sort: {
            "genres": -1
        }
    },
    {
        $limit: 10
    },
    {
        $project: {
            "Genre": "$_id", "Count": "$genres", "_id": 0
        }
    }
])

//ejercicio 6
use("mflix")
db.comments.aggregate([
    {
        $group: {
            "_id": {"email": "$email", "name": "$name"},
            "n_comments": {$count: {}}
        }
    },
    {
        $sort: {"n_comments": -1}
    },
    {
        $limit: 10
    },
    {
        $project: {
            "name": "$_id.name", "mail": "$_id.email", "comments": "$n_comments", "_id": 0
        }
    }
])

//ejercicio 7
use("mflix")
db.comments.aggregate([
    {
        $group: {
            "_id": "$movie_id",
            "n_comments": {$count: {}}
        }
    },
    {
        $sort: {"n_comments": -1}
    },
    {
        $limit: 10
    },
    {
        $lookup: {
            from: "movies",
            localField: "_id",
            foreignField: "_id",
            as: "movie"
        }
    },
    {
        $project: {
            "n_comments":1, "Movie Title": "$movie.title",
            "Movie Year": "$movie.year", "_id":0
        }
    }
])

//ejercicio 8
