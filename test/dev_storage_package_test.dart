import 'package:flutter_test/flutter_test.dart';

import 'package:dev_storage_package/dev_storage_package.dart';

void main() async{
  final calculator = DevStorage();
  await calculator.initilizeDevStorage();
  test('adds one to input values', () {
    final calculator = DevStorage();
    expect(calculator.setKeysValue("keys", "valll"), true);
    expect(calculator.getKeysValue("keys"), "vall");
    expect(calculator.removeKeysValue("keys"), true);
  });
}
