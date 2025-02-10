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


// update api put
app.put("/api/update/:id", (req, res) => {
    let id = parseInt(req.params.id, 10);

    let index = productData.findIndex(p => p.id === id);
    if (index === -1) {
        return res.status(404).json({ status: "error", message: "Product not found" });
    }

    // Ensure the ID is not lost
    productData[index] = { ...productData[index], ...req.body, id };

    res.status(200).json({ status: "success", message: "Product Updated" });
});


// delete api
app.delete("/api/delete/:id", (req, res) => {
    let id = parseInt(req.params.id, 10); // Ensure ID is a number

    let index = productData.findIndex(p => p.id === id);
    if (index === -1) {
        return res.status(404).json({ status: "error", message: "Product not found" });
    }

    productData.splice(index, 1); // Remove product

    return res.status(200).json({ status: "success", message: "Product deleted" });
});

