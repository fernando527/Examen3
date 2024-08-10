import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:examen3/crear_cancion.dart';
import 'package:examen3/firebase_options.dart';
import 'contador_controller.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Albumes de rock',
      initialRoute: '/home',
      routes: {
        '/home': (BuildContext context) => const HomePage(),
        '/crear_cancion': (BuildContext context) => CrearCancion(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final productosRef = FirebaseFirestore.instance.collection('cancion');

    final controller = Get.put(ContadorController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Albumes de rock'),
      ),
      body: StreamBuilder(
        // future: productosRef.get(),
        stream: productosRef.snapshots(),
        builder: (BuildContext conext,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          final query = snapshot.data;

          final listaProductos = query!.docs;

          return ListView.builder(
            itemCount: listaProductos.length,
            itemBuilder: (BuildContext context, int index) {
              final producto = listaProductos[index].data();

              return ListTile(
                leading: IconButton(
                  icon: const Icon(Icons.plus_one),
                  onPressed: () {
                    controller.contador++;
                  },
                ),
                title: Text(producto['nombrealbum']),
                subtitle: Text(producto['nombrebanda']),
                trailing: Obx(() {
                  return Text(
                    'Me Gusta:${controller.contador}',
                  );
                }),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/crear_cancion');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
