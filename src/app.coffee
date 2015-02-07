env = require('./env')
express = require('express')
app = module.exports = express()
app.use(require('connect-livereload')())
bodyParser = require('body-parser')
app.use(bodyParser.json())
app.use(bodyParser.urlencoded({extended: true}))
app.post '/', (req, res)->
  console.log('post /')
  console.log(req.body)
  res.json(env.mem);

app.post '/env', (req, res)->
  console.log("Updating server environment")
  console.log(req.body)
  env.l._.each Object.keys(req.body), (key)->
    env.mem[key] = req.body[key]
  res.json(env.mem)

app.get('/', (req, res)->
  console.log('get /')
  console.log(req.body)
  res.json(env.mem)
)

server = app.listen(2081, ->
  host = server.address().address
  port = server.address().port
  console.log('Example app listening at http://%s:%s', host, port)
)
