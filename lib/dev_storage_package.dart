library dev_storage_package;
import 'dart:developer';
import 'package:get_storage/get_storage.dart';

class DevStorage {
  GetStorage box = GetStorage();

  initilizeDevStorage()async{
    await GetStorage.init();
    log('\x1B[36mGetstorage initialized\x1B[0m');
    return;
  }

  dynamic getKeysValue(String key){
    dynamic value;
    try{
    value = box.read(key);
    log('\x1B[36m Get: ${key}: $value \x1B[0m');
    }
    catch(e){
      log('\x1B[36mDevStorage getKeys value error\x1B[0m');
      //log("DevStorage getKeys value error");
      log('\x1B[36m${e.toString()}\x1B[0m');
    }
    return value;
  }

  bool setKeysValue(String key, dynamic value){
   
    try{
    box.write(key, value);
    log('\x1B[36m Set: ${key} to $value \x1B[0m');
    return true;
    }
    catch(e){
      log('\x1B[36mDevStorage setkeys value error\x1B[0m');
      //log("DevStorage getKeys value error");
      log('\x1B[36m${e.toString()}\x1B[0m');
      return false;
    }
  }


  bool removeKeysValue(String key){
    try{
    box.remove(key);
    log('\x1B[36m Remove: ${key}\x1B[0m');
    return true;
    }
    catch(e){
      log('\x1B[36mDevStorage removekeys  error\x1B[0m');
      //log("DevStorage getKeys value error");
      log('\x1B[36m${e.toString()}\x1B[0m');
      return false;
    }
  }

  
}
