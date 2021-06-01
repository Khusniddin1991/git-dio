import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:getx_dio/Model/Model.dart';
import 'package:getx_dio/Services/Networks.dart';


class Controller extends GetxController {
  var isLoading =false.obs;

  var items = new List<Posting>().obs;

  Future apiPostList() async {
    isLoading(true);
    var response = await Network().GET(Network.API_LIST);
    if(response != null){
      items.value = response;
    }else{
      items.value = new List();
    }
    isLoading(false);
  }

  Future<bool> apiPostDelete(Posting post) async {
    isLoading(true);
    var response = await Network().DEL(Network.API_DELETE + post.id.toString());
    isLoading(false);
    return response != null;
  }
 void sendApiToServer(TextEditingController titleController,TextEditingController bodyController,BuildContext context)async {

   String title=titleController.text.trim();
   String body=bodyController.text.trim();
   print(body);
   if(title.isEmpty&&body.isEmpty){
     return;
   }
   Posting posts=Posting(title: title,body:body);
   add(posts,context);
 }
 void add(Posting post,BuildContext context)async {
   isLoading();
   var res=await Network().POST(Network.API_CREATE, Network.paramsCreate(post));
   print(res);
   try{
     if(res==null){
       isLoading(false);
       Navigator.of(context).pop({"data":"the result"});
     }
   }catch(e){
     print(e);
   }

 }
 void sendApiToForUpdate(TextEditingController titleController,TextEditingController bodyController,BuildContext context)async {

   String title=titleController.text.trim();
   String body=bodyController.text.trim();
   var time=DateTime.now().microsecond;
   print(time);
   print(body);
   if(title.isEmpty&&body.isEmpty){
     return;
   }
   Posting posts=Posting(title: title,body:body ,userId:1);
   adds(posts,context);
 }
 void adds(Posting post,BuildContext context)async {
   isLoading(true);
   var res=await Network().PUT(Network.API_UPDATE,Network.paramsUpdate(post));
   print(res);
   try{
     if(res==null){
       isLoading(false);
       Navigator.of(context).pop({"data":"the result"});
     }
   }catch(e){
     print(e);
   }
}}