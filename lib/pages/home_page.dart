import 'package:agenda_de_contatos/pages/add.dart';
import 'package:agenda_de_contatos/pages/edit.dart';
import 'package:agenda_de_contatos/pages/login.dart';
import 'package:agenda_de_contatos/pages/viewContact.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatefulWidget {
  static String tag = '/home';
  String nome;
  Home(this.nome);
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
      var pesquisaController = TextEditingController();
      FirebaseFirestore db = FirebaseFirestore.instance;
      var snap = db.collection(widget.nome).where('excluido', isEqualTo: false).snapshots();

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
                        await db.collection(widget.nome).doc(item.id).delete();
                      });
                      },
                    direction: DismissDirection.endToStart,
                    background: Container(
                      alignment: AlignmentDirectional.centerEnd,
                      color: Colors.red,
                      child: Icon(Icons.delete, color: Colors.white)
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(item['foto']),

                      ),
                      title: Text(item['nome']),
                      subtitle: Text(item['telefone']),
                      trailing: TextButton.icon(
                        icon: Icon(Icons.pages, size: 18, color: Colors.black38),
                        label: Text(''),
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => view(widget.nome,
                                                            item['nomeId'],
                                                            item['nome'],
                                                            item['CEP'],
                                                            item['telefone'],
                                                            item['email'],
                                                            item['endereço'])
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
                  builder: (context) => add(widget.nome)
              ),
            );
          },
          tooltip: "Adicionar novo",
          child: Icon(Icons.add),
        ),
      );
    }  // build
  }