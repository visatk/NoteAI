import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:myapp/models/note.dart';
import 'package:myapp/providers/notes_provider.dart';
import 'package:myapp/db/database_helper.dart';

class MockDatabaseHelper extends Mock implements DatabaseHelper {}

class FakeNote extends Fake implements Note {}

void main() {
  late MockDatabaseHelper mockDbHelper;
  late NotesProvider provider;

  setUpAll(() {
    registerFallbackValue(FakeNote());
  });

  setUp(() {
    mockDbHelper = MockDatabaseHelper();
    provider = NotesProvider(dbHelper: mockDbHelper);
  });

  test('loadNotes should fetch notes from database', () async {
    final notes = [
      Note(
        id: '1',
        title: 'Title 1',
        content: 'Content 1',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    ];

    when(() => mockDbHelper.getAllNotes()).thenAnswer((_) async => notes);

    await provider.loadNotes();

    expect(provider.notes.length, 1);
    expect(provider.notes.first.title, 'Title 1');
    verify(() => mockDbHelper.getAllNotes()).called(1);
  });

  test('addNote should insert note and reload', () async {
    when(() => mockDbHelper.insertNote(any())).thenAnswer((_) async {});
    when(() => mockDbHelper.getAllNotes()).thenAnswer((_) async => []);

    await provider.addNote('New Note', 'New Content');

    verify(() => mockDbHelper.insertNote(any())).called(1);
    verify(() => mockDbHelper.getAllNotes()).called(1);
  });

  test('deleteNote should delete note and update list', () async {
    when(() => mockDbHelper.deleteNote(any())).thenAnswer((_) async => 1);

    // Setup initial state
    final notes = [
      Note(
        id: '1',
        title: 'Title 1',
        content: 'Content 1',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    ];
    // Mock getAllNotes to return this list first
    when(
      () => mockDbHelper.getAllNotes(),
    ).thenAnswer((_) async => List.of(notes));

    await provider.loadNotes();
    expect(provider.notes.length, 1);

    // Now delete
    await provider.deleteNote('1');

    verify(() => mockDbHelper.deleteNote('1')).called(1);
    expect(provider.notes.length, 0);
  });
}
