import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:horari_interactiu/model.dart';

class ClaseEditPage extends StatefulWidget {
  ClaseEditPage({Key? key, required this.claveClase})
      : _controller = ClaseEditController(claveClase),
        super(key: key);

  final ClauClasse claveClase;
  final ClaseEditController _controller;

  @override
  State<ClaseEditPage> createState() => _ClaseEditPageState();
}

class _ClaseEditPageState extends State<ClaseEditPage> {
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
            Navigator.of(context).pop();
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
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    initialValue: widget._controller.modulo,
                    decoration: const InputDecoration(label: Text("Codi")),
                    onSaved: (valor) => widget._controller.modulo = valor,
                    validator: (valor) {
                      if (valor == null || valor == "") {
                        return "Has de posar el codi delmòdul";
                      }
                    },
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: TextFormField(
                    initialValue: widget._controller.moduloDescripcion,
                    decoration: const InputDecoration(
                      label: Text("Nom mòdul"),
                    ),
                    onSaved: (valor) =>
                        widget._controller.moduloDescripcion = valor,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    initialValue: widget._controller.grupo,
                    decoration: const InputDecoration(label: Text("Grup")),
                    onSaved: (valor) => widget._controller.grupo = valor,
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    initialValue: widget._controller.aula,
                    decoration: const InputDecoration(
                      label: Text("Aula"),
                    ),
                    onSaved: (valor) => widget._controller.aula = valor,
                  ),
                ),
              ],
            ),
            TextFormField(
              initialValue: (widget._controller.minutos??60).toString(),
              decoration: const InputDecoration(
                label: Text("Duració (minuts)"),
              ),
              keyboardType: TextInputType.number,
              validator: (valor) {
                if (int.tryParse(valor ?? "") == null ||
                    int.parse(valor!) < 1) {
                  return "Número mayor que 0";
                }
              },
              onSaved: (valor) =>
                  widget._controller.minutos = int.parse(valor ?? "60"),
            ),
            FormField<Color>(
              initialValue: widget._controller.color,
              builder: (formFieldState) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: formFieldState.value),
                  onPressed: () async {
                    await showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              content: ColorPicker(
                                pickerColor:
                                    widget._controller.color ?? Colors.white,
                                onColorChanged: (Color value) =>
                                    formFieldState.didChange(value),
                              ),
                              actions: [
                                ElevatedButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: const Text("Fet"))
                              ],
                            ));
                    setState(() {});
                  },
                  child: Card(
                    color: formFieldState.value,
                  ),
                );
              },
              onSaved: (valor) => widget._controller.color = valor,
            ),
          ],
        ));
  }
}

class ClaseEditController {
  ClaseEditController(this.claveClase) : initTime = claveClase.horaInici {
    Classe? laClase = HorariModel().clases[claveClase];
    if (laClase != null) {
      minutos = laClase.minuts;
      grupo = laClase.grup;
      modulo = laClase.codiModul;
      moduloDescripcion = laClase.descripcioModul;
      aula = laClase.aula;
      color = laClase.color;
    }
  }

  final ClauClasse claveClase;
  final TimeOfDay initTime;
  int? minutos;
  String? grupo;
  String? modulo;
  String? moduloDescripcion;
  String? aula;
  Color? color;

  void save() {
    HorariModel().clases[claveClase] = Classe(
        horaInici: initTime,
        minuts: minutos ?? 60,
        grup: grupo ?? "",
        codiModul: modulo ?? "",
        descripcioModul: moduloDescripcion ?? "",
        aula: aula ?? "",
        color: color??Colors.white30);
  }
}
