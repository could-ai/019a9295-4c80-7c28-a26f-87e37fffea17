import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:couldai_user_app/providers/cart_provider.dart';
import 'package:couldai_user_app/screens/book_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => CartProvider(),
      child: MaterialApp(
        title: 'Bookstore',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: BookListScreen(),
      ),
    );
  }
}
