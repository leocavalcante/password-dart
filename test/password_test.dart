import 'package:test/test.dart';

import 'package:password/password.dart';

const password = 'password';
const hash =
    r'$pcks$64,10000,64$530f8afbc74536b9a963b4f1c4cb738bcea7403d4d606b6e074ec5d3baf39d18$56158864e365bd78f6afda27f9a239bcb3f2b7a4773d4c0d0858c86266119d1e35aae9ca1a4777ed3d85c42caeed0c57cc7e09fe7d152d5d4d4ee08506c2b41a';

const anotherHash =
    r'$pcks$16,1000,32$530f8afbc74536b9a963b4f1c4cb738bcea7403d4d606b6e074ec5d3baf39d18$6c71937c45874493099894e8a4db026f10ee6b0acddd5f4f6dcb35a266037041';

void main() {
  test('Password.hash', () {
    final actual = Password.hash(password, new PBKDF2());
    expect(actual, equals(hash));
  });

  test('Password.verify', () {
    final right = Password.verify(password, hash);
    final wrong = Password.verify('wrong', hash);

    expect(right, isTrue);
    expect(wrong, isFalse);
  });

  test('PBKDF2 params', () {
    final actual = Password.hash(
        password,
        new PBKDF2(
          blockLength: 16,
          iterationCount: 1000,
          desiredKeyLength: 32,
        ));

    final right = Password.verify(password, anotherHash);
    final wrong = Password.verify('wrong', anotherHash);

    expect(actual, equals(anotherHash));
    expect(right, isTrue);
    expect(wrong, isFalse);
  });
}
