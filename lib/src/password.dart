import 'algorithm.dart';

class Password {
  static String hash(String password, Algorithm algorithm) {
    return algorithm.process(password);
  }

  static bool verify(String password, String hash) {
    final algorithm = Algorithm.decode(hash);
    return algorithm.process(password) == hash;
  }
}
