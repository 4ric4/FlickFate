import 'dart:async';
import 'package:flutter/material.dart';
import 'plataforma.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(), // Começa com a tela de SplashScreen
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool showSymbol = true;

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      setState(() {
        showSymbol = false; // Esconde o símbolo após 3 segundos
      });
      // Após 3 segundos, aguarde mais 1 segundo e, em seguida, navegue para a próxima página
      Timer(Duration(seconds: 1), () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PlataformaScreen()),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF060D17), 
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedOpacity(
              opacity: showSymbol ? 1.0 : 0.0, // Define a opacidade com base no estado showSymbol
              duration: Duration(seconds: 2), // Duração da animação
              child: Image.asset(
                'images/logo.png', // Caminho da imagem
                width: 200, // Largura da imagem
                height: 200, // Altura da imagem
              ),
            ),
          ],
        ),
      ),
    );
  }
}
