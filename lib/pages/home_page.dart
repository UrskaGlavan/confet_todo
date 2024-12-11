import 'package:flutter/material.dart';
import 'package:vijolicen_to_do/utils/todo_list.dart';
import 'package:confetti/confetti.dart'; 

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();
  List toDoList = [
    ['naloga 1', true],
    ['naloga 2', true],
    ['naloga 3', false],
    ['naloga 4', false],
  ];

  // Confetti controller added
  final ConfettiController _confettiController =
      ConfettiController(duration: const Duration(seconds: 5));

  void checkBoxChanged(int index) {
    setState(() {
      toDoList[index][1] = !toDoList[index][1];
    });

    // Check if all tasks are completed and trigger confetti
    if (toDoList.every((task) => task[1])) {
      _confettiController.play(); // Start confetti animation
    }
  }

  void saveNewTask() {
    setState(() {
      toDoList.add([_controller.text, false]);
      _controller.clear();
    });
  }

  void deleteTask(int index) {
    setState(() {
      toDoList.removeAt(index);
    });
  }

  @override
  void dispose() {
    _confettiController.dispose(); // Dispose of confetti controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade300,
      appBar: AppBar(
        title: const Text(
          'Simple Todo',
        ),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          // Main ListView
          ListView.builder(
            itemCount: toDoList.length,
            itemBuilder: (BuildContext context, index) {
              return TodoList(
                taskName: toDoList[index][0],
                taskCompleted: toDoList[index][1],
                onChanged: (value) => checkBoxChanged(index),
                deleteFunction: (context) => deleteTask(index),
              );
            },
          ),
          // Confetti animation
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality:
                  BlastDirectionality.explosive, // All directions
              shouldLoop: false, // Stop after duration
              colors: const [
                Colors.deepPurple,
                Colors.purple,
                const Color.fromARGB(255, 86, 9, 100),
                const Color.fromARGB(255, 121, 64, 131),
                Colors.pink,
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'dodaj novo nalogo',
                    filled: true,
                    fillColor: Colors.deepPurple.shade200,
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.deepPurple,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.deepPurple,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
            ),
            FloatingActionButton(
              onPressed: saveNewTask,
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
