import 'package:buybes/constants.dart';
import 'package:buybes/custom_widgets/custom_text_field.dart';
import 'package:buybes/models/product.dart';
import 'package:buybes/services/fire_store.dart';
import 'package:flutter/material.dart';

class EditProduct extends StatelessWidget {
  static String id = 'EditProduct';
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  String productName,
      productPrice,
      productDescription,
      productCategory,
      productLocation;
  final _fireStore = FireStore();
  final imageUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      backgroundColor: grey,
      body: Form(
        key: _globalKey,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CustomTextField(
                  initialValue: product.pName,
                  hint: 'Product Name',
                  onSaved: (value) {
                    productName = value;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  initialValue: product.pPrice,
                  hint: 'Product Price',
                  onSaved: (value) {
                    productPrice = value;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  initialValue: product.pDescription,
                  hint: 'Product Description',
                  onSaved: (value) {
                    productDescription = value;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  initialValue: product.pCategory,
                  hint: 'Product Category',
                  onSaved: (value) {
                    productCategory = value;
                  },
                ),
                SizedBox(
                  height: 10,
                ),
            TextField(
              keyboardType: TextInputType.text,
              onChanged: (String value) {
                productLocation = value;
              },
              controller: imageUrlController,
              style: TextStyle(fontSize: 19),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.blue[50],
                labelText: "Product Image URL",
                border: OutlineInputBorder(),
                ),
              ),
                SizedBox(
                  height: 25,
                ),
                RaisedButton(
                  onPressed: () {
                    if (_globalKey.currentState.validate()) {
                      _globalKey.currentState.save();
                      _fireStore.editProduct(product.pID, {
                        kProductName: productName,
                        kProductPrice: productPrice,
                        kProductDescription: productDescription,
                        kProductCategory: productCategory,
                        kProductLocation: productLocation,
                      });
                    }
                  },
                  child: Text('Edit Product'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
