import 'package:flutter/material.dart';
import 'package:thirds/model/product_model.dart';
import 'package:thirds/services/api.dart';

class DeleteScreen extends StatefulWidget {
  const DeleteScreen({super.key});

  @override
  State<DeleteScreen> createState() => _DeleteScreenState();
}

class _DeleteScreenState extends State<DeleteScreen> {
  late Future<List<Product>> _futureProducts;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  void _loadProducts() {
    _futureProducts = Api.getProduct();
  }

  Future<void> _deleteProduct(String productId) async {
    debugPrint("🟡 Attempting to delete product with ID: $productId");

    if (productId.isEmpty) {
      debugPrint("❌ Error: Product ID is empty");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('❌ Invalid product ID')),
      );
      return;
    }

    debugPrint("🟢 Sending DELETE request for Product ID: $productId");

    bool success = await Api.deleteProduct(productId);

    if (success) {
      debugPrint("✅ Product deleted successfully!");
      setState(() {
        _loadProducts();
      });
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ Product deleted successfully')),
      );
    } else {
      debugPrint("❌ Failed to delete product. Check API response.");
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('❌ Failed to delete product')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Delete Operation')),
      body: FutureBuilder<List<Product>>(
        future: _futureProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No products found.'));
          } else {
            List<Product> products = snapshot.data!;
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.storage),
                  title: Text(products[index].name ?? "No Name"),
                  subtitle: Text(products[index].desc ?? "No Description"),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteProduct(products[index].id ?? ""),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
