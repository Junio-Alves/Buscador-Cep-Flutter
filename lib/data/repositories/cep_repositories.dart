import 'dart:convert';
import 'package:buscador_cep/data/http/exception.dart';
import 'package:buscador_cep/data/http/http_client.dart';
import 'package:buscador_cep/data/models/cep_model.dart';

//interface
abstract class ICepRepository {
  Future<CepModel> getCep();
}

String? search;

class CepRepository implements ICepRepository {
  final IHttpclient client;

  CepRepository({required this.client});

  @override
  Future<CepModel> getCep() async {
    final response =
        await client.get(url: 'https://viacep.com.br/ws/$search/json/');

    if (response.statusCode == 200 && search != null) {
      final CepModel cep;
      final body = jsonDecode(response.body);
      cep = CepModel.fromMap(body);
      return cep;
    } else if (response.statusCode == 404) {
      throw NotFoundException("A url informada não é valida");
    } else {
      throw Exception("Não foi possivel localizar o cep!");
    }
  }
}
