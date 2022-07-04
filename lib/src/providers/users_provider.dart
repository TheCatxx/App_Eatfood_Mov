import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:eatfoot_flutter_delivery/src/environment/environment.dart';
import 'package:eatfoot_flutter_delivery/src/models/response_api.dart';
import 'package:eatfoot_flutter_delivery/src/models/user.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UsersProvider extends GetConnect{
  String url = Environment.API_URL + 'api/users'; //apuntamos a las rutas del usuario

  //DEFINIMOS EL METODO

  Future<Response> create(User user) async {
    Response response = await post(
      '$url/create',
      user.toJson(),
      headers: {
        'Content-Type': 'application/json'
      }
    ); //ESPERA HASTA QUE EL SERVIDOR NOS RETORNE LA RESPUESTA (ASYNC, AWAIT)

    return response;

  }

  Future<Stream> createWithImage(User user, File image) async {
    Uri uri = Uri.http(Environment.API_URL_OLD, '/api/users/createWithImage');
    final request = http.MultipartRequest('POST', uri);
    request.files.add(http.MultipartFile(
      'image',
      http.ByteStream(image.openRead().cast()),
      await image.length(),
      filename: basename(image.path)
    ));
    request.fields['user'] = json.encode(user);
    final response = await request.send();
    return response.stream.transform(utf8.decoder);
  }

  /*
  Utulizando el paqueta GET X
   */

  Future<ResponseApi> createUserWithImageGetX(User user, File image) async {

    FormData form = FormData({
      'image': MultipartFile(image, filename: basename(image.path)),
      'user': json.encode(user)
    });

    Response response = await post('$url/createWithImage', form);

    if (response.body == null) {
      Get.snackbar('Error en la aplicacion', 'No se pudo crear el usuario');
      return ResponseApi();
    }

    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    return responseApi;

  }

  Future<ResponseApi> login(String email, String password) async {
    Response response = await post(
        '$url/login',
        {
          'email': email,
          'password': password
        },
        headers: {
          'Content-Type': 'application/json'
        }
    ); //ESPERA HASTA QUE EL SERVIDOR NOS RETORNE LA RESPUESTA (ASYNC, AWAIT)

    if ( response.body == null) {
      Get.snackbar('Error', 'No se pudo ejecutar la peticion');
      return ResponseApi();
    }

    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    return responseApi;

  }

}