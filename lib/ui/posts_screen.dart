import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/post.dart';
import '../logic/cubit/posts_cubit.dart';

class PostsScreen extends StatelessWidget {
  PostsScreen({super.key});

  final scrollController = ScrollController();

  void setupScrollController(context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          BlocProvider.of<PostsCubit>(context).loadPosts();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);
    BlocProvider.of<PostsCubit>(context).loadPosts();

    return Scaffold(
      appBar: AppBar(title: const Text("Pagination Cubit")),
      body: RefreshIndicator(
        onRefresh: () async {
          BlocProvider.of<PostsCubit>(context).loadPosts();
          debugPrint(BlocProvider.of<PostsCubit>(context).posts.toString());
        },
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<PostsCubit, PostsState>(
      builder: (context, state) {
        // MARK: - Variables.
        List<Post> posts = [];
        bool isLoading = false;
        // MARK: - States.
        if (state is PostsLoading && state.isRefresh) {
          return _loadingIndicator();
        }
        if (state is PostsLoading) {
          posts = state.oldPosts;
          isLoading = true;
        } else if (state is PostsLoaded) {
          posts = state.posts;
        }
        // MARK: - Static UI.
        return ListView.separated(
          controller: scrollController,
          itemCount: posts.length + (isLoading ? 1 : 0),
          itemBuilder: (context, index) {
            if (index < posts.length) {
              return _postWidget(posts[index], context);
            } else {
              // MARK: - Timer is used to avoid the error.
              Timer(const Duration(milliseconds: 30), () {
                scrollController
                    .jumpTo(scrollController.position.maxScrollExtent);
              });
              return _loadingIndicator();
            }
          },
          separatorBuilder: (context, index) {
            return const Divider(color: Colors.grey);
          },
        );
      },
    );
  }

  Widget _loadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(child: CircularProgressIndicator()),
    );
  }

  Widget _postWidget(Post post, BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${post.id}. ${post.title}",
            style: const TextStyle(
                fontSize: 18.0,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10.0),
          Text(post.body,
              style: const TextStyle(fontSize: 14.0, color: Colors.deepPurple)),
        ],
      ),
    );
  }
}
