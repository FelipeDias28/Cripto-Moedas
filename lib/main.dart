import 'package:aula_1/configs/app_settings.dart';
import 'package:aula_1/page/home_page.dart';
import 'package:aula_1/repositories/favoritas_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'configs/hive_config.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Essa instrução evita que o flutter dê erro por estar executando código antes do RunApp

  // Inicialização do Hive
  await HiveConfig.start();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppSettings()),
        ChangeNotifierProvider(create: (context) => FavoritasRepository()),
      ],
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
