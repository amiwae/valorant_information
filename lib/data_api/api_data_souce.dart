import 'base_network.dart';

class ApiDataSourceWeapons {
  static ApiDataSourceWeapons instance = ApiDataSourceWeapons();
  Future<Map<String, dynamic>> loadWeapons() {
    return BaseNetwork.get("weapons");
  }

  Future<Map<String, dynamic>> loadDetailWeapons(int idDiterima){
    String uuid = idDiterima.toString();
    return BaseNetwork.get("$uuid");
  }
}

class ApiDataSourceAgents {
  static ApiDataSourceAgents instance = ApiDataSourceAgents();
  Future<Map<String, dynamic>> loadAgents() {
    return BaseNetwork.get("agents");
  }

  Future<Map<String, dynamic>> loadDetailAgents(int idDiterima){
    String uuid = idDiterima.toString();
    return BaseNetwork.get("$uuid");
  }
}
