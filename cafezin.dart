import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //-----constantes-----
  //--------------------
  //-----variáveis------

  String _dropdownValue = "";
  String _dropdownCofValue = "";

  double result = 0;

  // String _whatCOF = "";
  // String _min = "";

  //--------------------

  TextEditingController mlContr = TextEditingController();

  // TextEditingController heightController = TextEditingController();

  //String _infoText = "informe seus dados";
  String _infoText2 = "22";

  String _textoINFO = "informe seus dados";

  double consumo = 0;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void dropdownCallback(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        _dropdownValue = selectedValue;
        _pessoa();
      });
    }
  }

  void _pessoa() {
    setState(() {
      consumo = double.parse(mlContr.text);
      if (_dropdownCofValue != "") {
        if (_dropdownCofValue == "normal") {
          result = consumo * 0.68;
          _infoText2 = "cafe normal";
        } else {
          result = consumo * 2;
          _infoText2 = "cafe expresso";
        }
      } else {
        _textoINFO = "insira um café";
      }

      if (_dropdownValue != "") {
        if (_dropdownValue == "Criança") {
          if (result > 100) {
            _textoINFO = "café demais!1";
          } else {
            _textoINFO = "pó beber";
          }
        } else if (_dropdownValue == "Adulto") {
          if (result > 400) {
            _textoINFO = "café demais!2";
          } else {
            _textoINFO = "pó beber";
          }

        } else if (_dropdownValue == "Gestante" ||
            _dropdownValue == "Lactante") {
          if (result > 200) {
            _textoINFO = "café demais!3";
          } else {
            _textoINFO = "pó beber";
          }
        } else if (_dropdownValue == "Sensivel") {
          if (result > 200) {
            _textoINFO = "café demais!4";
          } else {
            _textoINFO = "pó beber";
          }
        }
      } else {
        _textoINFO = "INSIRA ALGO";
      }
    });
  }

  void _resetFields() {
    setState(() {
      _formKey = GlobalKey<FormState>();
      mlContr.text = "";
      _textoINFO = "informe seus Dados";
    });
  }

  void _McRICKQueDebuga() {
    setState(() {
      _textoINFO = _dropdownValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "HotCoffe",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.brown.shade700,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh), onPressed: (){
            _resetFields();
          }),
        ],
      ),
      backgroundColor: Colors.brown,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Icon(Icons.coffee_outlined,
                  size: 120.0, color: Colors.pinkAccent.shade400),
              DropdownButton(
                items: const [
                  DropdownMenuItem(child: Text("Selecionar"), value: ""),
                  DropdownMenuItem(child: Text("Criança e Adolescente"), value: "Criança"),
                  DropdownMenuItem(child: Text("Adulto"), value: "Adulto"),
                  DropdownMenuItem(child: Text("Gestante"), value: "Gestante"),
                  DropdownMenuItem(child: Text("Lactante"), value: "Lactante"),
                  DropdownMenuItem(
                      child: Text("Sensível á cafeína"), value: "Sensivel"),
                ],
                value: _dropdownValue,
                onChanged: (String? value) {
                  if (value is String) {
                    setState(() {
                      _dropdownValue = value;
                    });
                  }
                },
                style: TextStyle(color: Colors.white),
                dropdownColor: Colors.brown.shade300,
                isExpanded: true,
                icon: Icon(Icons.table_rows, color: Colors.pinkAccent.shade400),
                iconSize: 43.0,
              ),
              DropdownButton(
                items: const [
                  DropdownMenuItem(child: Text("Selecionar"), value: ""),
                  DropdownMenuItem(child: Text("normal"), value: "normal"),
                  DropdownMenuItem(child: Text("expresso"), value: "expresso"),
                ],
                value: _dropdownCofValue,
                onChanged: (String? value) {
                  if (value is String) {
                    setState(() {
                      _dropdownCofValue = value;
                    });
                  }
                },
                style: TextStyle(color: Colors.white),
                dropdownColor: Colors.brown.shade300,
                isExpanded: true,
                icon: Icon(Icons.table_rows, color: Colors.pinkAccent.shade400),
                iconSize: 43.0,
              ),
              TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: InputDecoration(
                    labelText: "Qtd. de Café (ml)",
                    labelStyle: TextStyle(color: Colors.pink.shade50),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.pink.shade100, fontSize: 25.0),
                  controller: mlContr,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "insira consumo";
                    } else if (double.parse(value) < 1) {
                      return "consumo muito baixo";
                    }
                  }),
              Padding(
                padding: EdgeInsets.only(top: 25.0, bottom: 25.0),
                child: Container(
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _pessoa();
                      }
                    },
                    child: Text("Calcular"),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.pinkAccent.shade400),
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue.shade50),
                      // padding: MaterialStateProperty.all(EdgeInsets.all(50)),
                      // textStyle: MaterialStateProperty.all(TextStyle(fontSize: 30))),
                    ),
                  ),
                ),
              ),
              Container(
                child: Text(
                  "$_textoINFO",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.pink.shade50, fontSize: 24.0),
                ),
              ),
              Container(
                child: Text(
                  "$result, $consumo, $_infoText2",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.pink.shade50, fontSize: 24.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
