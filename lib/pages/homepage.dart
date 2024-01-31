import 'package:buscador_cep/data/http/http_client.dart';
import 'package:buscador_cep/data/models/cep_model.dart';
import 'package:buscador_cep/data/repositories/cep_repositories.dart';
import 'package:buscador_cep/widgets/cep_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final _cep = TextEditingController();
  final CepRepository repository = CepRepository(client: Httpclient());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.maps_home_work_outlined,
              color: Colors.white,
              size: 40,
            ),
            Text(
              "Buscador de cep",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 25,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.lightGreen,
      ),
      backgroundColor: Colors.lightGreen,
      body: Column(
        children: [
          const SizedBox(
            height: 200,
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Form(
                            key: _formKey,
                            child: TextFormField(
                              controller: _cep,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Informe um cep";
                                }
                                return null;
                              },
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: "CEP:",
                                labelStyle: const TextStyle(fontSize: 20),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                      color: Colors.green, width: 2.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                      color: Colors.green, width: 2.0),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          FutureBuilder(
                              future: repository.getCep(),
                              builder: (context, snapshot) {
                                if (search == null || _cep.text.isEmpty) {
                                  return const Text("");
                                } else if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Expanded(
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CircularProgressIndicator.adaptive(),
                                          Text("Carregando!"),
                                        ],
                                      ),
                                    ),
                                  );
                                  //
                                } else if (snapshot.hasError) {
                                  return Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Erro ao procurar Cep! ${snapshot.error} ",
                                          style: const TextStyle(
                                              color: Colors.red, fontSize: 20),
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  CepModel cep = snapshot.data!;
                                  return CepWidget(
                                    cep: cep,
                                  );
                                }
                              })
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: SizedBox(
                      height: 40,
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (_formKey.currentState!.validate()) {
                              search = _cep.text;
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightGreen),
                        child: const Text(
                          "Buscar",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
