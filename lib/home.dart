import 'package:flutter/material.dart';
import 'package:ssl_pin/ssl_pin.dart';
import 'deprem_model.dart';
import 'package:http/http.dart' as http;

List<DepremModel> deprems;
List<DepremModel> deprems1;

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final url = Uri.parse("https://deprem.odabas.xyz/api/pure_api.php");

  Future apiCall() async {
    await checkSSL(url.toString(), context).then(
      (value) async {
        if (value) {
          try {
            final response = await http.get(url);
            if (response.statusCode == 200) {
              var deprems = depremModelFromJson(response.body);
              setState(() {
                deprems1 = deprems;
              });
              return deprems1;
            } else {
              print("Bir hata oluştu:" + "${response.statusCode}");
            }
          } catch (e) {
            print(e.toString());
          }
        }
        print(value);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("SSL Sabitleme"),
        ),
        body: deprems1 != null
            ? CustomScrollView(
                slivers: <Widget>[depremList(deprems1)],
              )
            : Center(child: CircularProgressIndicator()));
  }

  Widget depremList(List<DepremModel> depremler) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Column(
              children: depremler.map((x) {
                    return _depremTile(x);
                  })?.toList() ??
                  [])
        ],
      ),
    );
  }

  Widget _depremTile(DepremModel model) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.all(0),
          leading: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(13)),
            child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.blue,
                )),
          ),
          title: Text(model.yer,
              style: TextStyle(fontSize: 13, color: Colors.black)),
          subtitle: Text(
            "Şiddet: " + model.siddet + " -  Saat: " + model.saat,
          ),
        ));
  }

  @override
  void initState() {
    super.initState();
    apiCall();
  }
}
