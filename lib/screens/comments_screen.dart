import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CommentsScreen extends StatefulWidget {
  final int postId;  // ID del post para cargar los comentarios correspondientes.

  CommentsScreen({required this.postId});

  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  late List _comments;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchComments();
  }

  Future<void> _fetchComments() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/comments?postId=${widget.postId}'));

    if (response.statusCode == 200) {
      setState(() {
        _comments = json.decode(response.body);
        _isLoading = false;
      });
    } else {
      throw Exception('Failed to load comments');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Comments for Post #${widget.postId}"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _comments.length,
              itemBuilder: (context, index) {
                return Container(
                  color: index % 2 == 0 ? Colors.lightBlue[100] : Colors.white,
                  child: ListTile(
                    title: Text(_comments[index]['name']),
                    subtitle: Text("${_comments[index]['body']}\n\nDe: ${_comments[index]['email']}"),
                    isThreeLine: true,  // Permite más espacio para subtítulos multilínea
                  ),
                );
              },
            ),
    );
  }
}
