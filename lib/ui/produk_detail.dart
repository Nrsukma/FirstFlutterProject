import 'package:flutter/material.dart';
import 'package:toko_pintar/bloc/produk_bloc.dart';
import 'package:toko_pintar/model/produk.dart';
import 'package:toko_pintar/ui/produk_form.dart';
import 'package:toko_pintar/ui/produk_page.dart';
import 'package:toko_pintar/widget/warning_dialog.dart';

class ProdukDetail extends StatefulWidget {
  Produk produk;
  ProdukDetail({this.produk});
  @override
  _ProdukDetailState createState() => _ProdukDetailState();
}

class _ProdukDetailState extends State<ProdukDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Detail Item'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "Kode : ${widget.produk.kodeProduk}",
              style: TextStyle(fontSize: 20.0),
            ),
            Text(
              "Nama : ${widget.produk.namaProduk}",
              style: TextStyle(fontSize: 18.0),
            ),
            Text(
              "Harga : Rp. ${widget.produk.hargaProduk.toString()}",
              style: TextStyle(fontSize: 18.0),
            ),
            _tombolHapusEdit()
          ],
        ),
      ),
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        //Tombol Edit
        RaisedButton(
            child: Text("EDIT"),
            color: Colors.lightGreen,
            onPressed: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => ProdukForm(
                            produk: widget.produk,
                          )));
            }),
        //Tombol Hapus
        RaisedButton(
            child: Text("DELETE"),
            color: Colors.red,
            onPressed: () => confirmHapus()),
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = new AlertDialog(
      content: Text("Yakin ingin menghapus data ini?"),
      actions: [
        //tombol hapus
        RaisedButton(
          child: Text("Yes"),
          color: Colors.lightGreen,
          onPressed: () {
            ProdukBloc.deleteProduk(id: widget.produk.id).then((value) {
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => ProdukPage()));
            }, onError: (error) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => WarningDialog(
                        description: "Hapus data gagal, silahkan coba lagi",
                      ));
            });
          },
        ),
        //tombol batal
        RaisedButton(
          child: Text("Cancel"),
          color: Colors.red,
          onPressed: () => Navigator.pop(context),
        )
      ],
    );

    showDialog(context: context, builder: (_) => alertDialog);
  }
}
