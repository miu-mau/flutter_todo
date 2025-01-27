import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Туду Лист',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 147, 121, 192)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Туду Лист'),
    );
  }
}

class Todo {
  final String id;
  final String title;
  final String text;

  Todo({
    required this.id,
    required this.title,
    required this.text,
  });
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Список задач
  final List<Todo> todos = [];

  // Метод для добавления новой задачи
  void _addTodo() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Создать новую задачу"),
          content: TodoForm(
            onSave: (title, text) {
              setState(() {
                todos.add(Todo(
                  id: DateTime.now().toString(),
                  title: title,
                  text: text,
                ));
              });
              Navigator.pop(context); // Закрыть диалог
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(todos[index].title),
            subtitle: Text(todos[index].text),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTodo,
        tooltip: 'Добавить задачу',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TodoForm extends StatefulWidget {
  final Function(String, String) onSave;

  const TodoForm({super.key, required this.onSave});

  @override
  TodoFormState createState() => TodoFormState();
}

class TodoFormState extends State<TodoForm> {
  final _titleController = TextEditingController();
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _titleController,
          decoration: const InputDecoration(labelText: 'Заголовок'),
        ),
        TextField(
          controller: _textController,
          decoration: const InputDecoration(labelText: 'Описание'),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            final title = _titleController.text;
            final text = _textController.text;
            if (title.isNotEmpty && text.isNotEmpty) {
              widget.onSave(title, text);
            }
          },
          child: const Text('Сохранить'),
        ),
      ],
    );
  }
}
