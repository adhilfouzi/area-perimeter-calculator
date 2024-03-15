import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: RectanglesApp(),
  ));
}

class Rectangle {
  late int width;
  late int height;
  late int area;
  late int perimeter;

  Rectangle(this.width, this.height) {
    calculateArea();
    calculatePerimeter();
  }

  void calculateArea() {
    area = width * height;
  }

  void calculatePerimeter() {
    perimeter = 2 * (width + height);
  }
}

class RectanglesApp extends StatefulWidget {
  const RectanglesApp({super.key});

  @override
  _RectanglesAppState createState() => _RectanglesAppState();
}

class _RectanglesAppState extends State<RectanglesApp> {
  final widthController = TextEditingController();
  final heightController = TextEditingController();
  final List<Rectangle> rectangles = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rectangles App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: widthController,
                    decoration: const InputDecoration(labelText: 'Width'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: heightController,
                    decoration: const InputDecoration(labelText: 'Height'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    final width = int.tryParse(widthController.text) ?? 0;
                    final height = int.tryParse(heightController.text) ?? 0;

                    if (width > 0 && height > 0) {
                      final rectangle = Rectangle(width, height);
                      setState(() {
                        rectangles.add(rectangle);
                      });
                      widthController.clear();
                      heightController.clear();
                    }
                  },
                  child: const Text('Add Rectangle'),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Rectangles Table'),
                          content: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              columns: const [
                                DataColumn(label: Text('Width')),
                                DataColumn(label: Text('Height')),
                                DataColumn(label: Text('Area')),
                                DataColumn(label: Text('Perimeter')),
                              ],
                              rows: rectangles.map((rectangle) {
                                return DataRow(cells: [
                                  DataCell(Text(rectangle.width.toString())),
                                  DataCell(Text(rectangle.height.toString())),
                                  DataCell(Text(rectangle.area.toString())),
                                  DataCell(
                                      Text(rectangle.perimeter.toString())),
                                ]);
                              }).toList(),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: const Text('Generate Table'),
                ),
              ],
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  rectangles.clear();
                });
              },
              child: const Text('Reset'),
            ),
          ],
        ),
      ),
    );
  }
}
