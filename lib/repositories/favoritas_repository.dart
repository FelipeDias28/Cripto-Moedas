import 'dart:collection';

import 'package:aula_1/models/moeda.dart';
import 'package:flutter/material.dart';

// ChangeNotifier => responsável por avisar o flutter que precisa redesenhar a tela.
class FavoritasRepository extends ChangeNotifier {
  final List<Moeda> _lista = [];

  UnmodifiableListView<Moeda> get lista => UnmodifiableListView(_lista);

  saveAll(List<Moeda> moedas) {
    for (var moeda in moedas) {
      if (!_lista.contains(moeda)) {
        _lista.add(moeda);
      }
    }
    // Notificar os listeners do flutter para renderizar a auteração na tela
    notifyListeners();
  }

  remove(Moeda moeda) {
    _lista.remove(moeda);
    notifyListeners();
  }
}
