module.exports = (app, env)->
  app.use(require('connect-livereload')())
  bodyParser = require('body-parser')
  app.use(bodyParser.json())
  app.use(bodyParser.urlencoded({extended: true}))
  app.use((req, res, next)->
    res.header('Access-Control-Allow-Headers': 'accept, content-type')
    res.header('Access-Control-Allow-Credentials': 'true')
    res.header("Access-Control-Allow-Origin", req.headers.origin);
    #res.header("Allow", "POST,GET,HEAD,OPTIONS");
    res.header("Access-Control-Allow-Methods", "GET,POST,OPTIONS");
    next();
  );
  dbConnect = require('./db_connect')(env)

  app.post '/clear', (req, res)->
    dbConnect (db, closeCallback)->
      db.collection('proudness').remove({}
      , (err, result)->
        console.log(result)
        if err
          console.log(err)
        console.log("Removed " + result + " documents in the document collection");
        closeCallback()
        res.json(result)
      )
  
  app.post '/seed', (req, res)->
    console.log('say goodbye to all records')
    dbConnect (db, closeCallback)->
      # collection.find({}).toArray(function(err, docs) {
      db.collection('proudness').remove({}
      , (err, result)->
        console.log(result)
        if err
          console.log(err)
        console.log("Removed " + result + " documents in the document collection");

        # some example data
        d=new Date()

        data = [
          [15, 4],
          [14, 35],
          [13, 40],
          [11,43],
          [9, 50],
          [8, 40],
          [7, 60],
          [4, 84],
          [3, 90],
          [2, 93],
          [1, 60],
        ].map( (turple)->
          h = new Date(d.getFullYear(), d.getMonth(), d.getDate() - turple[0], d.getHours(), 0, 0, 0).getTime()
          {proud: turple[1], time: h}
        )
        db.collection('proudness').insert(data, (err, result)->
          closeCallback()
          res.json(result)
        )
      )

  app.post '/', (req, res)->
    console.log('posting a new proudness')
    console.log(req.body)

    dbConnect (db, closeCallback)->
      # collection.find({}).toArray(function(err, docs) {
      db.collection('proudness').insert(
        {proud : req.body.p, time: (new Date().getTime())}
      , (err, result)->
        console.log(result)
        if err
          console.log(err)
        console.log("Inserted " + result.length + " documents into the document collection");
        closeCallback()
        res.json(result)
      );

  app.get('/', (req, res)->
    console.log("GET INDEX")

    dbConnect (db, closeCallback)->
      db.collection('proudness').find().toArray((err, result)->
        console.log(result)
        if err
          console.log(err)
        closeCallback()
        res.json(result)
      )
  )


  # genric ENV modification.
  app.get '/env', (req, res)->
    res.json(env.mem)

  app.post '/env', (req, res)->
    console.log("Updating server environment")
    console.log(req.body)
    env.l._.each Object.keys(req.body), (key)->
      env.mem[key] = req.body[key]
    res.json(env.mem)

  server = app.listen(2081, ->
    host = server.address().address
    port = server.address().port
    console.log('Example app listening at http://%s:%s', host, port)
  )
