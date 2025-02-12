import 'package:falldetectionapp/Pages/ubicationpage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const EventsPageMain();
  }
}

class EventsPageMain extends StatefulWidget{
  const EventsPageMain({super.key});
  
  @override
  State<EventsPageMain> createState() => EventsPageState();
}


class EventsPageState extends State<EventsPageMain>{
  bool isRegistered = false, isLoggedIn = false; 
  static const Color _colorForms = Colors.lightBlue;
  String? userName, userPassword;
  String latitud = "", longitud = "";

  TextEditingController userNameController = TextEditingController(); 
  TextEditingController userPasswordController = TextEditingController(); 
  
  DatabaseReference databaseReference = FirebaseDatabase.instance.ref().child('caidas');
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding( 
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            const TextField(
              decoration: InputDecoration(
                icon: Icon(Icons.search_outlined),
                labelText: 'Buscar...',
                hintText: 'Buscar...',
                iconColor: _colorForms,
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 20.0)),
            FirebaseAnimatedList(
              query: databaseReference,
              shrinkWrap: true,
              itemBuilder: (context, snapshot, animation, index) {
                Map contact = snapshot.value as Map;
                contact['key'] = snapshot.key;
                return GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Card(
                      child: ListTile(
                        onTap: () {
                          print(contact['nombre']);
                          const UbicationPage();
                        },
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete_outline, color: Colors.red[700]),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Eliminar Registo..."),
                                  content: const Text("¿Está realmente seguro?"),
                                  actions: [
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        textStyle: Theme.of(context).textTheme.labelLarge,
                                      ), 
                                      onPressed: () { Navigator.pop(context, false); }, 
                                      child: const Text("Cancelar")
                                    ),
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        textStyle: Theme.of(context).textTheme.labelLarge,
                                      ),
                                      onPressed: () { databaseReference.child(contact['key']).remove().then((value) => Navigator.pop(context, false)); }, 
                                      child: const Text("Ok")
                                    ),
                                  ]
                                );
                              },
                            );
                          },
                        ),
                        title: 
                        Text(
                          contact['nombre'],
                          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)
                        ),
                        subtitle: Text(
                          'Aceleración: ${contact['aceleracion']} m/s^2. \nUbicación: (Latitud: ${contact['latitud']}, Longitud: ${contact['longitud']}.)',
                          style: const TextStyle(fontSize: 14)
                        ),
                        isThreeLine: true
                      )
                    )
                  ),
                );
              }
            )
          ]
        )
      )
    );
  }
}
         