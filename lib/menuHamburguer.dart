// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'plataforma.dart';
import 'sobreApp.dart';
import 'historico.dart';

class MenuHamburguer extends StatelessWidget {
  const MenuHamburguer({Key? key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.6,
      child: Container(
        color: const Color(0xFF0A151F),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: 120, // Altura do header
              alignment: Alignment.center,
              color: const Color(0xFF0A151F),
              child: const Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home, color: Colors.white), // Ícone branco
              title: const Text('Início', style: TextStyle(color: Colors.white)), // Texto branco
              onTap: () {
               Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PlataformaScreen()),
                      );
              },
            ),
            ListTile(
              leading: const Icon(Icons.history, color: Colors.white), // Ícone branco
              title: const Text('Histórico', style: TextStyle(color: Colors.white)), // Texto branco
              onTap: () {
                Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HistoricoFilmesApp()),
                      );
              },
            ),
            ListTile(
              leading: const Icon(Icons.phone_iphone, color: Colors.white), // Ícone branco
              title: const Text('Sobre o aplicativo', style: TextStyle(color: Colors.white)), // Texto branco
              onTap: () {
                 Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SobreApp()),
                      );
              },
            ),
            
            const Divider( // Adiciona uma linha divisória
              color: Colors.grey,
              thickness: 1, // Define a espessura da linha
              height: 10, // Define a altura da linha
              indent: 20, // Define o recuo da linha à esquerda
              endIndent: 20, // Define o recuo da linha à direita
            ),
          ],
        ),
      ), // Define 20% da largura da tela para o Drawer
    );
  }
}
