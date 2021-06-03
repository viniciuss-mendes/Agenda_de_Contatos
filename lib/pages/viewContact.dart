import 'dart:ui';
import 'package:agenda_de_contatos/pages/calendar.dart';
import 'package:agenda_de_contatos/pages/edit.dart';
import 'package:agenda_de_contatos/pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class view extends StatefulWidget {
  static String tag = '/view';
  String colecao;
  String nomeID;
  String nome;
  String CEP;
  String telefone;
  String email;
  String endereco;
  view(this.colecao, this.nomeID, this.nome, this.CEP, this.telefone, this.email, this.endereco);
  @override
  _viewState createState() => _viewState();
}
FirebaseFirestore db = FirebaseFirestore.instance;
class _viewState extends State<view> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("Informações do Contato"),
            leading: GestureDetector(
              onTap: () { Navigator.push(context,
                MaterialPageRoute(
                    builder: (context) => Home(widget.colecao)
                ),); },
              child: Icon(
                Icons.arrow_back_ios_outlined,  // add custom icons also
              ),
            ),
            actions: <Widget>[
        Padding(
        padding: EdgeInsets.only(right: 20.0),
        child: GestureDetector(
          onTap: () {Navigator.push(context,
            MaterialPageRoute(
                builder: (context) => Calendar(widget.colecao, widget.nomeID)
            ),);},
          child: Icon(
            Icons.calendar_today_rounded,
            size: 26.0,
          ),
        )
    ),
    ]
    ),
    body: Form(
      child: ListView(
        children: <Widget> [
          SizedBox(height: 30,),
          Text("Nome: " + widget.nome, style: TextStyle(fontSize: 20, color: Colors.black, backgroundColor: Colors.grey ), ),
          SizedBox(height: 40,),
          Text("Telefone: " + widget.telefone, style: TextStyle(fontSize: 20, color: Colors.black, backgroundColor: Colors.grey ),),
          SizedBox(height: 40,),
          Text("Email: " + widget.email, style: TextStyle(fontSize: 20, color: Colors.black, backgroundColor: Colors.grey ),),
          SizedBox(height: 40,),
          Text("CEP: " + widget.telefone, style: TextStyle(fontSize: 20, color: Colors.black, backgroundColor: Colors.grey),),
          SizedBox(height: 20,),
          Text( widget.endereco, textAlign: TextAlign.center, style: TextStyle(fontSize: 15, color: Colors.black38),),
          SizedBox(height: 20,),
        ]
    ),
    ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => edit(widget.colecao, widget.nomeID, widget.nome, widget.CEP, widget.telefone, widget.email, widget.endereco)
            ),
          );
        },
        tooltip: "Adicionar novo",
        child: Icon(Icons.edit),
      ),
    );
  }
}