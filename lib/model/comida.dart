class Comida {
  int _id;
  String _nome;
  String _tipo;
  String _calorias;
  String _preco;
  //construtor da classe
  Comida(this._nome, this._tipo, this._calorias, this._preco);
  //converte dados de vetor para objeto
  Comida.map(dynamic obj) {
    this._id = obj['id'];
    this._nome = obj['nome'];
    this._tipo = obj['tipo'];
    this._calorias = obj['calorias'];
    this._preco = obj['preco'];
  }
  // encapsulamento
  int get id => _id;
  String get nome => _nome;
  String get tipo => _tipo;
  String get calorias => _calorias;
  String get preco => _preco;
 //converte o objeto em um map
 Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
       map['id'] = _id;
    }
    map['nome'] = _nome;
    map['tipo'] = _tipo;
    map['calorias'] = _calorias;
    map['preco'] = _preco;
    return map;
  }
  //converte map em um objeto
  Comida.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._nome = map['nome'];
    this._tipo = map['tipo'];
    this._calorias = map['calorias'];
    this._preco = map['preco'];
  }
}
