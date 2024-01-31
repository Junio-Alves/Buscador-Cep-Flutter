class CepModel {
  final String cep;
  final String logradouro;
  final String complemento;
  final String bairro;
  final String localidade;
  final String uf;
  final String ibge;
  final String gia;
  final String ddd;
  final String siafi;

  CepModel({
    required this.cep,
    required this.logradouro,
    required this.complemento,
    required this.bairro,
    required this.localidade,
    required this.uf,
    required this.ibge,
    required this.gia,
    required this.ddd,
    required this.siafi,
  });

  factory CepModel.fromMap(Map<String, dynamic> map) {
    return CepModel(
        cep: map['cep'],
        logradouro: map['logradouro'],
        complemento: map['complemento'],
        bairro: map['bairro'],
        localidade: map['localidade'],
        uf: map['uf'],
        ibge: map['ibge'],
        gia: map['gia'],
        ddd: map['ddd'],
        siafi: map['siafi']);
  }
}
