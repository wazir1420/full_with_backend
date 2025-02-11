const mongoose = require("mongoose");

let dataSchema = mongoose.Schema({
    'pname':{
        required: true,
        type: String
    },
    'pprice':{
        required: true,
        type: Number
    },
    'pdesc':{
        required: true,
        type: String
    },
    
},{ timestamps: true });

module.exports = mongoose.model("node_js", dataSchema);