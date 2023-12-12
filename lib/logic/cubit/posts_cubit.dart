import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/post.dart';
import '../../data/repositories/posts_repo.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  final PostsRepo postsRepo;
  PostsCubit(this.postsRepo) : super(PostsInitial());
  // MARK: - Variables.
  int page = 1;
  List<Post> posts = [];
  // MARK: - Load With Pagination Method.
  Future<void> loadPosts() async {
    // MARK: - Variables.
    final currentState = state;
    bool isRefresh = false;
    var oldPosts = <Post>[];
    // MARK: - States.
    if (state is PostsLoading) return;
    if (currentState is PostsLoaded) {
      oldPosts = currentState.posts;
    } else if (currentState is PostsLoading) {
      oldPosts = currentState.oldPosts;
      isRefresh = currentState.isRefresh;
    }
    emit(PostsLoading(oldPosts: oldPosts, isRefresh: page == 1 ? false : isRefresh));
    postsRepo.fetchPosts(page).then((newPosts) {
      page++;
      posts.addAll(newPosts);
      emit(PostsLoaded(posts: posts));
    }).catchError((e) {
      // ignore: deprecated_member_use
      if (e is DioError) {
        debugPrint(e.response?.data);
      }
    });
  }
}
