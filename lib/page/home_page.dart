import 'package:aula_1/page/moedas_page.dart';
import 'package:flutter/material.dart';

import 'favoritas_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int paginaAtual = 0;
  late PageController pc = PageController();

  @override
  void initState() {
    super.initState();

    pc = PageController(initialPage: paginaAtual);
  }

  setPaginaAtual(pagina) {
    setState(() {
      paginaAtual = pagina;
    });
  }

  @override
  Widget build(BuildContext context) {
    //PageView permite fazer a navegação por slider
    return Scaffold(
      body: PageView(
        controller: pc,
        children: const [
          MoedasPage(),
          FavoritasPage(),
        ],
        //Para que ocorra a seleção de página de forma dinâmica
        onPageChanged: setPaginaAtual,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: paginaAtual,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Todas"),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favoritas"),
        ],
        // Ao clicar nos ícones de baixo altera a tela que esta sendo mostrada
        onTap: (indicePagina) {
          pc.animateToPage(
            indicePagina,
            duration: const Duration(milliseconds: 400),
            curve: Curves.ease,
          );
        },
        backgroundColor: Colors.grey[200],
      ),
    );
  }
}
