import 'package:even_odd/main.dart';
import 'package:flutter/material.dart';

class ListaUsuarios extends StatelessWidget {
  Function callback;
  List<Player> listaUsuarios = [];
  var nomeUsuarioAtual;

  ListaUsuarios(this.callback, this.listaUsuarios, this.nomeUsuarioAtual);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFADD8E6),
      appBar: AppBar(
          title: Text('Lista de Jogadores'),
        ),
        body: Column(
          children: [
            Column(
              children: listaUsuarios
                  .where((player) => player.nomeusuario != nomeUsuarioAtual)
                  .map((player) => Row(
                        children: [
                          Text(player.nomeusuario),
                          ElevatedButton(
                              child: const Text('Escolher Oponente'),
                              onPressed: () => callback(player.nomeusuario)),
                        ],
                      ))
                  .toList(),
            ),
          ],
        ));
  }
}
