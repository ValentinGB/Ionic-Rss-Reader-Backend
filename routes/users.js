var express = require('express');
var router = express.Router();
var db = require('../db');

router.post('/login', function(req, res, next) {
    let conn = db.get();

    conn.query('SELECT ID_user FROM user WHERE email = ? LIMIT 1', req.body.email, (err, rows) => {
        if(err) {
            res.json({ok:false,error:err});
            return;
        }

        if(rows.length){
            res.json({ok:true,ID_user:rows[0].ID_user});
            return;
        }

        let userData = {
            email: req.body.email,
            name: req.body.name,
            gender: req.body.gender
        };

        conn.query('INSERT INTO user SET ?', userData, (err, rows, result) => {
            if(err){
                res.json({ok:false,msg:err});
                return;
            }
            res.json({ok:true,ID_user:rows.insertId});
        });
    });

});

module.exports = router;
