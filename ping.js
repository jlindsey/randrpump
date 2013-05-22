var http = require('http');

http.get('http://randrpump.com', function(res) {
  res.setEncoding('utf-8');
  console.log("PING http://randrpump.com "+res.statusCode);
  process.exit(0);
}).on('error', function(err) {
  console.log("PING ERROR: "+err.message);
});

