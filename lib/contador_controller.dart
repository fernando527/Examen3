import 'package:get/get.dart';

class ContadorController extends GetxController {
  final RxInt _contador = 0.obs;

  int get contador => _contador.value;
  set contador(int valor) => _contador.value = valor;
}
