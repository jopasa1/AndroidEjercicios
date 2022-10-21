import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:horari_interactiu/model.dart';

class SettingsPage extends StatefulWidget {
  final SettingsController _controller = SettingsController();

  SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Configuració"),
      ),
      body: getFormulari(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: () {
          if (_formKey.currentState != null &&
              _formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            widget._controller.save();
            Navigator.of(context).pushNamed("/horari/view");
          }
        },
      ),
    );
  }

  Widget getFormulari() {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(label: Text("Títol")),
              onSaved: (valor) => widget._controller.setTitle(valor ?? ""),
            ),
            TextFormField(
              decoration: const InputDecoration(
                label: Text("Nombre de sessions"),
              ),
              keyboardType: TextInputType.number,
              validator: (valor) {
                if (int.tryParse(valor ?? "") == null ||
                    int.parse(valor!) < 1) {
                  return "Número mayor que 0";
                }
              },
              onSaved: (valor) =>
                  widget._controller.setNSesiones(int.parse(valor!)),
            ),
            FormField<TimeOfDay>(
              builder: (formFieldState) {
                return TextButton(
                  onPressed: () async {
                    TimeOfDay? theTime = await showTimePicker(
                        initialTime: const TimeOfDay(hour: 21, minute: 20),
                        context: context);
                    if (theTime != null) {
                      formFieldState.didChange(theTime);
                    }
                  },
                  child: Text(
                      "Hora inici: ${formFieldState.value?.format(context) ?? "Tap to define"}"),
                );
              },
              onSaved: (valor) => widget._controller.setInitialTime(valor!),
              validator: (valor) => valor == null ? "Requerido" : null,
            ),
            TextFormField(
              decoration: const InputDecoration(
                label: Text("Duració sessió (minuts)"),
              ),
              keyboardType: TextInputType.number,
              validator: (valor) {
                if (int.tryParse(valor ?? "") == null ||
                    int.parse(valor!) < 1) {
                  return "Número mayor que 0";
                }
              },
              onSaved: (valor) =>
                  widget._controller.setDuracio(int.parse(valor!)),
            ),
          ],
        ));
  }
}

class SettingsController {
  String? _titulo;
  int? _nSesiones;
  TimeOfDay? _initTime;
  int? _duracioMinuts;

  void setTitle(String elTitulo) {
    _titulo = elTitulo;
  }

  void setNSesiones(int nSesiones) {
    _nSesiones = nSesiones;
  }

  void setInitialTime(TimeOfDay initTime) {
    _initTime = initTime;
  }

  void setDuracio(int minutos) {
    _duracioMinuts = minutos;
  }

  @override
  String toString() {
    return "$_titulo: ${_initTime?.hour ?? "null"}:${_initTime?.minute ?? "null"} - ${_duracioMinuts ?? "null"} minuts $_nSesiones sessions";
  }

  void save() {
    assert(
    _titulo!=null && _nSesiones!=null && _duracioMinuts!=null && _initTime!=null,
    "Cap paràmetre pot ser null quan es crida a aquesta funció"
    );
    HorariModel().setConfiguracion(
        titol: _titulo!,
        nSessions: _nSesiones!,
        duracioMinuts: _duracioMinuts!,
        horaInicial: _initTime!);
  }
}
