import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettings extends ChangeNotifier {
  late SharedPreferences _prefes;

  Map<String, String> locale = {
    'locale': 'pt_BR', // O padrão
    "name": 'R\$', // o que será mostrado na tela
  };

  AppSettings() {
    // O construtor não pode ser asincrono, por isso o método dentro
    _startSettings();
  }

  _startSettings() async {
    await _startPreferences();
    await _readLocale();
  }

  Future<void> _startPreferences() async {
    _prefes = await SharedPreferences
        .getInstance(); // Inicializa o sistema de arquivos
  }

  _readLocale() {
    // Nós podemos ler as preferencias e notifar os listeners
    final local = _prefes.getString('local') ?? 'pt_BR';
    final name = _prefes.getString('name') ?? 'R\$';

    locale = {
      'locale': local,
      'name': name,
    };

    notifyListeners();
  }

  // Esse método permite que o usuário possa alterar o Locale
  setLocale(String local, String name) async {
    await _prefes.setString('local', local);
    await _prefes.setString('name', name);
    await _readLocale();
  }
}
