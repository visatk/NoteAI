import 'package:flutter/material.dart';
import '../models/note.dart';
import '../db/database_helper.dart';
import 'package:uuid/uuid.dart';

class NotesProvider with ChangeNotifier {
  List<Note> _notes = [];
  bool _isLoading = false;
  String _searchQuery = '';
  final DatabaseHelper _dbHelper;

  NotesProvider({DatabaseHelper? dbHelper})
    : _dbHelper = dbHelper ?? DatabaseHelper.instance;

  List<Note> get notes {
    if (_searchQuery.isEmpty) {
      return _notes;
    } else {
      return _notes
          .where(
            (note) =>
                note.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                note.content.toLowerCase().contains(_searchQuery.toLowerCase()),
          )
          .toList();
    }
  }

  List<Note> get allNotes => _notes;

  bool get isLoading => _isLoading;

  Future<void> loadNotes() async {
    _isLoading = true;
    notifyListeners();

    _notes = await _dbHelper.getAllNotes();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addNote(String title, String content) async {
    final newNote = Note(
      id: const Uuid().v4(),
      title: title,
      content: content,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await _dbHelper.insertNote(newNote);
    await loadNotes();
  }

  Future<void> updateNote(Note note) async {
    final updatedNote = note.copyWith(updatedAt: DateTime.now());

    await _dbHelper.updateNote(updatedNote);
    await loadNotes();
  }

  Future<void> deleteNote(String id) async {
    await _dbHelper.deleteNote(id);
    _notes.removeWhere((note) => note.id == id);
    notifyListeners();
  }

  void searchNotes(String query) {
    _searchQuery = query;
    notifyListeners();
  }
}
