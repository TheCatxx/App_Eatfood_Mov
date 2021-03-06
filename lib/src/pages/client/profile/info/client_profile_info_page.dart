import 'package:eatfoot_flutter_delivery/src/pages/client/profile/info/client_profile_info_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientProfileInfoPage extends StatelessWidget {

  ClientProfileInfoController con = Get.put(ClientProfileInfoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack( // POSICIONA ELEMENTOS UNO ENCIMA DEL OTRO
        children: [
          _backgroundCover(context),
          _boxForm(context),
          _imageUser(context),
          _buttonSignOut(),
        ],
      ),
    );
  }


  Widget _backgroundCover(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.35,
      color: Colors.amber,
    );
  }

  Widget _boxForm(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.3, left: 50, right: 50),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black54,
                blurRadius: 15,
                offset: Offset(0, 0.75)
            )
          ]
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _textName(),
            _textEmail(),
            _textPhone(),
            _buttonUpdate(context)
          ],
        ),
      ),
    );
  }

  Widget _buttonSignOut() {
    return SafeArea(
        child: Container(
          margin: EdgeInsets.only(left: 20),
          alignment: Alignment.topRight,
          child: IconButton(
            onPressed: () => con.signOut(),
            icon: Icon(
              Icons.power_settings_new,
              color: Colors.white,
              size: 30,
            ),
          ),
        )
    );
  }

  Widget _buttonUpdate(BuildContext context){
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      child: ElevatedButton(
          onPressed: () => {},
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 15)
          ),
          child: Text(
            'ACTUALIZAR DATOS',
            style: TextStyle(
                color: Colors.black
            ),
          )
      ),
    );
  }

  Widget _imageUser(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(top: 25),
        alignment: Alignment.topCenter,
        child: CircleAvatar(
          backgroundImage: con.user.image != null
              ? NetworkImage(con.user.image!)
              : AssetImage('assets/img/user_profile.png') as ImageProvider,
          radius: 60,
          backgroundColor: Colors.white,
        ),
      ),
      );
  }


  Widget _textName(){
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: ListTile(
        leading: Icon(Icons.person),
        title: Text('${con.user.name ?? ''} ${con.user.lastname ?? ''}'),
      subtitle: Text('Nombre del usuario'),
      ),

    );
  }

  Widget _textEmail(){
    return  ListTile(
        leading: Icon(Icons.email),
        title: Text(con.user.email ?? ''),
        subtitle: Text('EmaiL'),
    );

  }

  Widget _textPhone(){
    return  ListTile(
        leading: Icon(Icons.phone),
        title: Text(con.user.phone ?? ''),
        subtitle: Text('Phone'),

    );
  }

}
