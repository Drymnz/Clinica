const express = require('express');
const morgan = require('morgan');
const path = require('path');
const exphbs = require('express-handlebars');

// initializations
const app = express();

//setting
app.set('port', process.envPORT || 4000);
app.set('views',path.join(__dirname,'views'));
/**app.engine(
    ".hbs",
    exphbs({
    defaultLayout: "main",
    layoutsDir: path.join(app.get("views"), "layouts"),
    partialsDir: path.join(app.get("views"), "partials"),
    extname: ".hbs",
    helpers: require("./lib/handlebars"),
  })
  );*/
// MIDELLEWARES
app.use(morgan("dev"));
app.use(express.urlencoded({ extended: false }));
app.use(express.json());

//global variable


//routes
app.use(require('./routes/index.js'));
app.use(require('./routes/authentication'));
app.use('/links',require('./routes/links'));
//public
app.use(express.static(path.join(__dirname,'public')));

//starting the server
app.listen(app.get('port'), () =>{
    console.log('Estas en el puerto ' + app.get('port'));
});