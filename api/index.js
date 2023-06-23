const express = require('express');
const app = express();
const bodyParser = require('body-parser');
const http = require('http');
const router= express.Router();

app.use(bodyParser.urlencoded({extended:true}));
app.use(bodyParser.json());

app.use((req,res,next)=>{
    res.header('Access-Control-Allow-Origin', '*');
    res.header('Access-Control-Allow-Headers','Origin,X-Requested-With,\
     Content-Type, Accept, Authorization');
    if(req.method==='OPTIONS'){
        res.header('Access-Control-Allow-methods', 'PUT,POST, DELETE,\
        PATCH,GET');
        return res.status(200).json({});
    }
    next();//this will not block incoming requests
});


router.post('/user/signIn',(req,res)=>{
    var userEmail=req.body.userEmail;
    var userPassword= req.body.userPassword;

    if(userEmail=="down@sun.com" && userPassword=="downer"){
        return res.status(200).json({
            message: 'success'
        })
    }
    else{
        return res.status(404).json({
            error:{
                message:'Auth Failed: incorrect password or email'
            }
        });
    }
})

router.post('/registerApple',(req,res)=>{
    console.log('register called');
    
    const {body}=req;
    const id=body.id;
    const yop=body.yop;
    const breed=body.breed;
    const row=body.row;
    const col=body.col;
    const location=body.location;

    console.log("inputs::::",id,yop, breed, row, col, location);

})
app.use(router);

const port=3000;
const hostname='192.168.43.167';
const server= http.createServer(app);

server.listen(port,hostname,()=>{console.log("listening at",port)});

