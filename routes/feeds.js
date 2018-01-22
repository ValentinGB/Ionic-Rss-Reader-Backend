const   express = require('express'),
        router = express.Router(),
        db = require('../db'),
        https = require('https');

//Route to load articles
router.get('/getFeed/:ID_user', function(req, res, next) {
    let ID_user = req.params.ID_user || 0;

    //Continue after last update date has been verified
    let goGetFeeds = (updateArticles) => getFeeds(ID_user, updateArticles, (data) => res.json(data));

    //Verify if a new articles update is needed
    needsUpdate(goGetFeeds);
});

//Like route
router.post('/like', function(req, res, next) {
    let data = req.body;
    let conn = db.get();

    conn.query('INSERT INTO user_like SET ?', data, (err, rows, result) => {
        let response = (err) ? {ok:false,msg:err} : {ok:true};
        res.json(response);
    })
});

// Dislike route
router.post('/dislike', function(req, res, next) {
    let data = req.body;
    let conn = db.get();

    conn.query('DELETE FROM user_like WHERE FK_ID_user = ? AND FK_ID_article = ?', [data.FK_ID_user, data.FK_ID_article],
    (err, rows) => {
        let response = (err) ? {ok:false,msg:err} : {ok:true};
        res.json(response);
    })
});

function getFeeds(ID_user, updateArticles,done){

    let conn = db.get();

    let finish = () => {

        conn.query('CALL GET_FEEDS(?)', ID_user, (err, rows)=>{
            let response = (err) ? {ok:false,error:err} : rows;
            done(response[0]);
        });
    }

    if(!updateArticles){
        finish(false);
        return;
    }

    https.get('https://api.rss2json.com/v1/api.json?rss_url=http://rss.nytimes.com/services/xml/rss/nyt/World.xml', (resp) => {
        let data = '';
    
        resp.on('data', (chunk) => {
            data += chunk;
        });
        resp.on('end', () => {
            data = JSON.parse(data);
            insertNewFeeds(data.items,finish);
        });
    
    }).on("error", (err) => {
        done({ok: false, msg: "Error: " + err.message});
    });

}

function needsUpdate(done){

    let conn = db.get(),
        today = formatDate(new Date());

    conn.query('SELECT * FROM last_update ORDER BY date LIMIT 1',(err,rows)=>{
        let updateDate = '';
        if (!err) {
            updateDate = formatDate(new Date(String(rows[0].date)));
        }

        verifyDates(updateDate);
    });
    
    let verifyDates = (updateDate) => {
        let updateArticles = ((updateDate < today) && updateDate != '') ? true : false;

        done(updateArticles);
    }
}

function insertNewFeeds(data,finish){
    let conn = db.get();

    let items = [];
    for(var x = 0; x < data.length; x++){
        items.push([
            data[x].title,
            data[x].link,
            String(data[x].pubDate).split(" ")[0], 
            data[x].enclosure.link,
            data[x].description
        ]);
    }

    conn.query('INSERT INTO article(title,link,date,image,description) VALUES ?', [items], (err, result, fields) => {
        let response = (err) ? false : true;
        finish(response);
        let today = formatDate(new Date());
        conn.query('INSERT INTO last_update SET ?', {date:today}, (err,result,fields) => {});
    });
}

function formatDate(date){
        dd = date.getDate(),
        mm = date.getMonth()+1,
        yyyy = date.getFullYear();

    dd = (dd<10) ? '0'+dd : dd;
    mm = (mm<10) ? '0'+mm : mm;
    date = yyyy+'-'+mm+'-'+dd;

    return date;
}

module.exports = router;
