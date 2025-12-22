import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: PostsPage(),
    );
  }
}


class Post {
  final int id;
  final String title;

  Post({required this.id, required this.title});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
    );
  }
}


class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  List<Post> posts = [];
  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

 
  Future<void> fetchPosts() async {
    try {
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      );

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);

        setState(() {
          posts = data.map((json) => Post.fromJson(json)).toList();
          isLoading = false;
        });
      } else {
        throw Exception('Ошибка сервера');
      }
    } catch (e) {
      setState(() {
        hasError = true;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Посты'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {

    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

  
    if (hasError) {
      return const Center(
        child: Text(
          'Ошибка загрузки',
          style: TextStyle(fontSize: 18),
        ),
      );
    }

   
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return ListTile(
          title: Text(post.title),
        );
      },
    );
  }
}
