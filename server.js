var connect = require('connect');

var port = process.env['PORT'] || 3001;
var setHeaders = function(req, res, next) {
  res.setHeader("Cache-Control", "public, max-age=604800"); // 1 week
  res.setHeader("Expires", new Date(Date.now() + 604800000).toUTCString());
  return next();
};
var app = connect().
  use(setHeaders).
  use(connect.static('public')).
  use(connect.staticCache());
  
app.listen(port, function() {
  console.log("Listening on port "+port);
});
