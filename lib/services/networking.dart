import 'package:http/http.dart';
import 'package:weather/services/location.dart';
import 'package:flutter/foundation.dart';

class Networking{
  String appID = '6c5e8255e0d34ebf430bcc7d0ef32bb9';
  double temp = 0;
  String data = '', city = '';
  int id = 0;

  Future<String> getData() async{
    Location location =  new Location();
    await location.getLocation();
    double lat = location.lat;
    double lon = location.lon;

    Uri url = Uri.parse("https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$appID&units=metric");
    Response response = await get(url);
    data = response.body;

    if(response.statusCode == 200){
      return data;
    }else{
      return "Error";
    }
  }

  Future<String> getCity(String newcity) async {
    Uri url = Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=$newcity&appid=$appID&units=metric");
    Response response = await get(url);
    data = response.body;

    if (response.statusCode == 200) {
      return data;
    } else if (response.statusCode == 400) {
      throw ErrorDescription("No City");
    } else if (response.statusCode == 404) {
      throw ErrorDescription("Invalid City");
    } else {
      throw ErrorDescription("Error");
    }
  }
}