import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_dio/Controller/Controller.dart';

class DetailPage extends StatefulWidget {
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isLoading = false;
   final model=Get.put(Controller());
  final titleController =new TextEditingController();
  final bodyController =new TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading=false;
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.purple,
        body:Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 70),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 5),
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(10)
                      ),child: TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Title",
                          hintStyle: TextStyle(color: Colors.white,fontSize: 16)
                      ),
                    ),
                    ),SizedBox(height: 10,),
                    Container(
                      padding: EdgeInsets.only(left: 5),
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(10)
                      ),child: TextField(
                      controller: bodyController,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Body",
                          hintStyle: TextStyle(color: Colors.white,fontSize: 16)
                      ),
                    ),
                    ),
                    SizedBox(height: 50,),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 50),
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(10)
                      ),child: FlatButton(
                      splashColor: Colors.blue,
                      onPressed: (){
                        model.sendApiToServer(titleController, bodyController, context);
                        Navigator.of(context).pop();
                      },child: Text("Post it",style: TextStyle(
                        color: Colors.grey,fontSize: 16
                    ),),

                    ),
                    )



                  ],),),
            ),model.isLoading != null?Center(child: CircularProgressIndicator(),):SizedBox.shrink()
          ],
        )
    );

  }

}




