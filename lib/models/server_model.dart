class ServerModel {
  final String name;
  final int ping;
  bool isSelected;

  ServerModel({required this.name, required this.ping, this.isSelected = false});
}
