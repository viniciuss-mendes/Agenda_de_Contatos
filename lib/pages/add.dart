import 'package:agenda_de_contatos/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class add extends StatefulWidget {
  static String tag = '/add';
  @override
  _addState createState() => _addState();
}

class _addState extends State<add> {
  var nomeController = TextEditingController();
  var telefoneController = TextEditingController();
  var emailController = TextEditingController();
  var enderecoController = TextEditingController();
  var CEPController = TextEditingController();

  FirebaseFirestore db = FirebaseFirestore.instance;
  Home home = Home();

  editContact() async{
    var snap = await db.collection("usuarios").doc("EIcCwwQ8ZNqiPjRpIEJP").collection("contatos").where('usuario', isEqualTo: home.contactToEdit).get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Editar Contato"),
      ),
      body: Form(
        child: ListView(
          padding: EdgeInsets.all(16),
          children: <Widget>[
            TextFormField(
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                    labelText: "Nome do contato:",
                    hintText: "Informe o novo nome"
                ),
                controller: nomeController
            ),
            SizedBox(height: 15,),
            TextFormField(
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                    labelText: "Informe o endereco",
                    hintText: "Informe o novo endereco"
                ),
                controller: enderecoController
            ),
            SizedBox(height: 15,),
            TextFormField(
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                    labelText: "Informe o CEP",
                    hintText: "Informe o novo CEP"
                ),
                controller: CEPController
            ),
            SizedBox(height: 15,),
            TextFormField(
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                    labelText: "Informe o email",
                    hintText: "Informe o novo email"
                ),
                controller: emailController
            ),
            SizedBox(height: 15,),
            TextFormField(
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                    labelText: "Informe o telefone",
                    hintText: "Informe o novo telefone"
                ),
                controller: telefoneController
            ),
            SizedBox(height: 15,),
            Container(
              height: 25,
              child: ElevatedButton(
                  child: Text("Adicionar",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white
                    ),),
                  onPressed: () async {
                    await db.collection("usuarios").doc("EIcCwwQ8ZNqiPjRpIEJP").collection("contatos").add
                      ({'nome': nomeController.text,
                      'telefone': telefoneController.text,
                      'email':emailController.text,
                      'endereço':enderecoController.text,
                      'CEP':CEPController.text,
                      'excluido': false} );
                    Navigator.of(context).pop();
                  }
              ),
            ),
            SizedBox(height: 15,),
            Container(
              height: 25,
              child: ElevatedButton(
                  child: Text("Cancelar",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white
                    ),),
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Home(),
                      ),
                    );
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }
}