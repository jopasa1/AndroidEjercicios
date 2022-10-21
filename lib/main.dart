import 'package:flutter/material.dart';
import 'package:horari_interactiu/model.dart';

import 'classe_edicio.dart';
import 'configuracio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => SettingsPage(),
        '/settings': (context) => SettingsPage(),
        '/horari/view': (context) => Horari(),
      },
      onGenerateRoute: (routeSettings) {
        switch(routeSettings.name) {
         case '/clase/edit':
           ClauClasse clave=ClauClasse(diaSetmana: (routeSettings.arguments as Map)["dia"]!, horaInici: (routeSettings.arguments as Map)["hora"]!);
           return MaterialPageRoute(builder: (context)=>ClaseEditPage(claveClase: clave));
        }
      },
    );
  }
}

class Horari extends StatefulWidget {
  final HorariController _controller = HorariController();

  Horari({
    super.key,
  });

  @override
  State<Horari> createState() => _HorariState();
}

class _HorariState extends State<Horari> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Horari de classe"),
      ),
      body: Theme(
        data: Theme.of(context).copyWith(
            textTheme: const TextTheme(
              titleMedium: TextStyle(
                  fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black),
              bodyMedium: TextStyle(fontSize: 10),
            )),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                const Text(""),
                for (TimeOfDay laHora in widget._controller.horesClasse)
                  Expanded(child: Text(laHora.format(context)))
              ],
            ),
            for (DiasSemana elDia in DiasSemana.values)
              Expanded(
                child: Column(
                  children: [
                    Text(elDia.name),
                    for (TimeOfDay laHora in widget._controller.horesClasse)
                      Expanded(
                        child: GestureDetector(
                            onTap: () async {
                              await Navigator.pushNamed(context, "/clase/edit",
                                  arguments: {"dia": elDia, "hora": laHora});
                              setState(() {});
                            },
                            child: getClase(elDia, laHora)),
                      )
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }

  Widget getClase(DiasSemana dia, TimeOfDay hora) {
    Classe? laClase = widget._controller.getClase(dia, hora);
    Widget resultado = const Card(
      color: Colors.greenAccent,
      child: ListTile(
        title: Text("Prem per definir"),
      ),
    );
    if (laClase != null) {
      resultado = Card(
        color: laClase.color,
        child: ListTile(
          title: Text("${laClase.codiModul} - ${laClase.descripcioModul}"),
          subtitle: Text("${laClase.grup} ${laClase.aula}"),
        ),
      );
    }
    return resultado;
  }
}


class HorariController {
  final List<TimeOfDay> horesClasse = [
    for (int i = 0; i < (HorariModel().nSessions); i++)
      TimeOfDay(
        hour: HorariModel().horaInicial.hour +
            ((i * (HorariModel().duracioMinuts)) / 60).floor(),
        minute: HorariModel().horaInicial.minute +
            (i * (HorariModel().duracioMinuts)) % 60,
      )
  ];

  Classe? getClase(DiasSemana dia, TimeOfDay hora) {
    return HorariModel().clases[ClauClasse(diaSetmana: dia, horaInici: hora)];
  }
}
