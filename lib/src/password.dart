import 'algorithm.dart';

/// Holds static methods as a module.
class Password {
  /// Hashed the given plain-text [password] using the given [algorithm].
  static String hash(String password, Algorithm algorithm) {
    return algorithm.process(password);
  }

  /// Checks if the given plain-text [password] matches the given encoded [hash].
  static bool verify(String password, String hash) {
    final algorithm = Algorithm.decode(hash);
    return algorithm.process(password) == hash;
  }
}
