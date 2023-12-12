import '../models/post.dart';
import '../web_services/posts_web_service.dart';

class PostsRepo {
  final PostsWebService postsWebService;

  PostsRepo({required this.postsWebService});

  Future<List<Post>> fetchPosts(int page) async {
    final postsData = await postsWebService.getPosts(page);
    return postsData.map((post) => Post.fromJson(post)).toList();
  }
}