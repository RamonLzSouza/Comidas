import 'package:flutter/material.dart';
import 'package:CrudComidas/model/comida.dart';
import 'package:CrudComidas/db/database_helper.dart';
import 'package:CrudComidas/ui/comida_screen.dart';

class ListViewComida extends StatefulWidget {
  @override
  _ListViewComidaState createState() => new _ListViewComidaState();
}

class _ListViewComidaState extends State<ListViewComida> {
  List<Comida> items = new List();
  //conexão com banco de dados
  DatabaseHelper db = new DatabaseHelper();
  @override
  void initState() {
    super.initState();
    db.getComidas().then((comidas) {
      setState(() {
        comidas.forEach((comida) {
          items.add(Comida.fromMap(comida));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastro de Comidas',
      home: Scaffold(
        appBar: AppBar(
          title: Image.asset(
            'assets/images/comidas.png',
            fit: BoxFit.cover,
            height: 100,
          ),
          backgroundColor: Colors.pink,
        ),
        body: 
          Container(
            decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage('https://i.imgur.com/TvxmvhP.png'),
              fit: BoxFit.cover),),
            child: Center(
            child: ListView.builder(
              itemCount: items.length,
              padding: const EdgeInsets.all(15.0),
              itemBuilder: (context, position) {
                return Column(
                  children: [
                    Divider(height: 5.0),
                    ListTile(
                      //isThreeLine: true,
                      title: Text(
                        '${items[position].nome} ',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),

                      subtitle: Column(
                        children: [
                          Text(
                              ' Tipo: ${items[position].tipo} - Calorias: ${items[position].calorias} - Preço: ${items[position].preco}',
                              style: new TextStyle(
                                fontSize: 15.0,
                              )),
                          IconButton(
                              icon: const Icon(Icons.remove_circle_outline),
                              onPressed: () => _deleteComida(
                                  context, items[position], position)),
                        ],
                      ),
                      leading: CircleAvatar(
                        backgroundColor: Colors.pink,
                        radius: 20.0,
                        child: Text(
                          '${items[position].id}',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black
                          ),
                        ),
                      ),
                      onTap: () => _navigateToComida(context, items[position]),
                    ),
                  ],
                );
              }),
        ),
      ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _createNewComida(context),
        ),
      ),
    );
  }

  void _deleteComida(BuildContext context, Comida comida, int position) async {
    db.deleteComida(comida.id).then((comidas) {
      setState(() {
        items.removeAt(position);
      });
    });
  }

  void _navigateToComida(BuildContext context, Comida comida) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ComidaScreen(comida)),
    );
    if (result == 'update') {
      db.getComidas().then((comidas) {
        setState(() {
          items.clear();
          comidas.forEach((comida) {
            items.add(Comida.fromMap(comida));
          });
        });
      });
    }
  }

  void _createNewComida(BuildContext context) async {
    //aguarda o retorno da página de cadastro
    String result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ComidaScreen(Comida('', '', '', ''))),
    );
    //se o retorno for salvar, recarrega a lista
    if (result == 'save') {
      db.getComidas().then((comidas) {
        setState(() {
          items.clear();
          comidas.forEach((comida) {
            items.add(Comida.fromMap(comida));
          });
        });
      });
    }
  }
}
