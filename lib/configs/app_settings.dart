import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AppSettings extends ChangeNotifier {
  // late SharedPreferences _prefes;

  late Box box;

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
    // _prefes = await SharedPreferences
    //     .getInstance(); // Inicializa o sistema de arquivos

    box = await Hive.openBox('preferencias');
  }

  _readLocale() {
    // utilizando SHARED_PREFERENCES
    // final local = _prefes.getString('local') ?? 'pt_BR';
    // final name = _prefes.getString('name') ?? 'R\$';

    //utilizando HIVE
    final local = box.get('local') ?? 'pt_BR';
    final name = box.get('name') ?? 'R\$';

    locale = {
      'locale': local,
      'name': name,
    };

    notifyListeners();
  }

  // Esse método permite que o usuário possa alterar o Locale
  setLocale(String local, String name) async {
    // utilizando SHARED_PREFERENCES
    // await _prefes.setString('local', local);
    // await _prefes.setString('name', name);

    //utilizando HIVE
    await box.put('local', local);
    await box.put('name', name);

    await _readLocale();
  }
}
