# password

A set of high-level APIs over [PointyCastle](https://pub.dartlang.org/packages/pointycastle) and [CryptoUtils](https://pub.dartlang.org/packages/cryptoutils) to hash and verify passwords securely.

## API

### `Password.hash`

```dart
Password.hash('password', new PBKDF2());
// $pcks$64,10000,64$530f8afbc74536b9a963b4f1c4cb738bcea7403d4d606b6e074ec5d3baf39d18$56158864e365bd78f6afda27f9a239bcb3f2b7a4773d4c0d0858c86266119d1e35aae9ca1a4777ed3d85c42caeed0c57cc7e09fe7d152d5d4d4ee08506c2b41a
```

### `Password.verify`

```dart
Password.verify('password', previousOutput);
// true
```
