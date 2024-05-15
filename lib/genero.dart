import 'dart:math';
import 'package:flutter/material.dart';
import 'filmeAleatorio.dart';
import 'menuHamburguer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'filmes/netflix.dart';
import 'filmes/amazonPrime.dart';
import 'filmes/appleTV.dart';
import 'filmes/disneyPlus.dart';
import 'filmes/globoPlay.dart';
import 'filmes/max.dart';
import 'filmes/paramountPlus.dart';
import 'filmes/starPlus.dart';
void main() {
  runApp(GeneroScreen(plataformaSelecionada: PlataformaSelecionada.plataforma));
}

class GeneroScreen extends StatelessWidget {
  final String plataformaSelecionada;

  const GeneroScreen({Key? key, required this.plataformaSelecionada}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PaginaInicial(plataformaSelecionada: plataformaSelecionada);
  }
}

class PaginaInicial extends StatefulWidget {
  final String plataformaSelecionada;

  const PaginaInicial({Key? key, required this.plataformaSelecionada}) : super(key: key);

  @override
  _PaginaInicialState createState() => _PaginaInicialState();
}

class _PaginaInicialState extends State<PaginaInicial> {
  List<String> filmesSelecionados = [];
  List<String> filmesDisponiveis = [];
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _loadFilmesDisponiveis();
    _initPrefs();
  }

  // Inicialize o SharedPreferences
  void _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    // Carregue a lista de filmes selecionados ao inicializar a página
    setState(() {
      filmesSelecionados = _prefs.getStringList('filmesSelecionados') ?? [];
    });
  }

  // Função para carregar os títulos dos filmes salvos no SharedPreferences
  void _loadFilmesDisponiveis() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? filmesSalvos = prefs.getStringList('filmes');
    if (filmesSalvos != null) {
      setState(() {
        filmesDisponiveis = filmesSalvos;
      });
    }
  }

  // Função para construir o botão de gênero
  Widget _buildButton(String label, String genero, BuildContext context) {
    return SizedBox(
      width: 116,
      height: 90,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0A151F),
              Color(0xFF0D3152),
            ],
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: ElevatedButton(
          onPressed: () {
            _selectRandomMovie(genero);
          },
          child: Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.bold,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent, // Define a cor de fundo do botão como transparente
            shadowColor: Colors.transparent, // Remove a sombra do botão
            padding: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
      ),
    );
  }

  // Função para selecionar um filme aleatório de um determinado gênero
  void _selectRandomMovie(String genero) {
    List<String>? listaFilmes = PlataformaSelecionada.plataformas[widget.plataformaSelecionada]?[genero];
    if (listaFilmes != null && listaFilmes.isNotEmpty) {
      listaFilmes = listaFilmes.where((filme) => !filmesDisponiveis.contains(filme) && !filmesSelecionados.contains(filme)).toList();
      if (listaFilmes.isNotEmpty) {
        String filmeSelecionado = listaFilmes[Random().nextInt(listaFilmes.length)];
        filmesSelecionados.add(filmeSelecionado);
        // Salve a lista de filmes selecionados
        _prefs.setStringList('filmesSelecionados', filmesSelecionados);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FilmeAleatorioScreen(
              nomeFilmeSelecionado: filmeSelecionado,
            ),
          ),
        );
      } else {
        // Exibe um diálogo informando que não há mais filmes disponíveis neste gênero e plataforma
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Todos os filmes assistidos'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('Você já assistiu todos os filmes deste gênero nesta plataforma.'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } else {
      print("Nenhum filme encontrado para esta categoria e plataforma");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 70.0),
              child: Text(
                'Que tipo de filme você deseja assistir?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                ),
              ),
            ),
            SizedBox(height: 20),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildButton('Ação', 'acao', context),
                    SizedBox(width: 20),
                    _buildButton('Comédia', 'comedia', context),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildButton('Aventura', 'aventura', context),
                    SizedBox(width: 20),
                    _buildButton('Ficção', 'ficcao', context),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildButton('Terror', 'terror', context),
                    SizedBox(width: 20),
                    _buildButton('Fantasia', 'fantasia', context),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildButton('Romance', 'romance', context),
                    SizedBox(width: 20),
                    _buildButton('Animação', 'animacao', context),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildButton('Drama', 'drama', context),
                    SizedBox(width: 20),
                    _buildButton('Clássicos', 'classicos', context),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PlataformaSelecionada {
  static String plataforma = '';
  static Map<String, Map<String, List<String>>> plataformas = {
    "Netflix": netflix,
    "Disney+": disneyPlus,
    "HBO Max": max,
    "Prime Video": amazonPrime,
    "Star+": starPlus,
    "Globoplay": globoPlay,
    "Apple TV+": appleTV,
    "Paramount+": paramountPlus,
  };
}