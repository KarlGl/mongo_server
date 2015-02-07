env = require('./env')
express = require('express')
app = module.exports = express()
assert = require('assert')

require('./server')(app, env)
