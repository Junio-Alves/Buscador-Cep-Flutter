import 'package:http/http.dart' as http;

//interface
abstract class IHttpclient {
  Future get({required String url});
}

class Httpclient implements IHttpclient {
  final client = http.Client();
  @override
  Future get({required String url}) {
    return client.get(Uri.parse(url));
  }
}
