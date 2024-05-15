// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'genero.dart'; // Importa o arquivo com a classe GeneroScreen
import 'menuHamburguer.dart'; // Importa o arquivo com o widget do menu de hambúrguer

void main() {
  runApp(PlataformaScreen());
}

// ignore: use_key_in_widget_constructors
class PlataformaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF060D17), // Cor de fundo do app bar
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.menu, color: Color(0xFFCB861F)), // Ícone de menu hamburguer
                onPressed: () {
                  Scaffold.of(context).openDrawer(); // Abre o drawer ao clicar no ícone de menu
                },
              );
            },
          ),
        ),
        backgroundColor: const Color(0xFF060D17), 
        drawer: const MenuHamburguer(), // Adiciona o menu de hambúrguer à tela
        body: PlataformaContent(),
      ),
    );
  }
}

// ignore: use_key_in_widget_constructors
class PlataformaContent extends StatefulWidget {
  @override
  _PlataformaContentState createState() => _PlataformaContentState();
}

class _PlataformaContentState extends State<PlataformaContent> {
  double opacity = 0.0;
  String plataformaSelecionada = '';

  @override
  void initState() {
    super.initState();
    // Inicia a animação após um pequeno atraso
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        opacity = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Anima a opacidade do texto
              AnimatedOpacity(
                opacity: opacity,
                duration: const Duration(seconds: 1),
                child: const Text(
                  'Escolha uma streaming',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PlatformButton(
                    imagePath: 'images/netflix.png',
                    platform: 'Netflix',
                    opacity: opacity,
                    onPressed: () {
                      setState(() {
                        plataformaSelecionada = 'Netflix';
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => GeneroScreen(plataformaSelecionada: plataformaSelecionada)),
                      );
                    },
                  ),
                  const SizedBox(width: 20),
                  PlatformButton(
                    imagePath: 'images/disney+.png',
                    platform: 'Disney+',
                    opacity: opacity,
                    onPressed: () {
                      setState(() {
                        plataformaSelecionada = 'Disney+';
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => GeneroScreen(plataformaSelecionada: plataformaSelecionada)),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PlatformButton(
                    imagePath: 'images/max.png',
                    platform: 'HBO Max',
                    opacity: opacity,
                    onPressed: () {
                      setState(() {
                        plataformaSelecionada = 'HBO Max';
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => GeneroScreen(plataformaSelecionada: plataformaSelecionada)),
                      );
                    },
                  ),
                  const SizedBox(width: 20),
                  PlatformButton(
                    imagePath: 'images/primevideo.png',
                    platform: 'Prime Video',
                    opacity: opacity,
                    onPressed: () {
                      setState(() {
                        plataformaSelecionada = 'Prime Video';
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => GeneroScreen(plataformaSelecionada: plataformaSelecionada)),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PlatformButton(
                    imagePath: 'images/star+.png',
                    platform: 'Star+',
                    opacity: opacity,
                    onPressed: () {
                      setState(() {
                        plataformaSelecionada = 'Star+';
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => GeneroScreen(plataformaSelecionada: plataformaSelecionada)),
                      );
                    },
                  ),
                  const SizedBox(width: 20),
                  PlatformButton(
                    imagePath: 'images/globoplay.png',
                    platform: 'Globoplay',
                    opacity: opacity,
                    onPressed: () {
                      setState(() {
                        plataformaSelecionada = 'Globoplay';
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => GeneroScreen(plataformaSelecionada: plataformaSelecionada)),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PlatformButton(
                    imagePath: 'images/apptv.png',
                    platform: 'Apple TV+',
                    opacity: opacity,
                    onPressed: () {
                      setState(() {
                        plataformaSelecionada = 'Apple TV+';
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => GeneroScreen(plataformaSelecionada: plataformaSelecionada)),
                      );
                    },
                  ),
                  const SizedBox(width: 20),
                  PlatformButton(
                    imagePath: 'images/paramount+.png',
                    platform: 'Paramount+',
                    opacity: opacity,
                    onPressed: () {
                      setState(() {
                        plataformaSelecionada = 'Paramount+';
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => GeneroScreen(plataformaSelecionada: plataformaSelecionada)),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PlatformButton extends StatelessWidget {
  final String imagePath;
  final String platform;
  final double opacity;
  final VoidCallback onPressed; // Adicionado o parâmetro onPressed

  const PlatformButton({
    super.key,
    required this.imagePath,
    required this.platform,
    required this.opacity,
    required this.onPressed, // Adicionado o parâmetro onPressed
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: opacity,
      duration: const Duration(seconds: 1),
      child: InkWell(
        onTap: onPressed,
        child: Image.asset(
          imagePath,
          width: 96,
          height: 90,
        ),
      ),
    );
  }
}
