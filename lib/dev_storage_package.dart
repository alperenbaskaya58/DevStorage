library dev_storage_package;
import 'dart:developer';
import 'package:get_storage/get_storage.dart';

class DevStorage {
  GetStorage box = GetStorage();

  initilizeDevStorage()async{
    await GetStorage.init();
    return;
  }

  dynamic getKeysValue(String key){
    dynamic value;
    try{
    value = box.read(key);
    }
    catch(e){
      log("DevStorage getKeys value error");
      log(e.toString());
    }
    return value;
  }

  bool setKeysValue(String key, dynamic value){
   
    try{
    box.write(key, value);
    return true;
    }
    catch(e){
      log("DevStorage setKeysValue value error");
      log(e.toString());
      return false;
    }
  }


  bool removeKeysValue(String key){
    try{
    box.remove(key);
    return true;
    }
    catch(e){
      log("DevStorage removeKeysvalue value error");
      log(e.toString());
      return false;
    }
  }

  
}
