import 'package:aula_1/configs/app_settings.dart';
import 'package:aula_1/models/moeda.dart';
import 'package:aula_1/page/moedas_detalhes_page.dart';
import 'package:aula_1/repositories/moeda_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../repositories/favoritas_repository.dart';

class MoedasPage extends StatefulWidget {
  const MoedasPage({Key? key}) : super(key: key);

  @override
  State<MoedasPage> createState() => _MoedasPageState();
}

class _MoedasPageState extends State<MoedasPage> {
  List<Moeda> selecionadas = [];
  final tabela = MoedaRepository.tabela;
  late FavoritasRepository favoritas;

  late NumberFormat real;
  late Map<String, String> loc;

  readNumberFormat() {
    loc = context.watch<AppSettings>().locale;
    real = NumberFormat.currency(locale: loc['locale'], name: loc['name']);
  }

  changeLanguageButton() {
    final locale = loc['locale'] == 'pt_BR' ? 'en_US' : 'pt_BR';
    final name = loc['locale'] == 'pt_BR' ? '\$' : 'R\$';

    return PopupMenuButton(
      icon: const Icon(Icons.language),
      itemBuilder: (context) => [
        PopupMenuItem(
          child: ListTile(
            leading: const Icon(Icons.swap_vert),
            title: Text('Usar $locale'),
            onTap: () {
              context.read<AppSettings>().setLocale(locale, name);
              Navigator.pop(context);
            },
          ),
        )
      ],
    );
  }

  appBarDinamica() {
    if (selecionadas.isEmpty) {
      return AppBar(
        title: const Text("Cripto Moedas"),
      );
    } else {
      return AppBar(
        title: Text(
          selecionadas.length > 1
              ? '${selecionadas.length} selecionadas'
              : '${selecionadas.length} selecionada',
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              selecionadas = [];
            });
          },
        ),
        backgroundColor: Colors.blueGrey[50],
        elevation: 1, // elimina a sombra da AppBar
        iconTheme: const IconThemeData(color: Colors.black87),
        titleTextStyle: const TextStyle(
          color: Colors.black87,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      );
    }
  }

  mostrarDetalhes(Moeda moeda) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MoedasDetalhesPage(moeda: moeda),
      ),
    );
  }

  limparSelecionadas() {
    setState(() {
      selecionadas = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    // favoritas = Provider.of<FavoritasRepository>(context);
    favoritas = context.watch<FavoritasRepository>();

    return Scaffold(
      appBar: appBarDinamica(),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
            ),
            leading: (selecionadas.contains(tabela[index]))
                ? const CircleAvatar(
                    child: Icon(Icons.check),
                  )
                : SizedBox(
                    child: Image.asset(tabela[index].icone),
                    width: 40,
                  ),
            title: Row(
              children: [
                Text(
                  tabela[index].nome,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (favoritas.lista.contains(tabela[index]))
                  const Icon(
                    Icons.circle,
                    color: Colors.amber,
                    size: 8,
                  )
              ],
            ),
            trailing: Text(
              real.format(tabela[index].preco),
            ),
            // Propriedades para quando ficar selecionado
            selected: selecionadas.contains(tabela[index]),
            selectedTileColor: Colors.indigo[50],
            onLongPress: () {
              setState(() {
                if (selecionadas.contains(tabela[index])) {
                  selecionadas.remove(tabela[index]);
                } else {
                  selecionadas.add(tabela[index]);
                }
              });
            },
            onTap: () => mostrarDetalhes(tabela[index]),
          );
        },
        padding: const EdgeInsets.all(16.0),
        separatorBuilder: (_, __) => const Divider(),
        itemCount: tabela.length,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: selecionadas.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: () {
                favoritas.saveAll(selecionadas);
                limparSelecionadas();
              },
              icon: const Icon(Icons.star),
              label: const Text(
                "FAVORITAR",
                style: TextStyle(
                  letterSpacing: 0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : null,
    );
  }
}
