import 'package:json_delta/json_delta.dart';
import 'package:test/test.dart';

void main() {
  group('JsonDelta.subtractJson', () {
    test('Subtract identical JSON objects', () {
      Map<String, dynamic> oldJson = {'key1': 'value1', 'key2': 'value2'};
      Map<String, dynamic> newJson = {'key1': 'value1', 'key2': 'value2'};
      Map<String, dynamic> result = JsonDelta.delta(oldJson, newJson);
      expect(result, {});
    });

    test('Subtract JSON objects with modified fields in new JSON', () {
      Map<String, dynamic> oldJson = {'key1': 'value1'};
      Map<String, dynamic> newJson = {'key1': 'newValue'};
      Map<String, dynamic> result = JsonDelta.delta(oldJson, newJson);
      expect(result, {'key1': 'newValue'});
    });
  });

  group('JsonDelta.subtractJson with different data types', () {
    test('Subtract JSON objects with different data types', () {
      Map<String, dynamic> oldJson = {'key1': 1, 'key2': true, 'key3': 3.14};
      Map<String, dynamic> newJson = {'key1': 2, 'key2': false, 'key3': 2.71};
      Map<String, dynamic> result = JsonDelta.delta(oldJson, newJson);
      expect(result, {'key1': 2, 'key2': false, 'key3': 2.71});
    });
  });

  group('JsonDelta.subtractJson with nested JSON objects', () {
    test('Subtract identical nested JSON objects', () {
      Map<String, dynamic> oldJson = {
        'key1': {'nestedKey1': 'nestedValue1'},
        'key2': 'value2'
      };
      Map<String, dynamic> newJson = {
        'key1': {'nestedKey1': 'nestedValue1'},
        'key2': 'value2'
      };
      Map<String, dynamic> result = JsonDelta.delta(oldJson, newJson);
      expect(result, {});
    });

    test('Subtract nested JSON objects with single key', () {
      Map<String, dynamic> oldJson = {
        'key1': {'nestedKey1': 'nestedValue1'},
        'key2': 'value2'
      };
      Map<String, dynamic> newJson = {
        'key1': {'nestedKey1': 'newNestedValue'},
        'key2': 'value2'
      };
      Map<String, dynamic> result = JsonDelta.delta(oldJson, newJson);
      expect(result, {
        'key1': {'nestedKey1': 'newNestedValue'}
      });
    });

    test('Subtract nested JSON objects with multiple keys', () {
      Map<String, dynamic> oldJson = {
        'key1': {'nestedKey1': 'nestedValue1', 'nestedKey2': 'nestedValue2'},
        'key2': 'value2'
      };
      Map<String, dynamic> newJson = {
        'key1': {'nestedKey1': 'newNestedValue', 'nestedKey2': 'nestedValue2'},
        'key2': 'value2'
      };
      Map<String, dynamic> result = JsonDelta.delta(oldJson, newJson);
      expect(result, {
        'key1': {'nestedKey1': 'newNestedValue'}
      });
    });

    test('Subtract nested JSON objects with multiple nesting levels', () {
      Map<String, dynamic> oldJson = {
        'key1': {
          'nestedKey1': {'nestedKey2': 'nestedValue2'}
        },
        'key2': 'value2'
      };
      Map<String, dynamic> newJson = {
        'key1': {
          'nestedKey1': {'nestedKey2': 'newNestedValue'}
        },
        'key2': 'value2'
      };
      Map<String, dynamic> result = JsonDelta.delta(oldJson, newJson);
      expect(result, {
        'key1': {
          'nestedKey1': {'nestedKey2': 'newNestedValue'}
        }
      });
    });

    test(
        'Subtract nested JSON objects with multiple nesting levels and multiple keys',
        () {
      Map<String, dynamic> oldJson = {
        'key1': {
          'nestedKey1': {
            'nestedKey2': 'nestedValue2',
            'nestedKey3': 'nestedValue3'
          },
          'nestedKey4': 'nestedValue4'
        },
        'key2': 'value2'
      };
      Map<String, dynamic> newJson = {
        'key1': {
          'nestedKey1': {
            'nestedKey2': 'newNestedValue',
            'nestedKey3': 'nestedValue3'
          },
          'nestedKey4': 'newNestedValue'
        },
        'key2': 'value2'
      };
      Map<String, dynamic> result = JsonDelta.delta(oldJson, newJson);
      expect(result, {
        'key1': {
          'nestedKey1': {'nestedKey2': 'newNestedValue'},
          'nestedKey4': 'newNestedValue'
        }
      });
    });

    test('Subtract nested JSON objects with multiple nesting levels and lists',
        () {
      Map<String, dynamic> oldJson = {
        'key1': {
          'nestedKey1': {
            'nestedKey2': [1, 2, 3]
          }
        },
        'key2': 'value2'
      };
      Map<String, dynamic> newJson = {
        'key1': {
          'nestedKey1': {
            'nestedKey2': [1, 2, 4]
          }
        },
        'key2': 'value2'
      };
      Map<String, dynamic> result = JsonDelta.delta(oldJson, newJson);
      expect(result, {
        'key1': {
          'nestedKey1': {
            'nestedKey2': [1, 2, 4]
          }
        }
      });
    });
  });

  group('JsonDelta.subtractJson with lists', () {
    test('Subtract JSON objects with the same lists', () {
      Map<String, dynamic> oldJson = {
        'key1': [1, 2, 3],
        'key2': 'value2'
      };
      Map<String, dynamic> newJson = {
        'key1': [1, 2, 3],
        'key2': 'value2'
      };
      Map<String, dynamic> result = JsonDelta.delta(oldJson, newJson);
      expect(result, {});
    });
    test('Subtract JSON objects with different lists', () {
      Map<String, dynamic> oldJson = {
        'key1': [1, 2, 3],
        'key2': 'value2'
      };
      Map<String, dynamic> newJson = {
        'key1': [1, 2, 4],
        'key2': 'value2'
      };
      Map<String, dynamic> result = JsonDelta.delta(oldJson, newJson);
      expect(result, {
        'key1': [1, 2, 4]
      });
    });
  });
}
