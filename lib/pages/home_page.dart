import 'package:agenda_de_contatos/pages/add.dart';
import 'package:agenda_de_contatos/pages/edit.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  static String tag = '/home';
  @override
  HomeState createState() => HomeState();

  contactToEdit(var contact){
    return contact;
  }
}

class HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
      var nomeController = TextEditingController();
      var telefoneController = TextEditingController();
      var emailController = TextEditingController();
      var enderecoController = TextEditingController();
      var CEPController = TextEditingController();
      FirebaseFirestore db = FirebaseFirestore.instance;
      var snap = db.collection("usuarios").doc("EIcCwwQ8ZNqiPjRpIEJP").collection("contatos").where('excluido', isEqualTo: false).snapshots();
      Home home = Home();


      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Agenda de Contatos"),
        ),
        body: StreamBuilder(
          stream: snap,
          builder: (
              BuildContext context,
              AsyncSnapshot<QuerySnapshot> snapshot
              ) {
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, i){
                var item = snapshot.data.docs[i];
                return Dismissible(
                    key: Key(item.id),
                    onDismissed: (direction) {
                      setState(() async {
                        await db.collection("usuarios").doc("EIcCwwQ8ZNqiPjRpIEJP").collection("contatos").doc(item.id).delete();
                      });
                      },
                    direction: DismissDirection.endToStart,
                    background: Container(
                      alignment: AlignmentDirectional.centerEnd,
                      color: Colors.red,
                      child: Icon(Icons.delete, color: Colors.white)
                    ),
                    child: ListTile(
                      title: Text(item['nome']),
                      subtitle: Text(item['telefone']),
                      trailing: TextButton.icon(
                        icon: Icon(Icons.edit, size: 18),
                        label: Text(''),
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => edit()
                            ),
                          );
                              }
                          ),
                      ),
                    );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => add()
              ),
            );
          },
          tooltip: "Adicionar novo",
          child: Icon(Icons.add),
        ),
      );
    }  // build
  }