import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/cubit_state_managment/list_cubit.dart';
import 'package:to_do_app/screens/home_page.dart';

void main() {
  runApp(BlocProvider(create: (context) => ListCubit(),child: const MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDo App',
      home: MyHomePage(),
    );
  }
}
