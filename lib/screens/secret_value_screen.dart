import 'package:at_client_mobile/at_client_mobile.dart';
import 'package:flutter/material.dart';
import '../constants/strings.dart';

// * Once the onboarding process is completed you will be taken to this screen
class AtSecretValueScreen extends StatefulWidget {
  const AtSecretValueScreen({
    Key? key,
    required this.atSign,
    required this.atSecretType,
  }) : super(key: key);

  final String atSign;
  final AtSecretType atSecretType;

  @override
  State<AtSecretValueScreen> createState() => _AtSecretValueScreenState();
}

class _AtSecretValueScreenState extends State<AtSecretValueScreen> {
  KeyChainManager _keyChainManager = KeyChainManager.getInstance();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.atSecretType.value)),
      body: SingleChildScrollView(
        child: Center(
          child: Column(children: [
            FutureBuilder<dynamic>(
                future:
                    _getValueForSecretType(widget.atSign, widget.atSecretType),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  String keyString = 'no keys found';
                  if (snapshot.hasData) {
                    keyString = snapshot.data.toString();
                  } else if (snapshot.hasError) {
                    keyString = snapshot.error.toString();
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Text(keyString,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        )),
                  );
                }),
          ]),
        ),
      ),
    );
  }

  Future<dynamic> _getValueForSecretType(
      String atSign, AtSecretType atSecretType) {
    switch (atSecretType) {
      case AtSecretType.authRSAPrivateKey:
        {
          return _keyChainManager.getPkamPrivateKey(atSign);
        }
      case AtSecretType.authRSAPublicKey:
        {
          return _keyChainManager.getPkamPublicKey(atSign);
        }
      case AtSecretType.bootstrapSharedSecret:
        {
          return _keyChainManager.getCramSecret(atSign);
        }
      case AtSecretType.dataPersistenceKey:
        {
          return _keyChainManager.getKeyStoreSecret(atSign);
        }
      case AtSecretType.encryptionRSAPrivateKey:
        {
          return _keyChainManager.getEncryptionPrivateKey(atSign);
        }
      case AtSecretType.encryptionRSAPublicKey:
        {
          return _keyChainManager.getEncryptionPublicKey(atSign);
        }
      case AtSecretType.selfEncryptionAESKey:
        {
          return _keyChainManager.getSelfEncryptionAESKey(atSign);
        }
    }
  }
}
