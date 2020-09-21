import 'package:flutter_modular/flutter_modular.dart';
import 'package:hasura/app/modules/home/repository/home_repository_interface.dart';
import 'package:hasura/app/shared/utils/constants.dart';
import 'package:hasura_connect/hasura_connect.dart';

class HomeRepository extends Disposable implements IHomeRepository {
  final _client = HasuraConnect(HASURA_URL);

  @override
  Future<List<Map>> getTarefas() async {
    final response = await _client.query('''
      query {
        posts {
          id
          name
          photo
        }
      }
      ''');
    return (response["data"]["posts"] as List)
        .map((e) => {"name": e["name"]})
        .toList();
  }

  @override
  Stream<List<Map>> streamTarefas() {
    return _client.subscription('''
      subscription {
        posts {
          id
          name
          photo
        }
      }
      ''').map((e) => (e["data"]["posts"]
            as List)
        .map((e) => {"name": e["name"]})
        .toList());
  }

  @override
  void dispose() {
    this._client.disconnect();
  }
}
