import 'dart:async';
import 'package:at_app_flutter/at_app_flutter.dart' show AtEnv;
import 'package:at_client_mobile/at_client_mobile.dart';
import 'package:at_keymaker/screens/secrets_list_screen.dart';
import 'package:at_onboarding_flutter/at_onboarding_flutter.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:at_utils/at_logger.dart' show AtSignLogger;
import 'package:flutter/material.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  // * load the list of existing Atsigns in the background
  KeyChainManager _keyChainManager = KeyChainManager.getInstance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Atsign Keymaker'),
      ),
      body: Builder(
          builder: (context) => FutureBuilder<List<String>>(
              future: _keyChainManager.getAtSignListFromKeychain(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                List<Widget> children;
                if (snapshot.hasData) {
                  List<String>? atSigns = snapshot.data;
                  children = <Widget>[
                    Text(
                      "Secrets for the following atSigns are stored in the keychain.",
                      overflow: TextOverflow.visible,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        // padding: const EdgeInsets.symmetric(
                        //     vertical: 5, horizontal: 20),
                        itemCount: atSigns!.length,
                        itemBuilder: (BuildContext context, int index) {
                          final atSign = atSigns[index];
                          return Dismissible(
                            key: Key(atSign),
                            background: Container(
                              color: Colors.red,
                              child: Align(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 16),
                                    child: Icon(Icons.delete),
                                  ),
                                  alignment: Alignment.centerRight),
                            ),
                            confirmDismiss: (direction) async {
                              if (direction == DismissDirection.startToEnd) {
                                return false;
                              } else {
                                bool delete = true;
                                final snackbarController =
                                    ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Delete $atSign ?'),
                                    action: SnackBarAction(
                                        label: 'Cancel',
                                        onPressed: () => delete = false),
                                  ),
                                );
                                await snackbarController.closed;
                                return delete;
                              }
                            },
                            onDismissed: (_) {
                              setState(() {
                                _keyChainManager
                                    .deleteAtSignFromKeychain(atSign);
                                atSigns.removeAt(index);
                              });
                            },
                            child: ListTile(
                              shape: RoundedRectangleBorder(
                                  side:
                                      BorderSide(color: Colors.blue, width: 1),
                                  borderRadius: BorderRadius.circular(10)),
                              title: Text(atSigns[index]),
                              trailing: Icon(Icons.navigate_next),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SecretsListScreen(
                                      atSign: atSigns[index],
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        }),
                  ];
                } else if (snapshot.hasError) {
                  children = <Widget>[
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text('Error: ${snapshot.error}'),
                    ),
                  ];
                } else {
                  children = <Widget>[
                    DoOnboardWidget(
                        // futurePreference: widget.futurePreference,
                        ),
                  ];
                }
                return Container(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: children,
                    ),
                  ),
                );
                // child:
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DoOnboardWidget(),
            ),
          );
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class DoOnboardWidget extends StatelessWidget {
  const DoOnboardWidget({
    super.key,
  });
  Future<AtClientPreference> loadAtClientPreference() async {
    var dir = await getApplicationSupportDirectory();

    return AtClientPreference()
      ..rootDomain = AtEnv.rootDomain
      ..namespace = AtEnv.appNamespace
      ..hiveStoragePath = dir.path
      ..commitLogPath = dir.path
      ..isLocalStoreRequired = true;
    // * By default, this configuration is suitable for most applications
    // * In advanced cases you may need to modify [AtClientPreference]
    // * Read more here: https://pub.dev/documentation/at_client/latest/at_client/AtClientPreference-class.html
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        AtOnboardingResult onboardingResult = await AtOnboarding.onboard(
          context: context,
          config: AtOnboardingConfig(
            atClientPreference: await loadAtClientPreference(),
            rootEnvironment: AtEnv.rootEnvironment,
            domain: AtEnv.rootDomain,
            appAPIKey: AtEnv.appApiKey,
          ),
          isSwitchingAtsign: true,
        );
        switch (onboardingResult.status) {
          case AtOnboardingResultStatus.success:
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const StartScreen(
                        // futurePreference: this.futurePreference,
                        )));
            break;
          case AtOnboardingResultStatus.error:
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.red,
                content: Text('An error has occurred'),
              ),
            );
            break;
          case AtOnboardingResultStatus.cancel:
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const StartScreen(
                        // futurePreference: this.futurePreference,
                        )));
            break;
        }
      },
      child: const Text('Onboard an @sign'),
    );
  }
}
