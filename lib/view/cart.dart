import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manektech/blocs/product.bloc.dart';
import 'package:manektech/blocs/product.state.dart';
import 'package:manektech/utils/mediaquery.dart';
import 'package:manektech/utils/snackbar.dart';

class CartItems extends StatefulWidget {
  const CartItems({
    Key? key,
  }) : super(key: key);

  @override
  State<CartItems> createState() => _CartItemsState();
}

class _CartItemsState extends State<CartItems> {
  @override
  void initState() {
    super.initState();
  }

  final Resize _resize = Resize();

  grandTotal(List products) {
    num? total = 0;
    for (var element in products) {
      total = total! + element.price;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    _resize.setValue(
        context); //initalizing the mediaquery once in the app to reuse them over al the app
    return BlocConsumer<TodoBloc, TodoState>(
      listener: (context, state) {},
      builder: (context, todoState) {
        if (todoState is InitTodoState) {
          final products = BlocProvider.of<TodoBloc>(context).cart;
          return Scaffold(
            backgroundColor: Colors.grey[300],
            appBar: AppBar(
              title: const Text("Shopping Cart"),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/cart');
                    },
                    icon: const Icon(Icons.shopping_cart))
              ],
            ),
            bottomNavigationBar: Container(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 20, bottom: 25),
                color: Colors.blue,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('Total Items : ${products.length.toString()}',
                        style:
                            const TextStyle(color: Colors.black, fontSize: 16)),
                    Text('Grand Total : ${grandTotal(products)}',
                        style:
                            const TextStyle(color: Colors.black, fontSize: 16)),
                  ],
                )),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: GridView.builder(
                itemCount: products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
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
                          padding: const EdgeInsets.symmetric(horizontal: 10),
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
                                    showSnackBarRed(
                                        'Item has been Removed', context);
                                    BlocProvider.of<TodoBloc>(context)
                                        .deleteProductToCart(
                                      products[index].id!,
                                    );
                                  },
                                  child: const Icon(Icons.delete))
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        }

        return Container();
      },
    );
  }
}
