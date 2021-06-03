import 'dart:convert';
import 'package:http/http.dart' as http;

class OfficesList {
  List<Office> offices;
  OfficesList({this.offices});

  factory OfficesList.fromJson(json) {
    var officesJson = json as List;

    List<Office> officesList =
        officesJson.map((i) => Office.fromJson(i)).toList();

    return OfficesList(
      offices: officesList,
    );
  }
}

class Office {
  final String title;
  final String description;
  final int price;
  // final String amount;
  Office({this.description, this.price, this.title});

  factory Office.fromJson(Map<String, dynamic> json) {
    int priceint = json['price'].toInt();
    return Office(
      title: json['title'],
      description: json['description'],
      price: priceint,
    );
  }
}

Future<OfficesList> getOfficesList() async {
  // int priceINT = 5;
  // final Map<String, dynamic> activityData = {
  //   "title": "new",
  //   "description": "new",
  //   "price": "2"
  // };
  final http.Response response1 = await http.post(
      'https://spb-back.na4u.ru/api/v1/products',
      body: {"title": "new", "description": "new", "price": "2"});
  const url = 'https://spb-back.na4u.ru/api/v1/products';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    return OfficesList.fromJson(json.decode(response.body));
  } else {
    throw Exception('Error: ${response.reasonPhrase}');
  }
}
