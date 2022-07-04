import 'package:eatfoot_flutter_delivery/src/models/response_api.dart';
import 'package:eatfoot_flutter_delivery/src/models/user.dart';
import 'package:eatfoot_flutter_delivery/src/providers/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {

  User user = User.fromJson(GetStorage().read('user') ?? {});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  UsersProvider usersProvider = UsersProvider();

  void goToRegisterPage() {
    Get.toNamed('/register');
  }

  void login() async {
    String email = emailController.text.trim(); //.trim elimina los espacios en blanco
    String password = passwordController.text.trim();

    //Mostrar en consola
    print('Email ${email}');
    print('Password ${password}');


    //Mostrar en la aplicacion
    //Get.snackbar('Email', email);
    //Get.snackbar('Password', password);

    if(isValidForm(email, password)){

      ResponseApi responseApi = await usersProvider.login(email, password);
      
      print('Response Api ${responseApi.toJson()}');

      if (responseApi.success == true) {

        GetStorage().write('user', responseApi.data); //DATOS DEL USUARIO EN SESION

        if (user.roles!.length > 1) {
          goToRolesPage();
        }
        else { //solo un rol
          goToClientProductPage();
        }




      }
      else {
        Get.snackbar('Login Fallido', responseApi.message ?? '');
      }

    }

  }

  void goToClientProductPage() {
    Get.offNamedUntil('/client/products/list', (route) => false);
  }

  void goToRolesPage() {
    Get.offNamedUntil('roles', (route) => false);
  }

  bool isValidForm(String email, String password) {

    if (email.isEmpty) {
      Get.snackbar('Formulario no valido', 'Debes ingresar email');
      return false;
    }

    if (!GetUtils.isEmail(email)) {
      Get.snackbar('Formulario no valido', 'El email no es valido');
      return false;
    }

    if (password.isEmpty) {
      Get.snackbar('Formulario no valido', 'Debes ingresar password');
      return false;
    }

    return true;

  }

}