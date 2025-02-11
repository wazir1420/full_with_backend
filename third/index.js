// index.js
const express = require("express");
const mongoose = require("mongoose");
const Product = require("./product"); // Ensure this path is correct

const app = express();

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Connect to MongoDB using async/await
const connectDB = async () => {
  try {
    await mongoose.connect("mongodb+srv://baltiwazir7:jcOtfs8uDZKS4HaZ@cluster0.1r2vr.mongodb.net/flutter", {
    
    });
    console.log("✅ Connected to Mongoose");
  } catch (error) {
    console.error("❌ Connection error:", error);
    process.exit(1);
  }
};

// POST API - Add Product
app.post("/api/add_product", async (req, res) => {
  console.log("Add Product Request:", req.body);
  const data = new Product(req.body);
  try {
    const dataToStore = await data.save();
    res.status(200).json(dataToStore);
  } catch (error) {
    res.status(400).json({ status: error.message });
  }
});

// GET API - Fetch Products
app.get("/api/get_product", async (req, res) => {
  try {
    const products = await Product.find();
    res.status(200).json({ status_code: 200, products });
  } catch (error) {
    res.status(500).json({ status: "error", message: error.message });
  }
});

// PUT API - Update Product
app.put("/api/update/:id", async (req, res) => {
  try {
    const updatedProduct = await Product.findByIdAndUpdate(req.params.id, req.body, { new: true });
    if (!updatedProduct) {
      return res.status(404).json({ status: "error", message: "Product not found" });
    }
    res.status(200).json({ status: "success", message: "Product Updated", product: updatedProduct });
  } catch (error) {
    res.status(500).json({ status: "error", message: error.message });
  }
});

// DELETE API - Delete Product
app.delete("/api/delete/:id", async (req, res) => {
  try {
    const deletedProduct = await Product.findByIdAndDelete(req.params.id);
    if (!deletedProduct) {
      return res.status(404).json({ status: "error", message: "Product not found" });
    }
    res.status(200).json({ status: "success", message: "Product deleted" });
  } catch (error) {
    res.status(500).json({ status: "error", message: error.message });
  }
});

// Start the server after connecting to MongoDB
connectDB().then(() => {
  app.listen(2000, () => console.log("✅ Server running on port 2000"));
});
