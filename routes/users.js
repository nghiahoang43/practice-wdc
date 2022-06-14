var express = require('express');
var router = express.Router();

/* GET users listing. */
router.get('/', function(req, res, next) {
  user = req.session.user[0];
  res.send('respond with a resource');
});

router.get('/logout', function(req, res, next) {
  user = null;
  res.send('respond with a resource');
});

/* POST update user session. */
router.post('/updateSession', function(req, res, next) {
  // Connect to the database
  req.pool.getConnection(function(err, connection) {
    if (err) {
      res.sendStatus(500);
      return;
    }
    var query = "SELECT * FROM User WHERE user_id = ?";
    connection.query(query, [req.body.user_id], function(err, rows, fields) {
      connection.release(); // release connection
      if (err) {
        res.sendStatus(500);
        return;
      }
      req.session.user = rows[0];
      res.json(rows); //send response
    });
  });
});

/* POST createOrder */
router.post('/createOrder', function(req, res, next) {
  // Connect to the database
  req.pool.getConnection(function(err, connection) {
    if (err) {
      res.sendStatus(500);
      return;
    }
    var query = "CALL create_order(?, ?)"; //mark
    connection.query(query, [req.body.shoe_id, req.body.buy_date], function(err, rows, fields) {
      connection.release(); // release connection
      if (err) {
        res.sendStatus(500);
        return;
      }
      res.json(rows); //send response
    });
  });
});

/* POST addShoeToOrder */
router.post('/addShoeToOrder', function(req, res, next) {
  // Connect to the database
  req.pool.getConnection(function(err, connection) {
    if (err) {
      res.sendStatus(500);
      return;
    }
    var query = "CALL add_shoe_to_order(?, ?, ?)"; //mark
    connection.query(query, [req.body.shoe_id, req.body.order_id, req.body.buy_date], function(err, rows, fields) {
      connection.release(); // release connection
      if (err) {
        res.sendStatus(500);
        return;
      }
      res.json(rows); //send response
    });
  });
});

/* POST addShoeToOrder */
router.post('/addShoeToOrder', function(req, res, next) {
  // Connect to the database
  req.pool.getConnection(function(err, connection) {
    if (err) {
      res.sendStatus(500);
      return;
    }
    var query = "CALL add_shoe_to_order(?, ?, ?)"; //mark
    connection.query(query, [req.body.shoe_id, req.body.order_id, req.body.buy_date], function(err, rows, fields) {
      connection.release(); // release connection
      if (err) {
        res.sendStatus(500);
        return;
      }
      res.json(rows); //send response
    });
  });
});


module.exports = router;
