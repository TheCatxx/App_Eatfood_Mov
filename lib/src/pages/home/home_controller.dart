import 'package:eatfoot_flutter_delivery/src/models/user.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController{
  
  User user = User.fromJson(GetStorage().read('user') ?? {});
  
  HomeController(){
    print('USUARIO DE SESION: ${user.toJson()}');
  }

  void signOut() {
    GetStorage().remove('user');
    Get.offNamedUntil('/', (route) => false); //ELIMINA TODO EL HISTORIAL DE PANTALLAS
  }
  
}