import 'package:flutter/material.dart';
import 'package:hesap_makinesi/renkler.dart';
import 'package:math_expressions/math_expressions.dart';

class Anasayfa extends StatefulWidget {
  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  String girilenDeger = "";
  String sonuc = "0";

  List<String> butonListesi = [
    "7",
    "8",
    "9",
    "AC",
    "4",
    "5",
    "6",
    "C",
    "1",
    "2",
    "3",
    "+",
    "0",
    ".",
    "-",
    "=",
  ];

  @override
  Widget build(BuildContext context) {
    var ekranBilgisi = MediaQuery.of(context).size;
    double ekranGenisligi = ekranBilgisi.width;
    double ekranYuksekligi = ekranBilgisi.height;
    print("Ekran genişliği : $ekranGenisligi");
    print("Ekran yüksekliği : $ekranYuksekligi");
    return Scaffold(
      backgroundColor: Colors.white54.withOpacity(0.85), //soft bi gri değeri
      appBar: AppBar(
        title: const Text(
          "Hesap Makinesi",
          style: TextStyle(
              fontSize: 24, fontFamily: "Saira", fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        backgroundColor: anatema,
      ),
      body: SafeArea(
        top: true,
        left: true,
        right: true,
        bottom: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 4.5,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        right: ekranGenisligi / 40,
                        left: ekranGenisligi / 40),
                    child: SafeArea(
                      child: Container(
                        height: 80,
                        alignment: Alignment.bottomRight, // sayı girildikçe sığsın diye otomatik küçültme işlemi için FittedBox ile sarmaladık. !!
                          child: FittedBox(
                            fit: BoxFit.fill,
                            child: Text(
                              girilenDeger,
                              style: TextStyle(
                                fontSize: 28,
                                fontFamily: "Saira",
                                color: anatema,
                                shadows: [
                                  BoxShadow(
                                      color: Colors.grey.shade800.withOpacity(0.9),
                                      blurRadius: 2,
                                      offset: Offset(0.5, 0.8))
                                ],
                              ),
                            ),
                          ),

                      ),
                    ),
                  ),
                  Expanded(
                      child: Container(
                        padding: EdgeInsets.only(
                            right: ekranGenisligi / 40,
                            left: ekranGenisligi / 40),
                        alignment: Alignment.bottomRight,
                        height: MediaQuery.of(context).size.height / 9,
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: Text(
                            sonuc,
                            style: TextStyle(
                              fontSize: 46,
                              fontFamily: "Saira",
                              color: anatema,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                BoxShadow(
                                    color: Colors.grey.shade800.withOpacity(0.9),
                                    blurRadius: 4,
                                    offset: Offset(0.5, 1))
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          Divider(
                  color: anatema.withOpacity(0.6),
                  thickness: 2,
                  indent: 3,
                  endIndent: 3),
            // Düz çizgi çektik.
            //indent : soldan padding gibi , endIndent : sağdan padding gibi, thickness kalınlık,
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 1.7,
                    width: MediaQuery.of(context).size.width,
                    //padding: EdgeInsets.only(top: ekranGenisligi / 40,left: ekranGenisligi / 13,right : ekranGenisligi / 13), // tuşların ekranda ki padding ayarı
                    child: GridView.builder(
                      itemCount: butonListesi.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        //bir satırda kaç tuş olacağını belirledik.
                        crossAxisSpacing: 19,
                        // kutucukların boyutu
                        mainAxisSpacing: 20, // kutucuklar arası dikey boşluk
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return OzelButon(butonListesi[
                            index]); //index numarasına göre butonları yerleştirecek. Listview.builder mantığı gibi.
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget OzelButon(String tiklananDeger) {
    return InkWell(
      //InkWell ile tıklanma özelliği kazandırıyoruz.
      splashColor: Colors.white.withOpacity(0.2),
      //tıklandığında ki rengini belirledik.
      onTap: () {
        setState(() {
          basilanButon(tiklananDeger);
        });
      },
      child: Ink(
        decoration: BoxDecoration(
          color: bgColorgetir(tiklananDeger),
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              //sayı kutucuklarının rengi,, diğerleri aşağıda şartlı renk alacak.
              blurRadius: 2,
              //bulanıklık seviyesi
              spreadRadius: 0.6,
              offset: Offset(
                  -1, 1), //yatay eksen(-sola,+sağa)dikey eksen(-yukarı,+aşağı)
            ),
          ],
        ),
        child: Center(
          child: Text(
            tiklananDeger,
            style: TextStyle(
                color: Colors.white,
                fontSize: 42,
                shadows: [
                  Shadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 10,
                      offset: Offset(-0.5, 0))
                ],
                //gölgelendirme rengi, bulanıklık seviyesi, kordinatları
                fontWeight: FontWeight.w900,
                fontFamily: "Saira"),
          ),
        ),
      ),
    );
  }

  /*Colorgetir(String tiklananDeger){                                                         // ÖZEL BUTON YAZI RENGİ VEREBİLİRİZ.
    if (tiklananDeger == "AC" || tiklananDeger == "C" || tiklananDeger == "="){
      return Colors.white;
    }
    return Colors.white;
  }*/

  bgColorgetir(String tiklananDeger) {
    //BUTON ARKAPLAN RENGİ
    if (tiklananDeger == "AC" || tiklananDeger == "C") {
      return Color.fromARGB(255, 200, 100, 25);
    }
    if (tiklananDeger == "+" || tiklananDeger == "-") {
      return Color.fromARGB(255, 84, 129, 37);
    }
    if (tiklananDeger == "=") {
      return Color.fromARGB(215, 178, 167, 197);
    }
    if (tiklananDeger == "/") {
      return Color.fromARGB(145, 255, 87, 68);
    }

    return Colors.black38;
  }

  basilanButon(String tiklananDeger) {
    if (tiklananDeger == "AC") {
      // Sıfırlama
      girilenDeger = "";
      sonuc = "0";
      return;
    }

    if (tiklananDeger == "C") {
      if (girilenDeger.isNotEmpty) {
        //girilenDeger boş değilse girilen değerin uzunluğundan her basmada bir düşür.
        girilenDeger = girilenDeger.substring(0, girilenDeger.length - 1);
        return;
      } else {
        return null;
      }
    }

    if (tiklananDeger == "=") {
      sonuc = hesapla();
      if (hesapla() == "hata") {
        //hesapla metodundan sonra hata var ise girilenDeger textini değiştirip uyarı verdiyorum.
        girilenDeger = "Lütfen AC ile devam edin";
      }
      if (sonuc.endsWith(".0")) {
        // sonu .0 olan sayıların .xx larını sildirdik.
        sonuc = sonuc.replaceAll(".0", "");
        if (sonuc.length > 14) {
          //girilenDeger = ""; //sonuc 14 karakterden büyükse yukarıda ki girilenDeger yazısını kaldırıyoruz ki hata almayalım, taşma hatası yaşanmasın diye.
          sonuc = sonuc.substring(0, 14);
          //sonuc gösterilen karakter sayısını kısıtladık substring ile.
        }
        return;
      }
    }

    girilenDeger = girilenDeger +
        tiklananDeger; //tıklandıkça tıkladığımız değer girilenDegere ekleniyor ve ekranda da gösteriliyor
  }

  String hesapla() {
    try {
      var exp = Parser().parse(girilenDeger);
      var evaluation = exp.evaluate(EvaluationType.REAL,
          ContextModel()); //Matematik fonksiyonları kütüphanesi sayesinde
      return evaluation
          .toString(); // hesaplamaları algılayan bir paket kullandık.
    } catch (e) {
      return "hata";
    }
  }
}
