var connect = require('connect');

var port = process.env['PORT'];
var app = connect().use(connect.static('public')).listen(port);
