import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manektech/blocs/product.state.dart';
import 'package:manektech/models/product_model.dart';
import 'package:manektech/repositories/product.repo.dart';
import 'package:manektech/utils/const.dart';
import 'package:sqflite/sqlite_api.dart';

import '../services/api_call.dart';

class TodoBloc extends Cubit<TodoState> {
  final _todoRepo = ProductRepository();
  final Database database;
  TodoBloc({required this.database}) : super(const InitTodoState(0));

  int _counter = 1;
  List<Datum> _cart = [];
  List<Datum> get cart => _cart;
  List<Datum> _products = [];
  List<Datum> get products => _products;

  Future<void> getProducts() async {
    try {
      _products = await _todoRepo.getProducts(database: database);
      _cart = await _todoRepo.getCartProducts(database: database);
      if (_products.isEmpty) {
        addProducts();
      }
      emit(InitTodoState(_counter++));
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> addProducts() async {
    var apiCall = ApiCallNew(
      AppConstant.url,
    );
    var dataNew = await apiCall.hitApi();
    ProductModel productModel = ProductModel.fromJson(dataNew);
    for (var element in productModel.data!) {
      await _todoRepo.addProducts(
        database: database,
        slug: element.slug,
        createdat: element.createdAt,
        description: element.description,
        featuredimage: element.featuredImage,
        status: element.status,
        price: element.price,
        title: element.title,
      );
    }
    getProducts();
  }

  Future<void> addProductToCart(
      int id,
      String slug,
      String createdAt,
      String description,
      String featuredImage,
      int price,
      String status,
      String title) async {
    try {
      await _todoRepo.addProductToCart(
        database: database,
        slug: slug,
        createdat: createdAt,
        description: description,
        featuredimage: featuredImage,
        status: status,
        price: price,
        title: title,
      );
      getProducts();
      emit(InitTodoState(_counter++));
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> deleteProductToCart(
    int id,
  ) async {
    try {
      await _todoRepo.deleteProductToCart(
        database: database,
        id: id,
      );
      getProducts();
      emit(InitTodoState(_counter++));
    } catch (e) {
      log(e.toString());
    }
  }
}
