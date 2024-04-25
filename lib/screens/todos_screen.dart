import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TodosScreen extends StatefulWidget {
  @override
  _TodosScreenState createState() => _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen> {
  late List _todos;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchTodos();
  }

  Future<void> _fetchTodos() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));
    if (response.statusCode == 200) {
      setState(() {
        _todos = json.decode(response.body);
        _isLoading = false;
      });
    } else {
      throw Exception('Failed to load to dos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("To Dos"),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _todos.length,
              itemBuilder: (context, index) {
                var todo = _todos[index];
                return ListTile(
                  title: Text(todo['title']),
                  trailing: Icon(
                    todo['completed'] ? Icons.check_circle : Icons.check_circle_outline,
                    color: todo['completed'] ? Colors.green : Colors.red,
                  ),
                );
              },
            ),
    );
  }
}
