import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference partidos =
      FirebaseFirestore.instance.collection('partidos');

  Stream<QuerySnapshot> getPartidos() {
    return partidos.snapshots();
  }

  void sumarVoto(String id, int votosActuales) {
    partidos.doc(id).update({
      'votos': votosActuales + 1,
    });
  }

  void restarVoto(String id, int votosActuales) {
    if (votosActuales > 0) {
      partidos.doc(id).update({
        'votos': votosActuales - 1,
      });
    }
  }
}
