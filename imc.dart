import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
  double _abaixo = 18.5;
  double _normal = 24.9;
  double _SPeso = 29.9;
  double _OBgrau1 = 34.9;
  double _OBgrau2 = 39.9;

  // double _OBgrau3 = 40;

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  String _infoText = "informe seus dados";

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _resetFields() {
    _formKey = GlobalKey<FormState>();
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "informe seus dados";
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100.0;

      double imc = weight / (height * height);

      if (imc < _abaixo) {
        _infoText = "Abaixo do peso (${imc.toStringAsPrecision(4)})";
      } else if (imc < _normal) {
        _infoText = "Na faixa do peso: (${imc.toStringAsPrecision(4)})";
      } else if (imc < _SPeso) {
        _infoText = "Acima do peso: (${imc.toStringAsPrecision(4)})";
      } else if (imc < _OBgrau1) {
        _infoText = "Obesidade Grau 1, Peso: (${imc.toStringAsPrecision(4)})";
      } else if (imc < _OBgrau2) {
        _infoText = "Obesidade Grau 2, Peso: (${imc.toStringAsPrecision(4)})";
      } else {
        _infoText = "Obesidade Grau 3, Peso: (${imc.toStringAsPrecision(4)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple.shade600,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh), onPressed: _resetFields),
        ],
      ),
      backgroundColor: Colors.deepPurple.shade300,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.person_outline,
                  size: 120.0, color: Colors.blue.shade200),
              TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  labelText: "Peso(kg)",
                  labelStyle: TextStyle(color: Colors.blue.shade50),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blue.shade50, fontSize: 25.0),
                controller: weightController,
                validator: (value) {
                  if (value
                      .toString()
                      .isEmpty) {
                    return "Insira peso";
                  }
                  if (double.parse(value.toString()) > 500) {
                    return "Digite um valor válido";
                  }
                  if (double.parse(value.toString()) <= 0) {
                    return "Digite um valor válido";
                  }
                  if (num.parse(value.toString()) == null) {
                    return "Digite um valor válido";
                  }
                },
              ),

              TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  labelText: "Altura(cm)",
                  labelStyle: TextStyle(color: Colors.blue.shade50),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blue.shade50, fontSize: 25.0),
                controller: heightController,
                validator: (value) {
                  if (value.toString().isEmpty) {
                    return "Insira altura";
                  }
                  if (double.parse(value.toString()) > 300) {
                    return "Digite um valor válido";
                  }
                  if (double.parse(value.toString()) <= 0) {
                    return "Digite um valor válido";
                  }
                  if (num.parse(value.toString()) == null) {
                    return "Digite um valor válido";
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 25.0, bottom: 25.0),
                child: Container(
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _calculate();
                      }
                    },
                    child: Text("Calcular"),
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStateProperty.all(Colors.blue.shade300),
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
                  "$_infoText",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blue.shade50, fontSize: 24.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
