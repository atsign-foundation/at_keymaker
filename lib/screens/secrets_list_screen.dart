import 'package:at_client_mobile/at_client_mobile.dart';
import 'package:at_keymaker/constants/strings.dart';
import 'package:at_keymaker/screens/secret_value_screen.dart';
import 'package:at_backupkey_flutter/at_backupkey_flutter.dart';
import 'package:flutter/material.dart';

class SecretsListScreen extends StatefulWidget {
  const SecretsListScreen({
    Key? key,
    // required this.futurePreference,
    required this.atSign,
  }) : super(key: key);

  // final Future<AtClientPreference> futurePreference;
  final String atSign;

  @override
  State<SecretsListScreen> createState() => _SecretsListScreenState();
}

class _SecretsListScreenState extends State<SecretsListScreen> {
  @override
  Widget build(BuildContext context) {
    // * Getting the AtClientManager instance to use below
    KeyChainManager _keyChainManager = KeyChainManager.getInstance();
    // AtClientManager _atClientManager = AtClientManager.getInstance();

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.atSign}',
            style: TextStyle(
              overflow: TextOverflow.ellipsis,
              fontSize: 18,
              color: Colors.black,
            )),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: 10,
          ),
          Text('Authentication Secret',
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: 18,
                color: Colors.black,
              )),
          ListTile(
            title: Text('RSA Public Key'),
            subtitle: FutureBuilder<String?>(
                future: _keyChainManager.getPkamPublicKey(widget.atSign),
                builder:
                    (BuildContext context, AsyncSnapshot<String?> snapshot) {
                  String keyString = 'no key found';
                  if (snapshot.hasData) {
                    if (snapshot.data!.isNotEmpty) keyString = snapshot.data!;
                  } else if (snapshot.hasError) {
                    keyString = snapshot.error.toString();
                  }
                  return Text(keyString,
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 14,
                        color: Colors.black,
                      ));
                }),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AtSecretValueScreen(
                    atSign: widget.atSign,
                    atSecretType: AtSecretType.authRSAPublicKey,
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: Text('RSA Private Key'),
            subtitle: FutureBuilder<String?>(
                future: _keyChainManager.getPkamPrivateKey(widget.atSign),
                builder:
                    (BuildContext context, AsyncSnapshot<String?> snapshot) {
                  String keyString = 'no key found';
                  if (snapshot.hasData) {
                    if (snapshot.data!.isNotEmpty) keyString = snapshot.data!;
                  } else if (snapshot.hasError) {
                    keyString = snapshot.error.toString();
                  }
                  return Text(keyString,
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 14,
                        color: Colors.black,
                      ));
                }),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AtSecretValueScreen(
                    atSign: widget.atSign,
                    atSecretType: AtSecretType.authRSAPrivateKey,
                  ),
                ),
              );
            },
          ),
          SizedBox(
            height: 10,
          ),
          Text('Encryption Secret',
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: 18,
                color: Colors.black,
              )),
          ListTile(
            title: Text('RSA Public Key'),
            subtitle: FutureBuilder<String?>(
                future: _keyChainManager.getEncryptionPublicKey(widget.atSign),
                builder:
                    (BuildContext context, AsyncSnapshot<String?> snapshot) {
                  String keyString = 'no key found';
                  if (snapshot.hasData) {
                    if (snapshot.data!.isNotEmpty) keyString = snapshot.data!;
                  } else if (snapshot.hasError) {
                    keyString = snapshot.error.toString();
                  }
                  return Text(keyString,
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 14,
                        color: Colors.black,
                      ));
                }),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AtSecretValueScreen(
                    atSign: widget.atSign,
                    atSecretType: AtSecretType.encryptionRSAPublicKey,
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: Text('RSA Private Key'),
            subtitle: FutureBuilder<String?>(
                future: _keyChainManager.getEncryptionPrivateKey(widget.atSign),
                builder:
                    (BuildContext context, AsyncSnapshot<String?> snapshot) {
                  String keyString = 'no key found';
                  if (snapshot.hasData) {
                    if (snapshot.data!.isNotEmpty) keyString = snapshot.data!;
                  } else if (snapshot.hasError) {
                    keyString = snapshot.error.toString();
                  }
                  return Text(keyString,
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 14,
                        color: Colors.black,
                      ));
                }),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AtSecretValueScreen(
                    atSign: widget.atSign,
                    atSecretType: AtSecretType.encryptionRSAPrivateKey,
                  ),
                ),
              );
            },
          ),
          Text('Self Encryption Secret',
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: 18,
                color: Colors.black,
              )),
          ListTile(
            title: Text('AES Key'),
            subtitle: FutureBuilder<String?>(
                future: _keyChainManager.getSelfEncryptionAESKey(widget.atSign),
                builder:
                    (BuildContext context, AsyncSnapshot<String?> snapshot) {
                  String keyString = 'no key found';
                  if (snapshot.hasData) {
                    if (snapshot.data!.isNotEmpty) keyString = snapshot.data!;
                  } else if (snapshot.hasError) {
                    keyString = snapshot.error.toString();
                  }
                  return Text(keyString,
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 14,
                        color: Colors.black,
                      ));
                }),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AtSecretValueScreen(
                    atSign: widget.atSign,
                    atSecretType: AtSecretType.selfEncryptionAESKey,
                    // futurePreference: widget.futurePreference,
                  ),
                ),
              );
            },
          ),
          Text('Other Secrets',
              style: TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: 18,
                color: Colors.black,
              )),
          ListTile(
            title: Text('Local Persistence Encryption Secret'),
            subtitle: FutureBuilder<List<int>?>(
                future: _keyChainManager.getKeyStoreSecret(widget.atSign),
                builder:
                    (BuildContext context, AsyncSnapshot<List<int>?> snapshot) {
                  String keyString = 'no key found';
                  if (snapshot.hasData) {
                    List<int>? charCodes = snapshot.data;
                    if (charCodes!.isNotEmpty) keyString = charCodes.toString();
                  } else if (snapshot.hasError) {
                    keyString = snapshot.error.toString();
                  }
                  return Text(keyString,
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 14,
                        color: Colors.black,
                      ));
                }),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AtSecretValueScreen(
                    atSign: widget.atSign,
                    atSecretType: AtSecretType.dataPersistenceKey,
                    // futurePreference: widget.futurePreference,
                  ),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Bootstrap Shared Secret'),
            subtitle: FutureBuilder<String?>(
                future: _keyChainManager.getCramSecret(widget.atSign),
                builder:
                    (BuildContext context, AsyncSnapshot<String?> snapshot) {
                  String keyString =
                      'Bootstrap complete, secret has been deleted';
                  if (snapshot.hasData) {
                    if (snapshot.data!.isNotEmpty) keyString = snapshot.data!;
                  } else if (snapshot.hasError) {
                    keyString = snapshot.error.toString();
                  }
                  return Text(keyString,
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 14,
                        color: Colors.black,
                      ));
                }),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AtSecretValueScreen(
                    atSign: widget.atSign,
                    atSecretType: AtSecretType.bootstrapSharedSecret,
                    // futurePreference: widget.futurePreference,
                  ),
                ),
              );
            },
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          BackupKeyWidget(
            atsign: widget.atSign,
          ).showBackupDialog(context);
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.save),
      ),
    );
  }
}
