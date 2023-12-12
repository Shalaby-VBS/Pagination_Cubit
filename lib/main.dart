import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pagination_cubit/data/repositories/posts_repo.dart';
import 'package:pagination_cubit/logic/cubit/posts_cubit.dart';
import 'package:pagination_cubit/ui/posts_screen.dart';

import 'data/web_services/posts_web_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pagination Cubit',
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) =>
            PostsCubit(PostsRepo(postsWebService: PostsWebService())),
        child: PostsScreen(),
      ),
    );
  }
}
