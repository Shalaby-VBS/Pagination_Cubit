class Post {
  final String title;
  final String body;
  final int id;

  Post({
    required this.title,
    required this.body,
    required this.id,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      title: json['title'] as String,
      body: json['body'] as String,
      id: json['id'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': body,
      'id': id,
    };
  }
  
}
