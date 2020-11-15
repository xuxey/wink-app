import 'dart:async';

import 'package:screen_state/screen_state.dart';

class ScreenStateChecker {
  Screen _screen;
  StreamSubscription<ScreenStateEvent> _subscription;

  void onData(ScreenStateEvent event) {
    print(event);
  }

  void startListening() {
    _screen = new Screen();
    try {
      _subscription = _screen.screenStateStream.listen(onData);
    } on ScreenStateException catch (exception) {
      print(exception);
    }
  }

  void stopListening() {
    _subscription.cancel();
  }
}
