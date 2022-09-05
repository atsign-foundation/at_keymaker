enum AtSecretType {
  authRSAPublicKey('authRSAPublicKey'),
  authRSAPrivateKey('authRSAPrivateKey'),
  encryptionRSAPublicKey('encryptionRSAPublicKey'),
  encryptionRSAPrivateKey('encryptionRSAPrivateKey'),
  selfEncryptionAESKey('selfEncryptionAESKey'),
  dataPersistenceKey('dataPersistenceKey'),
  bootstrapSharedSecret('bootstrapSharedSecret');

  const AtSecretType(this.value);
  final String value;
}
