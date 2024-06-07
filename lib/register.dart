import 'package:flutter/material.dart';

class Register extends StatelessWidget {
  Function callback;

  Register(this.callback);

  @override
  Widget build(BuildContext ctx) {
    final formKey = GlobalKey<FormState>();
    final playerNameInput = TextEditingController();

    return Scaffold(
      backgroundColor: Color(0xFFADD8E6),
      appBar: AppBar(title: const Text('Registrar jogador'),),
      body: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            Padding(padding: const EdgeInsets.all(5.0), 
              child: TextFormField(controller: playerNameInput, decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Jogador'),),),
            ElevatedButton(onPressed: () => callback(playerNameInput.text), child: const Text('Aposta')),
          ],
        ),
      )
    );
  }
}
