import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manektech/blocs/database.bloc.dart';
import 'package:manektech/blocs/database.state.dart';
import 'package:manektech/blocs/product.bloc.dart';
import 'package:manektech/blocs/product.state.dart';
import 'package:manektech/utils/mediaquery.dart';
import 'package:manektech/utils/snackbar.dart';

class Products extends StatefulWidget {
  const Products({Key? key}) : super(key: key);

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  void initState() {
    super.initState();
  }

  final Resize _resize = Resize();

  @override
  Widget build(BuildContext context) {
    _resize.setValue(
        context); //initalizing the mediaquery once in the app to reuse them over al the app
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text("Products"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/cart');
              },
              icon: const Icon(Icons.shopping_cart))
        ],
      ),
      body: BlocConsumer<DatabaseBloc, DatabaseState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is LoadDatabaseState) {
            return BlocConsumer<TodoBloc, TodoState>(
              listener: (context, todoState) {},
              builder: (context, todoState) {
                if (todoState is InitTodoState) {
                  final products = BlocProvider.of<TodoBloc>(context).products;
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    child: GridView.builder(
                      itemCount: products.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              crossAxisCount: 2),
                      itemBuilder: (contexts, index) {
                        return Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image.network(
                                products[index].featuredImage!,
                                width: _resize.width * 0.17,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        products[index].title!,
                                        style: TextStyle(
                                          fontSize: _resize.resposiveConst * 16,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          showSnackBarGreen(
                                              'Item has been Added', context);
                                          BlocProvider.of<TodoBloc>(context)
                                              .addProductToCart(
                                            products[index].id!,
                                            products[index].slug!,
                                            products[index].createdAt!,
                                            products[index].description!,
                                            products[index].featuredImage!,
                                            products[index].price!,
                                            products[index].status!,
                                            products[index].title!,
                                          );
                                        },
                                        child: const Icon(Icons.shopping_cart))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }

                return Container();
              },
            );
          }

          return const Center(
            child: Text('Database not loaded'),
          );
        },
      ),
    );
  }
}
