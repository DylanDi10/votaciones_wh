import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:votaciones_app/services/firestore_services.dart';
import '../services/firestore_service.dart';

class VotacionesPage extends StatelessWidget {
  final FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('VOTACIONES'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreService.getPartidos(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView(
            children: snapshot.data!.docs.map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              final votos = data['votos'];
              final nombre = data['nombre'];

              return Card(
                margin: EdgeInsets.all(10),
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Icon(Icons.star_border, size: 50),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(nombre,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                            Text('Votos: $votos'),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_upward),
                            onPressed: () {
                              firestoreService.sumarVoto(doc.id, votos);
                            },
                          ),
                          Text(
                            votos.toString(),
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            icon: Icon(Icons.arrow_downward),
                            onPressed: () {
                              firestoreService.restarVoto(doc.id, votos);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
