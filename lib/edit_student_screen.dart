import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'student_model.dart';
import 'student_provider.dart';

class EditStudentScreen extends StatefulWidget {
  final Student? student;

  const EditStudentScreen({Key? key, this.student}) : super(key: key);

  @override                         
  _EditStudentScreenState createState() => _EditStudentScreenState();
}

class _EditStudentScreenState extends State<EditStudentScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _majorController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.student != null) {
      _firstNameController.text = widget.student!.firstName;
      _lastNameController.text = widget.student!.lastName;
      _ageController.text = widget.student!.age.toString();
      _majorController.text = widget.student!.major;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.student == null ? 'Add Student' : 'Edit Student'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _firstNameController,
              decoration: InputDecoration(labelText: 'First Name'),
            ),
            TextField(
              controller: _lastNameController,
              decoration: InputDecoration(labelText: 'Last Name'),
            ),
            TextField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Age'),
            ),
            TextField(
              controller: _majorController,
              decoration: InputDecoration(labelText: 'Major'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _saveStudent(context),
              child: Text('Save Student'),
            ),
          ],
        ),
      ),
    );
  }

  void _saveStudent(BuildContext context) {
    final student = Student(
      id: widget.student?.id ?? DateTime.now().millisecondsSinceEpoch,
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      age: int.parse(_ageController.text),
      major: _majorController.text,
    );
    if (widget.student == null) {
      Provider.of<StudentProvider>(context, listen: false).addStudent(student);
    } else {
      Provider.of<StudentProvider>(context, listen: false).updateStudent(student);
    }
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _ageController.dispose();
    _majorController.dispose();
    super.dispose();
  }
}