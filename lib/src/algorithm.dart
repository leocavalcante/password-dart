import 'algorithms/pbkdf2.dart';

typedef Algorithm AlgorithmFactory(List params, String salt);

abstract class Algorithm {
  static final Map<String, AlgorithmFactory> _algorithms = {
    PBKDF2.id: (List params, String salt) {
      return new PBKDF2(
          blockLength: int.parse(params[0]),
          iterationCount: int.parse(params[1]),
          desiredKeyLength: int.parse(params[2]),
          salt: salt);
    },
  };

  static Algorithm decode(String hash) {
    final parts = hash.split('\$');
    final algoFactory = _algorithms[parts[1]];
    final algorithm = algoFactory(parts[2].split(','), parts[3]);

    return algorithm;
  }

  String process(String password);

  String encode(String id, List params, String salt, String hash) {
    return ['', id, params.join(','), salt, hash].join('\$');
  }
}
