import 'package:buscador_cep/data/models/cep_model.dart';
import 'package:flutter/material.dart';

class CepWidget extends StatelessWidget {
  final CepModel cep;
  const CepWidget({super.key, required this.cep});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(30)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _text("CEP: ${cep.cep}", 24, Colors.green),
              ],
            ),
          ),
          _text("Logradouro:${cep.logradouro}", 17, Colors.black),
          _text("Bairro:${cep.bairro}", 17, Colors.black),
          _text("Localidade:${cep.localidade}", 17, Colors.black),
          _text("UF:${cep.uf}", 17, Colors.black),
          _text("DDD:${cep.ddd}", 17, Colors.black),
        ],
      ),
    );
  }

  Widget _text(String text, double fontsize, Color color) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: fontsize,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
