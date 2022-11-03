import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:video_mobile/models/user.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Auth extends ChangeNotifier{
  User user;
  bool logged=false;
  final storage = new FlutterSecureStorage();

  bool get authenticated => logged;
  User get getUser => user;
  
  void login(Map creds) async{
    try {
     Dio.Response res=await Dio().post('/sanctum/token',data:creds);
     String token=res.data.toString();
     tryToken(token);
     logged=true;
    }catch(e){
      
    }
    notifyListeners();
  }

  tryToken(token) async{
    if(token==null){
      return;
    }
    else{
      try{
        Dio.Response res=await Dio().get(
          '/user',
          options:Dio.Options(headers:{'Authorization':'Bearer $token'})
        );
        this.logged=true;
        this.user=User.fromJson(res.data);
        storeToken(token);
        notifyListeners(); 
      }catch(e){
        
      }
    }
  }
  
  void storeToken(token){
    storage.write(key: 'token', value: token);   
  }

  void logout(){
    logged=false;
    notifyListeners();
  }
}