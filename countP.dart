import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(title: "CONTANDO BABACAS", home: Home()));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int num_alunos = 0;
  String _text = "PODE VIR, SEMPRE CABE MAIS UM BABACA";

  _change(int increment) {
    setState(() {
      num_alunos += increment;
    });

    if (num_alunos>=45)
    {
        _text = "ESTA CHEIO DE BABACAS";
    }else if(num_alunos < 0)
      {
        _text = "BABACA OU É 1, OU É NENHUM. NÃO EXISTE BABACA NEGATIVO";
      } else {
      _text= "SEMPRE CABE MAIS UM BABACA!"; return;
      }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "BABACAS: $num_alunos",
          style:
              TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextButton(
                child: Text(
                  "-1",
                  style: TextStyle(fontSize: 40, color: Colors.white),
                ),
                onPressed: () {
                  _change(-1);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextButton(
                child: Text(
                  "+1",
                  style: TextStyle(fontSize: 40, color: Colors.white),
                ),
                onPressed: () {
                  _change(1);
                },
              ),
            ),
          ],
        ),
        Text(
          "$_text",
          style: TextStyle(
              color: Colors.white, fontStyle: FontStyle.italic, fontSize: 30.0),
        ),
      ],
    );
  }
}
