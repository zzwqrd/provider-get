import 'package:flutter/material.dart';
import 'package:mvvm_provider_practice/helper/btn.dart';
import 'package:mvvm_provider_practice/view/add_product.dart';
import 'package:mvvm_provider_practice/view_model/prodact_model.dart';
import 'package:provider/provider.dart';

class Product extends StatefulWidget {
  Product({Key? key}) : super(key: key);

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  late ProductListViewModel _productListViewModel;
  @override
  void initState() {
    _productListViewModel = Provider.of<ProductListViewModel>(context, listen: false);
    _productListViewModel.getData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProductListViewModel>(
      lazy: true,
      create: (BuildContext context) => _productListViewModel,
      child: Consumer<ProductListViewModel>(
        builder: (context, postListViewModel, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Product"),
            ),
            body: postListViewModel.list.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: postListViewModel.list.length,
                    itemBuilder: (context, i) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Image.network(
                              postListViewModel.list[i].image,
                              width: 120,
                              height: 100,
                              fit: BoxFit.fill,
                            ),
                            Text("${postListViewModel.list[i].name}"),
                          ],
                        ),
                      );
                    },
                  ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Btn(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddProducts()));
              },
              txt: 'Add Products',
            ),
          );
        },
      ),
    );
  }
}
