import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'menuHamburguer.dart';
import 'package:shared_preferences/shared_preferences.dart';



void main() {
  runApp(MaterialApp(
    home: FilmeAleatorioScreen(nomeFilmeSelecionado: 'Nome do Filme'),
  ));
}

class FilmeAleatorioScreen extends StatefulWidget {
  final String nomeFilmeSelecionado;

  const FilmeAleatorioScreen({Key? key, required this.nomeFilmeSelecionado}) : super(key: key);

  @override
  _FilmeDetalhesScreenState createState() => _FilmeDetalhesScreenState();
}

class _FilmeDetalhesScreenState extends State<FilmeAleatorioScreen> {
  late String sinopse = '';
  late String imagemURL = '';
  late String titulo = '';

  bool carregando = true;

  @override
  void initState() {
    super.initState();
    _delayedLoad(); // Chama a função para iniciar o carregamento
  }

  // Função para simular um atraso antes de carregar os dados
  void _delayedLoad() {
    Future.delayed(Duration(seconds: 2), () {
      obterSinopseTMDB(widget.nomeFilmeSelecionado);
    });
  }

  Future<void> obterSinopseTMDB(String nomeFilme) async {
    final apiKey = 'b0cc8d59f596c35018c3e36306a69044';
    final query = Uri.encodeComponent(nomeFilme);
    final language = 'pt-BR';

    final response = await http.get(Uri.parse('https://api.themoviedb.org/3/search/movie?api_key=$apiKey&query=$query&language=$language'));
    final data = json.decode(response.body);

    if (data['results'] != null && data['results'].isNotEmpty) {
      final resultado = data['results'][0];
      setState(() {
        sinopse = resultado['overview'];
        imagemURL = 'https://image.tmdb.org/t/p/w500/${resultado['poster_path']}';
        titulo = resultado['title'];
        carregando = false;
      });

      _saveFilmeLocalmente(titulo, sinopse, imagemURL); // Salva as informações do filme localmente
    } else {
      setState(() {
        sinopse = 'Sinopse não encontrada.';
        imagemURL = '';
        titulo = 'Título não encontrado.';
        carregando = false;
      });
    }
  }

  // Função para salvar as informações do filme localmente
  void _saveFilmeLocalmente(String titulo, String sinopse, String imagemURL) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> filmes = prefs.getStringList('filmes') ?? []; // Obtém a lista de filmes previamente salvos ou cria uma nova lista se não existir
    filmes.add(json.encode({'titulo': titulo,  'imagemURL': imagemURL})); // Adiciona o novo filme à lista
    prefs.setStringList('filmes', filmes); // Salva a lista atualizada no SharedPreferences
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
      drawer: MenuHamburguer(), // Adicione o menu de hambúrguer aqui
      body: carregando
          ? _buildLoadingScreen() // Exibe tela de carregamento se a variável 'carregando' for verdadeira
          : _buildContent(), // Exibe o conteúdo principal se a variável 'carregando' for falsa
    );
  }

  // Função para construir a tela de carregamento
Widget _buildLoadingScreen() {
  return Container(
    color: Color(0xFF060D17), // Define a cor de fundo como 0xFF060D17
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'images/escolhendo.gif', // Insira o caminho do seu GIF de carregamento
            width: 550, // Ajuste o tamanho conforme necessário
            height: 400,
          ),
          SizedBox(height: 20),
          Text(
            'Escolhendo o filme...', // Legenda abaixo do indicador de progresso
            style: TextStyle(fontSize: 16, color: Colors.white), // Define a cor do texto como branco
          ),
        ],
      ),
    ),
  );
}

  // Função para construir o conteúdo principal
  Widget _buildContent() {
    return Container(
      padding: EdgeInsets.all(16.0),
      alignment: Alignment.center,
      color: Color(0xFF060D17),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            titulo,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white), // Definindo a cor do texto como branca
          ),
          SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                 
                  Image.network(
                    imagemURL,
                    width: 200,
                    height: 300,
                    fit: BoxFit.cover,
                    
                  ),
                  SizedBox(height: 20),


                 Text(
                    'Sinopse:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white), // Definindo a cor do texto como branca
                  ),
                  SizedBox(height: 10),
                  Text(
                    sinopse,
                    style: TextStyle(fontSize: 14, color: Colors.white), // Definindo a cor do texto como branca
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 20),

                  Text(
                    'já assistiu?',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white), // Definindo a cor do texto como branca
                  ),
                  ElevatedButton(
                    
                    onPressed: () {
                      Navigator.pop(context); // Volta para a tela anterior
                    },
                    style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF8A1212), 
  ),
                    child: Text('Escolher Outro',
                     style: TextStyle(color: Colors.white)
                     ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
