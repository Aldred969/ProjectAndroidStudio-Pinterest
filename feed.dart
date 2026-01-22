import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final Dio dio = Dio();
  List posts = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadPosts();
  }

  Future<void> loadPosts() async {
    try {
      final response = await dio.get(
        "https://pencarijawabankaisen.my.id/pencari2_wirabuana_api/user_post_list.php",
      );
      setState(() {
        posts = response.data;
        loading = false;
      });
    } catch (e) {
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pinterest")),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 0.75,
        ),
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              "https://pencarijawabankaisen.my.id/pencari2_wirabuana_api/uploads/${p['image']}",
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
