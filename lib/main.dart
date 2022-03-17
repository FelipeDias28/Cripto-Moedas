import 'package:aula_1/page/home_page.dart';
import 'package:aula_1/repositories/favoritas_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => FavoritasRepository(),
      child: const MeuAplicativo(),
    ),
  );
}

class MeuAplicativo extends StatelessWidget {
  const MeuAplicativo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Moedas Base",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo, // Muda o tema do aplicativo.
      ),
      home: const HomePage(),
    );
  }
}
