import 'package:json_delta_tool/json_delta_tool.dart';

void main() {
  Map<String, dynamic> person = {
    'name': 'John Doe',
    'age': 30,
    'email': 'example@mail.com'
  };

  Map<String, dynamic> editedPerson = {
    'name': 'John Doe',
    'age': 30,
    'email': 'newEmail@mail.com'
  };

  // Output: true
  print(JsonDelta.hasDelta(person, editedPerson));

  // Output: {'email': 'newEmail@mail.com'}
  print(JsonDelta.delta(person, editedPerson));
}
