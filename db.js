var mysql = require('mysql');

var pool = mysql.createPool({
    host     : '127.0.0.1',
    user     : 'root',
    password : '',
    database : 'kriblet',
    port: '3306'
});

exports.get = function() {
  return pool;
}