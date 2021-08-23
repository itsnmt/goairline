require('dotenv').config();
const express = require('express');
const app = express();
const PORT = 3000;
const db = require('./services/mysql_db');
var bodyParser = require('body-parser')

app.use(express.json());
app.set('views', __dirname + '/views');
app.engine('html', require('ejs').renderFile);
app.set('view engine', 'ejs');
app.use(express.static(__dirname + '/public'));
var jsonParser = bodyParser.json()
var urlencodedParser = bodyParser.urlencoded({ extended: false })

app.get('/', (req,res) => {
    db.query('select * from airport_location', function(err, result, fields){
        if (err)
        {
            throw err;
        }
        else
        {
            var arr = []
            for (var i in result)
            {
                var people = result[i];
                arr.push(people.City);  

            }
            res.render('index.html', {city : arr});
        }
    });
})

app.get('/search/result', (req,res) => {
    let origin = req.query.origin;
    let destination = req.query.destination;
    let dateofjourney = req.query.dateofjourney;
    let numberofpassengers = req.query.numberofpassengers;

    db.query('select * from flight_details where Source="'+origin+'" AND Destination="'+destination+'" AND DOJ="'+dateofjourney+'"', function(err, result, fields){
        if (err)
        {
            throw err;
        }
        else
        {
            var arr = []
            for (var i in result)
            {
                var people = result[i];
                if(people.Seat_Availability>=numberofpassengers){
                    people.numberofpassengers = numberofpassengers;
                    arr.push(people);
                }
            }
            // console.log(arr[0].Seat_Availability);
            res.render('search_results.html', {flights : arr});
        }
    });
    // res.send('done');
})

app.get('/book', (req,res) => {
    var fid = req.query.fid;
    var noof = req.query.no;
    res.render('book.html', {fid : fid, noof : noof});
})

app.post('/book/flight', urlencodedParser, async(req,res) => {
    var fid = req.body.fid;
    var noof = req.body.numberofpass;
    var bookid = randomString(10);
    var error = false;
    var balance = 0;
    var curr_rem = 0;
    var se = 'AB';
    var pass = '';
    var seats = '';
    var source;
    var destination;
    var dt;
    var at;
    var reason;
        db.query('select * from flight_details where Flight_ID="'+fid+'"', function(err, result, fields){
            if (err)
            {
                console.log(err); error = true;
                reason = 'Server Error'
            }
            else
            {
                    people = result[0];
                    var curr_rem = people.Seat_Availability;
                    source = people.Source;
                    destination = people.Destination;
                    dt = people.Departure_time;
                    at = people.Arrival_time;
                    var balance = curr_rem - noof;
                    if(balance>=0){
                        for(var i=1; i<=noof; i++){
                            var fname = eval('req.body.fname'+i);
                            var lname = eval('req.body.lname'+i);
                            var age = eval('req.body.age'+i);
                            var gender = eval('req.body.gender'+i);
                            var email = eval('req.body.email'+i);
                            var phone = eval('req.body.pnum'+i);
                            if(i==noof){
                                var str = "" + i
                                var pad = "000"
                                var ans = pad.substring(0, pad.length - str.length) + str
                                var temp = se+ans
                                seats += temp
                                pass += fname+' '+lname
                            }else{
                                var str = "" + i
                                var pad = "000"
                                var ans = pad.substring(0, pad.length - str.length) + str
                                var temp = se+ans+', '
                                seats += temp
                                pass += fname+' '+lname+', '
                            }
                            db.query('INSERT INTO passenger_infomation (First_Name, Last_Name, Age, Gender, Email, Phone, FLIGHT_ID, BOOKING_ID) VALUES ("'+fname+'","'+lname+'","'+age+'","'+gender+'","'+email+'","'+phone+'","'+fid+'","'+bookid+'")', function(err, result, fields){
                                if (err)
                                {
                                    console.log(err);
                                    error = true;
                                    reason = 'Server Error'
                                }
                            });
                        }
                        db.query('update flight_details set Seat_Availability=Seat_Availability-'+noof+' where Flight_ID="'+fid+'"', function(err, result, fields){
                            if (err)
                            {
                                console.log(err);
                                error = true;
                                reason = 'Server Error'
                            }
                        });
                    }else{
                        error = true;
                        reason = 'Tickets Sold Out'
                    }
                if(error){
                    res.render('failed.html', { reason: reason});
                }else{
                    res.render('success.html',{fid: fid, source: source, destination: destination, at: at, dt: dt, seats: seats, pass: pass, bookid: bookid  });
                }
            }
        });     
})

app.listen(
    PORT,
    () => console.log(`App is running on port : ${PORT}`)
)

function randomString(length) {
    return Math.round((Math.pow(36, length + 1) - Math.random() * Math.pow(36, length))).toString(36).slice(1);
}