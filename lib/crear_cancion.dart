import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CrearCancion extends StatelessWidget {
  CrearCancion({super.key});

  final TextEditingController nombrealbumController = TextEditingController();
  final TextEditingController nombrebandaController = TextEditingController();
  final TextEditingController aniolanzamientoController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar cancion'),
      ),
      body: Column(
        children: [
          TextField(
            controller: nombrealbumController,
            decoration: const InputDecoration(
              labelText: 'Nombre del album:',
            ),
          ),
          TextField(
            controller: nombrebandaController,
            decoration: const InputDecoration(
              labelText: 'Nombre de la banda:',
            ),
          ),
          TextField(
            controller: aniolanzamientoController,
            decoration: const InputDecoration(
              labelText: 'Año de lanzamiento: ',
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              final producto = {
                'nombrealbum': nombrealbumController.text,
                'nombrebanda': nombrebandaController.text,
                'aniolanzamiento': double.parse(aniolanzamientoController.text),
              };

              //guardar en firebase
              final productosRef =
                  FirebaseFirestore.instance.collection('cancion');

              // final newProductoRef = await productosRef.add(producto);
              productosRef.doc('1234').set(producto);
              // print('Producto agregado con id: ' + newProductoRef.id);
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }
}
