# Professional Notes

A high-level professional Personal Note App for Android, built with Flutter.

## Features

-   **Beautiful Design**: Material 3 design with a clean, masonry layout.
-   **Rich Note Management**: Create, edit, and delete notes.
-   **Local Persistence**: Notes are stored securely using SQLite (`sqflite`).
-   **Search**: Fast and efficient search functionality.
-   **Dark Mode**: Automatic dark mode support based on system settings.
-   **Custom Typography**: Uses professional fonts (Lato) via Google Fonts.

## Architecture

-   **State Management**: `Provider` (ChangeNotifier).
-   **Database**: `sqflite` with Singleton `DatabaseHelper`.
-   **Models**: Immutable `Note` model.
-   **UI**: Modular widgets and screens.

## Getting Started

1.  Clone the repository.
2.  Run `flutter pub get`.
3.  Run `flutter run`.

## Testing

Run unit and widget tests:

```bash
flutter test
```
