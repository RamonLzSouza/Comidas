import 'package:flutter/material.dart';
import 'package:CrudComidas/model/comida.dart';
import 'package:CrudComidas/db/database_helper.dart';

class ComidaScreen extends StatefulWidget {
  final Comida comida;
  ComidaScreen(this.comida);
  @override
  State<StatefulWidget> createState() => new _ComidaScreenState();
}
class _ComidaScreenState extends State<ComidaScreen> {
  DatabaseHelper db = new DatabaseHelper();
  TextEditingController _nomeController;
  TextEditingController _tipoController;
  TextEditingController _caloriasController;
  TextEditingController _precoController;
  @override
  void initState() {
    super.initState();
    _nomeController = new TextEditingController(text: widget.comida.nome);
    _tipoController = new TextEditingController(text: widget.comida.tipo);
    _caloriasController = new TextEditingController(text: widget.comida.calorias);
    _precoController = new TextEditingController(text: widget.comida.preco);
  }
@override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text('Cadastro de Comidas'),
        centerTitle: true,
        backgroundColor: Colors.pink,
      ),
      body: Container(
        margin: EdgeInsets.all(15.0),
        alignment: Alignment.center,
        child: Column(
          children:[
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.local_dining, color: Colors.pink),
                labelText: 'Nome da Comida',
                 labelStyle: new TextStyle(color: Colors.pink),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.pink),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.pinkAccent),
                ),
              ),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            TextField(
              controller: _tipoController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.local_activity, color: Colors.pink),
                labelText: 'Tipo',
                labelStyle: new TextStyle(color: Colors.pink),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.pink),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.pinkAccent),
                ),
                ),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            TextField(
              controller: _caloriasController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.add_circle, color: Colors.pink),
                labelText: 'Calorias',
                labelStyle: new TextStyle(color: Colors.pink),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.pink),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.pinkAccent),
                ),
                ),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            TextField(
              controller: _precoController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.attach_money, color: Colors.pink),
                labelText: 'Preço',
                labelStyle: new TextStyle(color: Colors.pink),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.pink),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.pinkAccent),
                ),
              ),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            RaisedButton(
              child: (widget.comida.id != null) ? Text('Alterar') : Text('Inserir'),
              onPressed: () {
                if (widget.comida.id != null) {
                  db.updateComida(Comida.fromMap({
                    'id': widget.comida.id,
                    'nome': _nomeController.text,
                    'tipo': _tipoController.text,
                    'calorias': _caloriasController.text,
                    'preco': _precoController.text
                  })).then((_) {
                    Navigator.pop(context, 'update');
                  });
                } 
                else {
                  db.inserirComida(Comida(_nomeController.text, _tipoController.text, _caloriasController.text, _precoController.text))
                      .then((_) {
                    Navigator.pop(context, 'save');
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
