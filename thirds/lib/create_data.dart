import 'package:flutter/material.dart';
import 'package:thirds/services/api.dart';

class CreateData extends StatefulWidget {
  const CreateData({super.key});

  @override
  State<CreateData> createState() => _CreateDataState();
}

class _CreateDataState extends State<CreateData> {
  var nameController = TextEditingController();
  var priceController = TextEditingController();
  var descController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(hintText: 'Name here'),
              ),
              TextFormField(
                controller: priceController,
                decoration: InputDecoration(hintText: 'Price here'),
              ),
              TextFormField(
                controller: descController,
                decoration: InputDecoration(hintText: 'Desc here'),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    var data = {
                      "pname": nameController.text,
                      "pprice": priceController.text,
                      "pdesc": descController.text
                    };
                    Api.addProduct(data);
                  },
                  child: Text('Create Data'))
            ],
          ),
        ),
      ),
    );
  }
}
