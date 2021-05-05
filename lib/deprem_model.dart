import 'dart:convert';

List<DepremModel> depremModelFromJson(String str) => List<DepremModel>.from(
    json.decode(str).map((x) => DepremModel.fromJson(x)));

String depremModelToJson(List<DepremModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DepremModel {
  DepremModel({
    this.tarih,
    this.saat,
    this.enlem,
    this.boylam,
    this.derinlik,
    this.siddet,
    this.yer,
    this.tip,
  });

  String tarih;
  String saat;
  String enlem;
  String boylam;
  String derinlik;
  String siddet;
  String yer;
  String tip;

  factory DepremModel.fromJson(Map<String, dynamic> json) => DepremModel(
        tarih: json["tarih"],
        saat: json["saat"],
        enlem: json["enlem"],
        boylam: json["boylam"],
        derinlik: json["derinlik"],
        siddet: json["siddet"],
        yer: json["yer"],
        tip: json["tip"],
      );

  Map<String, dynamic> toJson() => {
        "tarih": tarih,
        "saat": saat,
        "enlem": enlem,
        "boylam": boylam,
        "derinlik": derinlik,
        "siddet": siddet,
        "yer": yer,
        "tip": tip,
      };
}
