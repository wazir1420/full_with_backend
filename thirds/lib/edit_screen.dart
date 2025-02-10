import 'package:flutter/material.dart';
import 'package:thirds/model/product_model.dart';
import 'package:thirds/services/api.dart';

class EditScreen extends StatefulWidget {
  final Product data;

  const EditScreen({super.key, required this.data});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  late TextEditingController nameController;
  late TextEditingController priceController;
  late TextEditingController descController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.data.name);
    priceController = TextEditingController(text: widget.data.price.toString());
    descController = TextEditingController(text: widget.data.desc);
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    descController.dispose();
    super.dispose();
  }

  void updateData() async {
    Map<String, dynamic> updatedData = {
      "pname": nameController.text,
      "pprice": priceController.text,
      "pdesc": descController.text,
      "id": widget.data.id
    };

    await Api.updateProduct(widget.data.id, updatedData);
    // ignore: use_build_context_synchronously
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Product')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(hintText: 'Product Name'),
              ),
              TextFormField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: 'Price'),
              ),
              TextFormField(
                controller: descController,
                decoration: const InputDecoration(hintText: 'Description'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: updateData,
                child: const Text('Update Data'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
