import 'package:flutter/material.dart';
import 'package:thirds/model/product_model.dart';
import 'package:thirds/services/api.dart';

class FetchData extends StatelessWidget {
  const FetchData({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<List<Product>>(
        future: Api.getProduct(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No products available"));
          }

          List<Product> pdata = snapshot.data ?? [];

          return ListView.builder(
            itemCount: pdata.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const Icon(Icons.storage),
                title: Text(pdata[index].name ?? 'No Name'),
                subtitle: Text(pdata[index].desc ?? 'No Description'),
                trailing: Text("\$${pdata[index].price.toString()}"),
              );
            },
          );
        },
      ),
    );
  }
}
