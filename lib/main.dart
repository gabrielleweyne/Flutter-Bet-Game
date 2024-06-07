// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:even_odd/profile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'bet.dart';
import 'listausuarios.dart';
import 'register.dart';
import 'resultado.dart';

void main() => runApp(ParImpar());

class ParImpar extends StatefulWidget {
  @override
  State<ParImpar> createState() => ParImparState();
}

class Player {
  var nomeusuario;
  var pontos;

  Player(this.nomeusuario, this.pontos);

  factory Player.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'nomeusuario': String nomeusuario,
        'pontos': int point,
      } =>
        Player(
          nomeusuario,
          point,
        ),
      _ => throw const FormatException('Erro ao carregar usuario'),
    };
  }
}

class ParImparState extends State<ParImpar> {
  // 0 -> registrar
  // 1 -> lista de usuarios
  // 2 -> jogo
  // 3 -> resultado
  int currScreen = 0;
  String nomeUsuario = '';
  String nomeDesafiado = '';
  List<Player> listaUsuarios = [];
  String resultadoApostaAtual = '';
  int pontosUsuarioAtual = 0;

  void changeScreen(int newScreen) {
    setState(() {
      currScreen = newScreen;
    });
  }

  void setPlayerName(String novoNomeUsuario) {
    setState(() {
      nomeUsuario = novoNomeUsuario;
    });
  }

  Future<void> registerPlayer(String nome) async {
    var url = Uri.https('par-impar.glitch.me', 'novo');
    var response = await http.post(
      url,
      headers: {'Content-type': 'application/json'},
      body: jsonEncode({'nomeusuario': nome}),
    );

    if (response.statusCode == 200 || response.statusCode == 204) {
      List usuariosJson =
          ((jsonDecode(response.body) as Map<String, dynamic>)['usuarios']);

      listaUsuarios = usuariosJson
          .map((playerJson) => Player.fromJson(playerJson))
          .toList();

      nomeUsuario = nome;

      changeScreen(1);
    } else {
      throw const HttpException('Erro ao registrar jogador');
    }
  }

  Future<void> postBet(int valorAposta, int parImpar, int number) async {
    var url = Uri.https('par-impar.glitch.me', 'aposta');
    var response = await http.post(url,
        headers: {'Content-type': 'application/json'},
        body: jsonEncode({
          'nomeusuario': nomeUsuario,
          'valor': valorAposta,
          'parimpar': parImpar, // 2 -> even, 1 -> odd
          'numero': number
        }));

    if (response.statusCode == 200 || response.statusCode == 204) {
      changeScreen(2);
    } else {
      throw const HttpException('Erro ao registrar Aposta');
    }
  }

  Future<void> challengePlayer(String nomeDesafiado) async {
    nomeDesafiado = nomedesafiado;

    var url = Uri.https(
        'par-impar.glitch.me', 'jogar/' + nomedesafiado + '/' + nomeUsuario);
    var response = await http.get(url);
    if (response.statusCode == 200 || response.statusCode == 204) {
      var json = jsonDecode(response.body) as Map<String, dynamic>;

      if (json.containsKey('msg')) {
        resultadoApostaAtual = "Empate. Nenhum jogador ganha pontos.";
      } else {
        var vencedor = json['vencedor'];
        var perdedor = json['perdedor'];
        if (winner['nomeusuario'] == nomeUsuario) {
          resultadoApostaAtual = 'Você ganhou ${perdedor['valor']} pontos!';
        } else {
          resultadoApostaAtual = 'Você perdeu ${vencedor['valor']} pontos!';
        }
      }

      changeScreen(3);
    } else {
      throw const HttpException('Erro ao registrar aposta');
    }
  }

  Future<void> getPlayerProfile() async {
    var url = Uri.https('par-impar.glitch.me', 'pontos/' + nomeUsuario);
    var response = await http.get(url);
    if (response.statusCode == 200 || response.statusCode == 204) {
      var json = jsonDecode(response.body) as Map<String, dynamic>;

      pontosUsuarioAtual = json['pontos'];

      changeScreen(4);
    } else {
      throw const HttpException('Falha ao autenticar aposta');
    }
  }

  void anotherBet() {
    changeScreen(1);
  }

  Widget showScreen() {
    switch (currScreen) {
      case 1:
        return Bet(postBet, nomeUsuario);
      case 2:
        return ListaUsuarios(challengePlayer, listaUsuarios, nomeUsuario);
      case 3:
        return Result(anotherBet, getPlayerProfile, nomeDesafiado,
            nomeUsuario, resultadoApostaAtual);
      case 4:
        return Profile(changeScreen, nomeUsuario, pontosUsuarioAtual);
      default:
        return Register(registerPlayer);
    }
  }

  @override
  Widget build(BuildContext ctx) {
    return MaterialApp(
      title: 'Par ou Impar',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF89CFF0)),
          useMaterial3: true),
      home: showScreen(),
    );
  }
}
