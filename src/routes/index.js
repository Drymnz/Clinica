const express = require('express');
const router  = express.Router();

//list router get 
router.get('/',(req, res)=>{
    res.send('Bienvenido');
});

//export
module.exports = router;