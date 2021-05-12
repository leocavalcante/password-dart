import 'dart:typed_data';

import 'package:pointycastle/api.dart' show KeyParameter;
import 'package:pointycastle/digests/sha512.dart';
import 'package:pointycastle/key_derivators/api.dart' show Pbkdf2Parameters;
import 'package:pointycastle/key_derivators/pbkdf2.dart';
import 'package:pointycastle/macs/hmac.dart';
import 'package:pointycastle/random/fortuna_random.dart';

import '../algorithm.dart';
import '../helpers.dart';

/// Wraps the PBKDF2 key derivator.
class PBKDF2 extends Algorithm {
  static String id = 'pcks';

  final int blockLength;
  final int iterationCount;
  final int desiredKeyLength;

  late PBKDF2KeyDerivator _derivator;
  late Uint8List _salt;

  PBKDF2(
      {this.blockLength = 64,
      this.iterationCount = 10000,
      this.desiredKeyLength = 64,
      String? salt = null}) {
    final rnd = new FortunaRandom()..seed(new KeyParameter(new Uint8List(32)));

    _salt =
        salt == null ? rnd.nextBytes(32) : createUint8ListFromHexString(salt);

    _derivator =
        new PBKDF2KeyDerivator(new HMac(new SHA512Digest(), blockLength))
          ..init(new Pbkdf2Parameters(_salt, iterationCount, desiredKeyLength));
  }

  @override
  String process(String password) {
    final bytes =
        _derivator.process(new Uint8List.fromList(password.codeUnits));

    return encode(
      id,
      [blockLength, iterationCount, desiredKeyLength],
      formatBytesAsHexString(_salt),
      formatBytesAsHexString(bytes),
    );
  }
}
