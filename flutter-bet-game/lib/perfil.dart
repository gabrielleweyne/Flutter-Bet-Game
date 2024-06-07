import 'package:flutter/material.dart';

class Perfil extends StatelessWidget {
  Function callback;
  String nomeUsuario;
  int pontosUsuario;

  Perfil(this.callback, this.nomeUsuario, this.pontosUsuario);

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      backgroundColor: Color(0xFFADD8E6),
      appBar: AppBar(
          title: Text('Perfil de ${nomeUsuario}'),
        ),
        body: Column(
          children: [
            Text('Pontos: ${pontosUsuario}'),
            ElevatedButton(
                child: const Text('Jogar Novamente!'),
                onPressed: () => callback(1))
          ],
        ));
  }
}
