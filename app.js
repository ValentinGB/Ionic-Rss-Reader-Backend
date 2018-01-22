//core libraries
const   express = require('express'),
        cookieParser = require('cookie-parser'),
        bodyParser = require('body-parser');

//routes
const   users = require('./routes/users'),
        feeds = require('./routes/feeds');

var app = express();

//CORS
app.use(function(req, res, next) {
    res.header("Access-Control-Allow-Origin", "*");
    res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
    next();
});

//Body parsers
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));

//Load routes
app.use('/users', users);
app.use('/feeds', feeds);

//Unknown routes
app.use(function(req, res, next) {
    var err = new Error('Not Found');
    err.status = 404;
    next(err);
});

app.use(function(err, req, res, next) {
    res.locals.message = err.message;
    res.locals.error = req.app.get('env') === 'development' ? err : {};

    res.status(err.status || 500);
    res.json({error:err.message});
});

module.exports = app;
