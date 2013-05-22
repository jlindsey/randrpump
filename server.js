var connect = require('connect');

var port = process.env['PORT'] || 3001;
var app = connect().
  use(connect.static('public')).
  use(connect.staticCache());
  
app.listen(port, function() {
  console.log("Listening on port "+port);
});
