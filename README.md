<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

A simple tool for calculating the delta (difference) between 2 json objects with the same schema.

Particulary useful for editing objects in UI - enabling save button if the edited object differs from the original, and sending a PATCH request to the backend using the delta method.

## Features

This tool includes 2 basic functionalities:
1. Check if 2 json objects differ
2. Subtract 2 json objects and get a json object with the difference.

## Getting started

`flutter pub install json_delta`

## Usage

```dart
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
```

## Additional information

This tool is intended for work with objects of the same schema.
For more detailed use cases see the examples.

Feel free to open issues in the GitHub repository.
