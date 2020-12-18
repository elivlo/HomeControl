// CommunicationHandler as base for all Devices communication
abstract class CommunicationHandler {
  CommunicationHandler(this.hostname, this.port);

  int port;
  String hostname;

  Future<bool> getStateBool(int relayNumber);

  Future<bool> setStateBool(int relayNumber, bool on);
}