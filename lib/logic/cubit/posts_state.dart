part of 'posts_cubit.dart';

@immutable
sealed class PostsState {}

final class PostsInitial extends PostsState {}

final class PostsLoading extends PostsState {
  final List<Post> oldPosts;
  final bool isRefresh;

  PostsLoading({required this.oldPosts, this.isRefresh = false});
}

final class PostsLoaded extends PostsState {
  final List<Post> posts;

  PostsLoaded({required this.posts});
}
