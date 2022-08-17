import 'package:manektech/models/product_model.dart';
import 'package:sqflite/sqlite_api.dart';

class ProductRepository {
  Future<List<Datum>> getProducts({
    required Database database,
  }) async {
    final datas = await database.rawQuery('SELECT * FROM products');
    List<Datum> products = [];
    for (var item in datas) {
      products.add(Datum(
        slug: item['slug'] as String,
        description: item['description'] as String,
        title: item['title'] as String,
        createdAt: item['created_at'] as String,
        featuredImage: item['featured_image'] as String,
        id: item['id'] as int,
        price: item['price'] as int,
        status: item['status'] as String,
      ));
    }
    return products;
  }

  Future<List<Datum>> getCartProducts({
    required Database database,
  }) async {
    final datas = await database.rawQuery('SELECT * FROM cart');
    List<Datum> products = [];
    for (var item in datas) {
      products.add(Datum(
        slug: item['slug'] as String,
        description: item['description'] as String,
        title: item['title'] as String,
        createdAt: item['created_at'] as String,
        featuredImage: item['featured_image'] as String,
        id: item['id'] as int,
        price: item['price'] as int,
        status: item['status'] as String,
      ));
    }
    return products;
  }

  Future<dynamic> addProducts({
    required Database database,
    required String? slug,
    required String? title,
    required String? description,
    required int? price,
    required String? featuredimage,
    required String? status,
    required String? createdat,
  }) async {
    return await database.transaction((txn) async {
      await txn.rawInsert(
          "INSERT INTO products (slug ,title, description,price,featured_image, status, created_at) VALUES ('$slug','$title', '$description', '$price','$featuredimage', '$status', '$createdat')");
    });
  }

  Future<dynamic> addProductToCart({
    required Database database,
    required String? slug,
    required String? title,
    required String? description,
    required int? price,
    required String? featuredimage,
    required String? status,
    required String? createdat,
  }) async {
    return await database.transaction((txn) async {
      await txn.rawInsert(
          "INSERT INTO cart (slug ,title, description,price,featured_image, status, created_at) VALUES ('$slug','$title', '$description', '$price','$featuredimage', '$status', '$createdat')");
    });
  }

  Future<dynamic> deleteProductToCart({
    required Database database,
    required int? id,
  }) async {
    return await database.transaction((txn) async {
      await txn.rawDelete('DELETE FROM cart where id = $id');
    });
  }
}
