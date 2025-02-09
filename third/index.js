const express = require("express");

const app = express();

app.use(express.json());

app.use(express.urlencoded({
    extended: true
}));

const productData = [];

app.listen(2000, ()=>{
    console.log("Connected to service at 2000");
})


// post api
app.post("/api/add_product", (req, res)=>{
    console.log("Result", req.body);

    const pdata = {
        "id":productData.length+1,
        "pname":req.body.pname,
        "pprice":req.body.pprice,
        "pdesc":req.body.pdesc

    };

    productData.push(pdata);
    console.log("Final", pdata);

    res.status(200).send({
      "status_code":200,
      "message":"Product added successfully",
      "product":pdata
    });
})

// get api
app.get("/api/get_product", (req, res)=>{
    if(productData.length>0){
        res.status(200).send({
            'status_code':200,
            'products':productData
        });
    }else{
        res.status(200).send({
            'status_code':200,
            'products':[]
        });
    }

})