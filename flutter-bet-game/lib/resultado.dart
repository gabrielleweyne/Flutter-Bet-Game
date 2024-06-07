import 'package:flutter/material.dart';

// As apostas são comparadas e o resultado exibido
class Resultado extends StatelessWidget {
  // funcao para trocar de tela
  Function anotherBetCallback;
  Function playerProfileCallback;
  String desafiador;
  String desafiado;
  String resultadoApostaAtual;

  Resultado(this.anotherBetCallback, this.playerProfileCallback, this.desafiado,
      this.desafiador, this.resultadoApostaAtual);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFADD8E6),
      appBar: AppBar(
        title: Text('Resultado: ' + desafiador + ' vs. ' + desafiado),
      ),
      body: Column(
        children: [
          Text(resultadoApostaAtual),
          ElevatedButton(
              child: const Text('Jogue Novamente!'),
              onPressed: () => anotherBetCallback()),
          ElevatedButton(
              child: const Text('Perfil'),
              onPressed: () => playerProfileCallback())
        ],
      ),
    );
  }
}
