# <div align="center">🪭 pagination Cubit 🪭</div>


## 🚀 Getting Started
- A Flutter application showcasing pagination implementation using the `flutter_bloc` library. This project demonstrates how to efficiently load and display data in chunks, providing a smooth user experience with minimal resource consumption.

<br/>

## 🪄 Features

- **Pagination with Cubit:** Utilize the power of flutter_bloc for efficient state management in paginated scenarios.

- **Efficient Data Loading:** Load data in chunks to minimize the impact on performance.

- **Loading States:** Handle loading states to keep users informed during data fetching.

- **Error Handling:** Gracefully handle errors during data retrieval.

<br/>

## ⚙️ Customization

- Customize the appearance and behavior of the clipboard according to your requirements:

1- **PaginationCubit:**
```dart
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
```
2- **PaginationState:**
```dart
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
```

<br/>

## 📱 UI



<br/>

## 🛠 Dependencies

```yaml
  flutter_bloc: ^8.1.3
```

<br/>

## 🫴 Contributing

- Contributions are welcome 💜
- If you find any issues or have suggestions for improvements, feel free to open an issue or submit a pull request.

<br/>

## 💳 License

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)](https://github.com/Shalaby-VBS/Pagination_Cubit)
- This package is distributed under the MIT License. Feel free to use and modify it according to your project requirements.

<br/>

## 🤝 Contact With Me

[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/ahmed-shalaby-21196521b/) 
[![Gmail](https://img.shields.io/badge/Gmail-333333?style=for-the-badge&logo=gmail&logoColor=red)](https://www.shalaby.vbs@gmail.com)
[![Facebook](https://img.shields.io/badge/Facebook-0077B5?style=for-the-badge&logo=facebook&logoColor=white)](https://www.facebook.com/profile.php?id=100093012790432&mibextid=hIlR13)
[![Instagram](https://img.shields.io/badge/Instagram-E4405F?style=for-the-badge&logo=instagram&logoColor=white)](https://www.instagram.com/sh4l4by/)

<br/>

## 💖 Support

- If you find this tutorial useful or learned something from this code, consider show some ❤️ by starring this repo.
