
###
Module dependencies.
###
express = require "express"
routes = require "./routes"
http = require "http"
path = require "path"
fs = require "fs"
coffee = require "coffee-script"
app = express()

# all environments
app.set "port", process.env.PORT or 3000
app.set "views", path.join(__dirname, "views")
app.set "view engine", "jade"
app.use express.favicon()
app.use express.logger("dev")
app.use express.bodyParser()
app.use express.methodOverride()
app.use app.router
app.use require("stylus").middleware(path.join(__dirname, "public"))
app.use express.static(path.join(__dirname, "public"))

app.get '/:script.js', (req, res) ->
  res.header 'Content-Type', 'application/x-javascript'
  cs = fs.readFileSync "#{__dirname}/client/assets/coffee/#{req.params.script}.coffee", "ascii"
  js = coffee.compile cs
  res.send js

# development only
app.use express.errorHandler()  if "development" is app.get("env")
app.get "/", routes.index
app.get '/:roomname', (req, res) ->
  res.render "index",
    title: req.params.roomname,
    url: "http://#{req.headers.host}/#{req.params.roomname}"

http.createServer(app).listen app.get("port"), ->
  console.log "Express server listening on port " + app.get("port")
  return
