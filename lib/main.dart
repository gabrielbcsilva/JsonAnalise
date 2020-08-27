import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  //recebendo os dados da API(NO final do código)
  List _data = await getjson();
  //Debug print da Arvore para análise
//for(int i = 0; i< _data.length; i++){
//debugPrint("${_data[i]}");
//}

  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text("JSON"),
      ),
      //Construindo um List view Controlado para receber os dados
      body: Center(
        child: ListView.builder(
          itemCount: _data.length,//Tamanho da lista
          padding: const EdgeInsets.all(14.5),
          itemBuilder: (BuildContext context, int position){ //item Builder é para construção da Coluna return Column
            return Column(
              children: <Widget>[
                Divider(height: 5.5,),
                ListTile(
                  title: Text(
                      "${_data[position]['name']}"
                  ),
                  subtitle: Text(
                      "Email : ${_data[position]['email']}"
                  ),
                  leading: CircleAvatar(// Icone em forma de contato da Classe ListTile/
                    backgroundColor: Colors.blueGrey,
                    child: Text("${_data[position]['name'][0]}"),
                  ),
                  onTap: () => debugPrint("${_data[position]['email']}"), //Quando clicado rapido ele retorna a posição da lista no campo email
                  onLongPress:()=> _showMessage(context,"Você mora em ${_data[position]['address']['city']}, Rua: ${_data[position]['address']['street']}" +
                      ", Número: ${_data[position]['address']['suite']}."),//Quando clicado segurando Cria um diálogo acessando o campo body
                )
              ],
            );
          },

        ),
      ),
    ),
  ));
}
void _showMessage(BuildContext context, String message){
  var alert = AlertDialog(
    title: Text('JSON'),
    content: Text(message),
    actions: <Widget>[
      FlatButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text("OK"),
      )
    ],
  );
  showDialog(context: context, builder: (context) => alert);
}
//Realizando a requisição JSON o site colocado é uma API de teste gratuita
Future<List> getjson() async {
  String url = "https://jsonplaceholder.typicode.com/users";
  http.Response response = await http.get(url);
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Falhou!');
  }
}