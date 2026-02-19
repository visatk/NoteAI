import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/models/note.dart';

void main() {
  group('Note Model Test', () {
    test('should convert Note to Map', () {
      final note = Note(
        id: '1',
        title: 'Test Note',
        content: 'Test Content',
        createdAt: DateTime(2023, 1, 1),
        updatedAt: DateTime(2023, 1, 2),
      );

      final map = note.toMap();

      expect(map['id'], '1');
      expect(map['title'], 'Test Note');
      expect(map['content'], 'Test Content');
      expect(map['createdAt'], note.createdAt.toIso8601String());
      expect(map['updatedAt'], note.updatedAt.toIso8601String());
    });

    test('should create Note from Map', () {
      final map = {
        'id': '1',
        'title': 'Test Note',
        'content': 'Test Content',
        'createdAt': DateTime(2023, 1, 1).toIso8601String(),
        'updatedAt': DateTime(2023, 1, 2).toIso8601String(),
      };

      final note = Note.fromMap(map);

      expect(note.id, '1');
      expect(note.title, 'Test Note');
      expect(note.content, 'Test Content');
      expect(note.createdAt, DateTime(2023, 1, 1));
      expect(note.updatedAt, DateTime(2023, 1, 2));
    });

    test('copyWith should return a new Note with updated fields', () {
      final note = Note(
        id: '1',
        title: 'Test Note',
        content: 'Test Content',
        createdAt: DateTime(2023, 1, 1),
        updatedAt: DateTime(2023, 1, 2),
      );

      final updatedNote = note.copyWith(title: 'Updated Title');

      expect(updatedNote.id, '1');
      expect(updatedNote.title, 'Updated Title');
      expect(updatedNote.content, 'Test Content');
    });
  });
}
