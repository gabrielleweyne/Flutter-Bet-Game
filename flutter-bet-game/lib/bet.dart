import 'package:flutter/material.dart';

class Bet extends StatefulWidget {
  Function callback;
  String nomeUsuario;

  Bet(this.callback, this.nomeUsuario);

  @override
  State<StatefulWidget> createState() => BetState(callback, nomeUsuario);
}

class BetState extends State<Bet> {
  // funcao para trocar de tela
  Function callback;
  String nomeUsuario;
  int num = 1;
  int valorAposta = 0;
  int parImpar = 1;

  BetState(this.callback, this.nomeUsuario);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFADD8E6),
      appBar: AppBar(
        title: Text('Aposta de $nomeUsuario'),
      ),
      body: Column(
        children: [
          const Text('Escolha um número de 1 a 5'),
          Slider(
            label: '$num',
            min: 1,
            max: 5,
            divisions: 5,
            value: num.toDouble(),
            onChanged: (value) {
              setState(() {
                num = value.toInt();
              });
            },
          ),
          const Text('Valor da Aposta'),
          Slider(
            label: '$valorAposta',
            min: 0,
            max: 100,
            divisions: 10,
            value: valorAposta.toDouble(),
            onChanged: (value) {
              setState(() {
                valorAposta = value.toInt();
              });
            },
          ),
          Row(
            children: [
              const Text('Impar'),
              Radio(
                  value: 1,
                  groupValue: parImpar,
                  onChanged: (int? value) {
                    setState(() {
                      parImpar = 1;
                    });
                  }),
              const Text('Par'),
              Radio(
                  value: 2,
                  groupValue: parImpar,
                  onChanged: (int? value) {
                    setState(() {
                      parImpar = 2;
                    });
                  })
            ],
          ),
          ElevatedButton(
              child: const Text('Escolha Adversário'),
              onPressed: () => callback(valorAposta, parImpar, num))
        ],
      ),
    );
  }
}
