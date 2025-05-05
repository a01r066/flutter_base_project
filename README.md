# bus_app - a Flutter Clean Architecture Template

A production-ready Flutter application template built with clean architecture principles and modern
development practices.

## 🏗️ Architecture Overview

This template follows Uncle Bob's Clean Architecture principles, separating the application into
three main layers:

```
lib/
├── core/                    # Shared utilities and services
├── features/               # Feature modules
│   └── feature_name/
│       ├── data/           # Data sources and repository implementations
│       ├── domain/         # Business logic and entities
│       └── presentation/   # UI components and state management
└── main.dart
```

## 📦 Dependencies

### State Management

- **hooks_riverpod** - Reactive state management with hooks integration
- **flutter_hooks** - React hooks for Flutter widgets

### Code Generation

- **freezed** - Immutable classes and unions
- **json_serializable** - JSON serialization/deserialization
- **build_runner** - Build system for code generation

### Navigation

- **go_router** - Declarative routing for Flutter

### Location Services

- **geolocator** - Location and geofencing
- **geocoding** - Address to coordinates conversion

### Network

- **dio** - HTTP client for REST API calls

### Functional Programming

- **dartz** - Functional programming utilities (Either, Option, etc.)

### Storage

- **shared_preferences** - Simple key-value storage
- **flutter_secure_storage** - Secure storage for sensitive data

### Internationalization

- **intl** - Internationalization and localization

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (≥3.0.0)
- Dart SDK (≥3.0.0)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/flutter-clean-architecture.git
   cd flutter-clean-architecture
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code**
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

## 🔨 Project Structure

### Core Layer

Contains shared utilities, services, and configurations:

- **Constants** - App-wide constants and configuration values
- **Errors** - Exception and failure handling
- **Network** - HTTP client configuration and network status
- **Routes** - Navigation routing configuration
- **Storage** - Shared preferences and secure storage services
- **Location** - Location and geocoding services
- **Utils** - Input validation and conversion utilities

### Feature Layer

Each feature follows the same structure:

1. **Data Layer**
    - `datasources/` - Remote and local data sources
    - `models/` - Data transfer objects with JSON serialization
    - `repositories/` - Repository implementations

2. **Domain Layer**
    - `entities/` - Business objects
    - `repositories/` - Repository interfaces
    - `usecases/` - Business logic use cases

3. **Presentation Layer**
    - `providers/` - Riverpod state providers
    - `pages/` - Screen widgets
    - `widgets/` - Reusable UI components

## 💡 Key Features

### Clean Architecture

- Clear separation of concerns
- Dependency inversion
- Testable architecture
- Independent of frameworks

### State Management

- Declarative state management with Riverpod
- Type-safe state handling
- Immutable state with Freezed

### Error Handling

- Type-safe error handling with Either
- Centralized error management
- User-friendly error messages

### Data Persistence

- Local caching for offline support
- Secure token storage
- Preference management

### Internationalization

- Built-in support for multiple languages
- Locale-specific formatting
- Easy translation management

## 📝 Usage Examples

### Creating a New Feature

1. **Create the feature structure**
   ```
   lib/features/my_feature/
   ├── data/
   ├── domain/
   └── presentation/
   ```

2. **Define the domain entity**
   ```dart
   @freezed
   class MyEntity with _$MyEntity {
     const factory MyEntity({
       required String id,
       required String name,
     }) = _MyEntity;
   }
   ```

3. **Create a use case**
   ```dart
   class GetMyEntity {
     final MyRepository repository;
     
     GetMyEntity(this.repository);
     
     Future<Either<Failure, MyEntity>> call(String id) async {
       return await repository.getMyEntity(id);
     }
   }
   ```

4. **Implement the repository**
   ```dart
   class MyRepositoryImpl implements MyRepository {
     final MyRemoteDataSource remoteDataSource;
     final MyLocalDataSource localDataSource;
     
     // Implementation...
   }
   ```

5. **Create a provider**
   ```dart
   final myEntityProvider = StateNotifierProvider<MyEntityNotifier, MyEntityState>((ref) {
     final repository = ref.watch(myRepositoryProvider);
     return MyEntityNotifier(repository: repository);
   });
   ```

### Network Configuration

Update `AppConstants.apiBaseUrl` with your API endpoint:

```dart
class AppConstants {
  static const String apiBaseUrl = 'https://api.your-domain.com/v1';
}
```

### Location Services

```dart
// Get current location
final position = await
locationService.getCurrentPosition
();

// Get address from coordinates
final addresses = await
locationService.getAddressFromCoordinates
(
position.latitude,
position.longitude,
);
```

### Storage

```dart
// Save to secure storage
await
secureStorageService.saveAuthToken
('your-token
'
);

// Save to shared preferences
await sharedPreferencesService
.
saveAppTheme
(
'
dark
'
);
```

## 🧪 Testing

The template includes a testing structure:

```
test/
├── core/
├── features/
│   └── feature_name/
│       ├── data/
│       ├── domain/
│       └── presentation/
└── fixtures/
```

Run tests:

```bash
flutter test
```

## 🔐 Security

- Sensitive data storage with flutter_secure_storage
- API token management
- Input validation utilities
- Secure network communication

## 🎨 UI/UX

- Material 3 design system
- Responsive layouts
- Dark mode support
- Custom theme configuration

## 📚 Best Practices

1. **Separation of Concerns** - Each layer has a single responsibility
2. **Dependency Injection** - Dependencies are injected, not created
3. **Immutability** - Using Freezed for immutable state
4. **Type Safety** - Leveraging Dart's type system
5. **Code Generation** - Reducing boilerplate with build_runner
6. **Error Handling** - Comprehensive error management
7. **Testing** - Architecture supports easy unit testing

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📱 Supported Platforms

- ✅ iOS
- ✅ Android
- ✅ Web
- ✅ macOS
- ✅ Windows
- ✅ Linux

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [Flutter](https://flutter.dev/)
- [Riverpod](https://riverpod.dev/)
- [Go Router](https://pub.dev/packages/go_router)
- [Freezed](https://pub.dev/packages/freezed)
- All contributors and the Flutter community

## 📞 Support

For support, email your-email@example.com or join our Slack channel.

---

Made with ❤️ using Flutter