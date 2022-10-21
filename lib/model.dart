import 'package:flutter/material.dart';

class Classe {
  final TimeOfDay horaInici;
  final int minuts;
  final String grup;
  final String codiModul;
  final String descripcioModul;
  final String aula;
  final Color color;

  const Classe(
      {required this.horaInici,
      required this.minuts,
      required this.grup,
      required this.codiModul,
      required this.descripcioModul,
      required this.aula,
      this.color = Colors.black26});
}

enum DiasSemana { dl, dt, dc, dj, dv }

class ClauClasse {
  final DiasSemana diaSetmana;
  final TimeOfDay horaInici;

  const ClauClasse({required this.diaSetmana, required this.horaInici});

  @override
  bool operator ==(Object other) {

    return (other is ClauClasse) &&
        (diaSetmana == other.diaSetmana) &&
        (horaInici.hour == other.horaInici.hour) &&
        (horaInici.minute == other.horaInici.minute);
  }

  @override
  int get hashCode => diaSetmana.index*10+horaInici.hour*100+horaInici.minute;

}

class HorariModel {
  static final HorariModel _modelo = HorariModel._internal();

  factory HorariModel() {
    return _modelo;
  }

  HorariModel._internal()
      : _titol = "",
        _nSessions = 6,
        _horaInicial = const TimeOfDay(hour: 15, minute: 0),
        _duracioMinuts = 60;

  String _titol;
  int _nSessions;
  TimeOfDay _horaInicial;
  int _duracioMinuts;

  String get titol => _titol;

  int get nSessions => _nSessions;

  TimeOfDay get horaInicial => _horaInicial;

  int get duracioMinuts => _duracioMinuts;

  final Map<ClauClasse, Classe> clases = <ClauClasse, Classe>{};

  void setConfiguracion(
      {required String titol,
      required int nSessions,
      required TimeOfDay horaInicial,
      required int duracioMinuts}) {
    _titol = titol;
    _nSessions = nSessions;
    _duracioMinuts = duracioMinuts;
    _horaInicial = horaInicial;
  }
}
