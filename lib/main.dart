import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manektech/blocs/database.bloc.dart';
import 'package:manektech/blocs/product.bloc.dart';
import 'package:manektech/routes/routes.dart';
import 'package:manektech/view/products.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DatabaseBloc>(
            create: (context) => DatabaseBloc()..initDatabase()),
        BlocProvider<TodoBloc>(
            create: (context) =>
                TodoBloc(database: context.read<DatabaseBloc>().database!)
                  ..getProducts()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: const Products(),
        routes: routes,
      ),
    );
  }
}
