import 'package:flutter/material.dart';
import 'menuHamburguer.dart';
void main() {
  runApp(SobreApp());
}

class SobreApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
         appBar: AppBar(
        backgroundColor: Color(0xFF060D17),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu, color: Color(0xFFCB861F)),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: MenuHamburguer(),
        backgroundColor: Color(0xFF060D17),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Sobre o aplicativo",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.0),
                Text(
                  "Com o nosso aplicativo Flickfate, encontrar o próximo filme para assistir nunca foi tão fácil! Basta selecionar sua modalidade de filmes preferida, como drama, comédia, ação ou terror, e nós fazemos o resto. Nosso algoritmo inteligente irá sortear aleatoriamente um filme que se encaixa na sua escolha, proporcionando uma experiência cinematográfica única a cada uso. Além disso, o FlickFate também oferece, sinopse e informações sobre onde assistir ao filme selecionado, direcionando você para plataformas de streaming ou serviços de aluguel online. Dê um toque de sorte ao seu momento cinema!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
