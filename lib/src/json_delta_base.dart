import 'package:json_patch/json_patch.dart';

class JsonDelta {
  static bool hasDelta(
      Map<String, dynamic> newJson, Map<String, dynamic> oldJson) {
    bool hasChanged = JsonPatch.diff(newJson, oldJson).isNotEmpty;
    return hasChanged;
  }

  static Map<String, dynamic> delta(
      Map<String, dynamic> oldJson, Map<String, dynamic> newJson) {
    List<Map<String, dynamic>> diffs = JsonPatch.diff(oldJson, newJson);
    Map<String, dynamic> changedNew = {};
    for (var diff in diffs) {
      JsonPointer pointer = JsonPointer.fromString(diff['path']);
      // Remove elements that that correspond to list actions
      // In case of list actions we send the whole list
      int arrayIndex = pointer.segments.indexWhere(
          (element) => element == "-" || (int.tryParse(element) != null));
      if (arrayIndex != -1) {
        pointer.segments.removeRange(arrayIndex, pointer.segments.length);
      }

      // Initialize a pointer the the substraction json
      Map<String, dynamic> current = changedNew;

      for (var i = 0; i < pointer.segments.length; i++) {
        String segment = pointer.segments[i];
        // If we are at the last segment we set the value
        if (i == pointer.segments.length - 1) {
          current[segment] = pointer.traverse(newJson);
        } else {
          // We are not at the last segment and this object does not exist so we create it
          if (current[segment] == null) {
            current[segment] = Map<String, dynamic>();
          }
          // We move the pointer to the inner segment
          current = current[segment];
        }
      }
    }
    return changedNew;
  }
}
