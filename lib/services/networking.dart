import 'package:http/http.dart'as http;
import 'dart:convert';
class NetworkHelper{
  NetworkHelper(this.url);
  String url;

  Future getData()async{
    try {
      http.Response response = await http.get(Uri.parse(url));
      if(response.statusCode==200) {
        String data = response.body;
        return jsonDecode(data);
      }}catch(e){
      print(e);
    }

}
}
