import 'package:agenda_de_contatos/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class add extends StatefulWidget {
  static String tag = '/add';
  String nome;
  add(this.nome);
  @override
  _addState createState() => _addState();
}

class _addState extends State<add> {
  String _resultado = "";
  String resultadoSalvar;
  _recuperaCep() async {
    String cepDigitado = CEPController.text;
    var uri = Uri.parse("https://viacep.com.br/ws/${cepDigitado}/json/");
    http.Response response;
    response = await http.get(uri);
    Map<String, dynamic> retorno = json.decode(response.body);
    String logradouro = retorno["logradouro"];
    String complemento = retorno["complemento"];
    String bairro = retorno["bairro"];
    String localidade = retorno["localidade"];
    String uf = retorno["uf"];
    String ddd = retorno["ddd"];
    setState(() { //configurar o _resultado
      _resultado = "\n\nDDD: ${ddd} \n\nUF: ${uf} \n\nLocalidade: ${localidade} \n\nBairro: ${bairro} \n\nLogradouro: ${logradouro} \n\nComplemento: ${complemento} ";
    });
  }
  var nomeController = TextEditingController();
  var telefoneController = TextEditingController();
  var emailController = TextEditingController();
  var enderecoController = TextEditingController();
  var CEPController = TextEditingController();
  var complementoController = TextEditingController();
  var fotoController = TextEditingController();

  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Adicionar Contato"),
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
                    labelText: "Informe o telefone",
                    hintText: "Informe o novo telefone"
                ),
                controller: telefoneController
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
                    labelText: "Insira a URL de uma foto",
                    hintText: "Informe a URL válida da foto do contato"
                ),
                controller: fotoController
            ),
            SizedBox(height: 15,),
            TextFormField(
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                    labelText: "Informe o CEP",
                    hintText: "Informe o novo CEP para saber o endereço"
                ),
                controller: CEPController
            ),
            SizedBox(height: 20,),
            Container(
              height: 40,
              color: Colors.white60,
              child:  ElevatedButton(
                 child: Text('Pesquisar Endereço',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white),),
                  onPressed: () async{
                      _recuperaCep();
                  }
              ),
            ),
            SizedBox(height: 10,),
            Text(_resultado),
            SizedBox(height: 20,),
            TextFormField(
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                    labelText: "Informe um complemento",
                    hintText: "Informe um complemento para agregar ao endereço pesquisado"
                ),
                controller: complementoController
            ),
            SizedBox(height: 50,),
            Container(
              height: 40,
              child: ElevatedButton(
                  child: Text("Adicionar Contato",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.white
                    ),),
                  onPressed: () async {
                    if(fotoController.text == null){ fotoController.text = "https://cdn.pixabay.com/photo/2017/01/10/03/54/icon-1968236_960_720.png";}
                    resultadoSalvar = _resultado + complementoController.text;
                    await db.collection(widget.nome).doc(nomeController.text).set
                      ({'nomeId' : nomeController.text,
                      'nome': nomeController.text,
                      'telefone': telefoneController.text,
                      'email':emailController.text,
                      'endereço':resultadoSalvar,
                      'CEP':CEPController.text,
                      'excluido': false,
                      'foto' : fotoController.text});
                    Navigator.of(context).pop();
                  }
              ),
            ),
            SizedBox(height: 30,),
            Container(
              height: 40,
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
                        builder: (context) => Home(widget.nome),
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