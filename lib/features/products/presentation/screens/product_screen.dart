import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/product_provider.dart';

class ProductScreen extends ConsumerWidget {
  final String productId;

  const ProductScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final producState = ref.watch(productProvider(productId));

    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Producto'),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.camera_alt_outlined))
        ],
      ),
      body: const Center(
        child: Text('hola mundo'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.save_alt_outlined),
      ),
    );
  }
}
