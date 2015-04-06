# initialize with an environment, and it returns a function that can do a db operation in a transaction.
module.exports = (env)->
  (cb)->
    MongoClient = require('mongodb').MongoClient
    assert = require('assert')

    # // Connection URL
    url = 'mongodb://localhost:27017/test'
     # Use connect method to connect to the Server
    MongoClient.connect(url, (err, db)->
      assert.equal(null, err)
      console.log("Connected correctly to server")
      cb(db, ->
        db.close()
      )
    )
