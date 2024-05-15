import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'menuHamburguer.dart';

void main() {
  runApp(HistoricoFilmesApp());
}

class HistoricoFilmesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HistoricoFilmesScreen(),
    );
  }
}

class HistoricoFilmesScreen extends StatefulWidget {
  @override
  _HistoricoFilmesScreenState createState() => _HistoricoFilmesScreenState();
}

class _HistoricoFilmesScreenState extends State<HistoricoFilmesScreen> {
  late List<Filme> historico = [];

  @override
  void initState() {
    super.initState();
    _loadHistorico(); // Carrega o histórico de filmes quando a tela é iniciada
  }

  // Função para carregar o histórico de filmes do SharedPreferences
  void _loadHistorico() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? filmes = prefs.getStringList('filmes');
    if (filmes != null) {
      setState(() {
        historico = filmes.map((filme) => Filme.fromJson(json.decode(filme))).toList();
      });
    }
  }

  // Função para limpar todos os dados do SharedPreferences
  void _limparHistorico() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Limpa todos os dados do SharedPreferences
    setState(() {
      historico = [];
    });
  }

  // Função para mostrar um diálogo de confirmação
  Future<void> _mostrarDialogoConfirmacao() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Limpar Histórico'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Tem certeza que deseja limpar todo o histórico de filmes?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Confirmar'),
              onPressed: () {
                _limparHistorico();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF060D17),
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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Histórico de Filmes',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(width: 10), // Adiciona um espaço entre o título e o ícone
            Container(
              padding: EdgeInsets.only(right: 10), // Adiciona um espaçamento à direita do ícone
              child: IconButton(
                icon: Icon(Icons.delete, color: Colors.white, size: 20), // Define o tamanho do ícone
                onPressed: _mostrarDialogoConfirmacao,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      drawer: MenuHamburguer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemCount: historico.length,
          itemBuilder: (context, index) {
            final filme = historico[index];
            return SizedBox(
              width: MediaQuery.of(context).size.width / 2, // Divide o espaço em duas colunas
              height: 300, // Ajuste o tamanho conforme necessário
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: 150, // Ajuste o tamanho da imagem conforme necessário
                    child: Image.network(
                      filme.imagemURL,
                      fit: BoxFit.contain, // Modificado para BoxFit.contain
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      filme.titulo,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 10),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class Filme {
  final String titulo;
  final String imagemURL;

  Filme({required this.titulo, required this.imagemURL});

  // Método factory para criar um objeto Filme a partir de um mapa
  factory Filme.fromJson(Map<String, dynamic> json) {
    return Filme(
      titulo: json['titulo'],
      imagemURL: json['imagemURL'],
    );
  }
}
