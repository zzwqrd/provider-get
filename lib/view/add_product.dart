import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvvm_provider_practice/helper/btn.dart';
import 'package:mvvm_provider_practice/helper/image_picer.dart';
import 'package:mvvm_provider_practice/helper/text_form.dart';
import 'package:mvvm_provider_practice/repository/add_prodact_controler.dart';
import 'package:mvvm_provider_practice/view/product.dart';
import 'package:mvvm_provider_practice/view_model/add_pr_model.dart';
import 'package:provider/provider.dart';

class AddProducts extends StatefulWidget {
  @override
  State<AddProducts> createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ApiAddProducts apiAddProducts = ApiAddProducts();
  //
  late AddProductListViewModel _addProductListViewModel;
  //[][][][][][]
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  dynamic image;
  //[][][][][][]
  PickedFile? _pickedFile;
  final _picker = ImagePicker();
  Future<void> _pickImage({ImageSource? source}) async {
    _pickedFile = await _picker.getImage(source: source!);
    // _pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (_pickedFile != null) {
      setState(() {
        image = File(_pickedFile!.path);
        print('No image selected.');
      });
    }
  }

  @override
  void initState() {
    nameController = TextEditingController();
    descriptionController = TextEditingController();
    priceController = TextEditingController();
    discountController = TextEditingController();
    // _addProductListViewModel = Provider.of<AddProductListViewModel>(context, listen: false);
    // _addProductListViewModel.getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AddProductListViewModel addProductListViewModel = Provider.of<AddProductListViewModel>(context);
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Center(
                child: InkWell(
                  onTap: () {
                    openImagePicker(
                        context: context,
                        onCameraTapped: () {
                          _pickImage(
                            source: ImageSource.camera,
                          );
                        },
                        onGalleryTapped: () {
                          _pickImage(
                            source: ImageSource.gallery,
                          );
                          print("***************${image}*******************");
                        });
                  },
                  child: Container(
                    width: 88,
                    height: 88,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: image != null
                              ? Image.file(
                                  File(image!.path),
                                  height: 150,
                                  width: 150,
                                  fit: BoxFit.fill,
                                )
                              : Image.network(
                                  'https://elreviewz.com/wp-content/uploads/2021/04/beesline-products-review.jpg',
                                  fit: BoxFit.fill,
                                  width: double.infinity,
                                  height: double.infinity,
                                ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: const Color.fromARGB(100, 0, 0, 0),
                          ),
                          child: Icon(
                            Icons.camera,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TxtField(
                controller: nameController,
                validator: (String? val) {
                  if (val!.isEmpty)
                    return 'Product Name';
                  else {
                    return null;
                  }
                },
                onSaved: (o) {
                  nameController.text = o;
                },
                hintText: 'Product Name',
                enabled: true,
                obscureText: false,
                textInputType: TextInputType.text,
              ),
              const SizedBox(
                height: 15,
              ),
              TxtField(
                controller: descriptionController,
                validator: (String? val) {
                  if (val!.isEmpty)
                    return 'descriptionController';
                  else {
                    return null;
                  }
                },
                onSaved: (o) {
                  descriptionController.text = o;
                },
                hintText: 'descriptionController',
                enabled: true,
                obscureText: false,
                textInputType: TextInputType.text,
              ),
              const SizedBox(
                height: 15,
              ),
              TxtField(
                controller: priceController,
                validator: (String? val) {
                  if (val!.isEmpty)
                    return 'priceController';
                  else {
                    return null;
                  }
                },
                onSaved: (o) {
                  priceController.text = o;
                },
                hintText: 'priceController',
                enabled: true,
                obscureText: false,
                textInputType: TextInputType.number,
              ),
              const SizedBox(
                height: 15,
              ),
              TxtField(
                controller: discountController,
                validator: (String? val) {
                  if (val!.isEmpty)
                    return 'discountController';
                  else {
                    return null;
                  }
                },
                onSaved: (o) {
                  discountController.text = o;
                },
                hintText: 'discountController',
                enabled: true,
                obscureText: false,
                textInputType: TextInputType.number,
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: addProductListViewModel.status == Status.AddStart
          ? const Center(
              child: CupertinoActivityIndicator(
                animating: true,
                radius: 15,
              ),
            )
          : Btn(
              onTap: () {
                setState(() {
                  if (image == null) {
                    print(".........image...image...image..................");
                  } else {
                    if (!formKey.currentState!.validate()) {
                      print(".........validate...validate...validate..................");
                      return;
                    } else {
                      formKey.currentState!.save();
                      _addProductListViewModel = Provider.of<AddProductListViewModel>(context, listen: false);
                      _addProductListViewModel.getData(
                        image: image,
                        nameController: nameController,
                        descriptionController: descriptionController,
                        discountController: discountController,
                        priceController: priceController,
                      );
                      print(".........getData...getData...getData..................");
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => Product()),
                        (Route<dynamic> route) => false,
                      );
                    }
                  }
                });
              },
              txt: 'Add Products',
            ),
    );
  }
}
