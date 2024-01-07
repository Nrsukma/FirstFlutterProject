import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toko_pintar/bloc/logout_bloc.dart';
import 'package:toko_pintar/bloc/produk_bloc.dart';
import 'package:toko_pintar/model/produk.dart';
import 'package:toko_pintar/ui/login_page.dart';
import 'package:toko_pintar/ui/produk_detail.dart';
import 'package:toko_pintar/ui/produk_form.dart';

class ProdukPage extends StatefulWidget {
  @override
  _ProdukPageState createState() => _ProdukPageState();
}

class _ProdukPageState extends State<ProdukPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('List Item'),
        actions: [
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                child: Icon(Icons.add, size: 26.0),
                onTap: () async {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => ProdukForm()));
                },
              ))
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text('Logout'),
              trailing: Icon(Icons.logout),
              onTap: () async {
                await LogoutBloc.logout().then((value) {
                  Navigator.pushReplacement(context,
                      new MaterialPageRoute(builder: (context) => LoginPage()));
                });
              },
            )
          ],
        ),
      ),
      body: FutureBuilder<List>(
        future: ProdukBloc.getProduks(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ListProduk(
                  list: snapshot.data,
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class ListProduk extends StatelessWidget {
  final List list;
  ListProduk({this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list == null ? 0 : list.length,
        itemBuilder: (context, i) {
          return ItemProduk(
            produk: list[i],
          );
        });
  }
}

class ItemProduk extends StatelessWidget {
  final Produk produk;

  ItemProduk({this.produk});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (context) => ProdukDetail(
                        produk: produk,
                      )));
        },
        child: Card(
          child: ListTile(
            title: Text(produk.namaProduk),
            subtitle: Text(produk.hargaProduk.toString()),
            leading: CircleAvatar(),
            tileColor: Colors.amber,
            trailing: Text("New"),
          ),
        ),
      ),
    );
  }
}
