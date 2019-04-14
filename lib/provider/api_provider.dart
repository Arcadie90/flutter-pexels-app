


import 'package:pexels_app/model/pexels.dart';

class ApiProvider {

  static const BASE_URL = "https://api.pexels.com/v1";

  static Map<String, String> headers = {
    "Authorization" : "563492ad6f9170000100000175d19398752b44cba1b64fe4b8fe1fd3"
  };

  Pexels pexel;

  static String url (String query, int page, int perPage) {
    return "$BASE_URL/search?query=$query+query&per_page=$perPage&page=$page";
  }

  

}