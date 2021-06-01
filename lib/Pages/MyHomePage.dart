


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:getx_dio/Controller/Controller.dart';
import 'package:getx_dio/Model/Model.dart';
import 'package:getx_dio/Pages/updatePage.dart';

import 'DertailPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Controller  _controller=Get.put(Controller());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.apiPostList();
  }
Future openDetail() async{
  Map results = await Navigator.of(context).push(new MaterialPageRoute(
      builder: (BuildContext context){
        return new DetailPage();
      }
  ));
  if(results != null && results.containsKey("data")){
    print(results['data']);
    _controller .apiPostList();
  }
}
Future openDetails() async{
  Map results = await Navigator.of(context).push(new MaterialPageRoute(
      builder: (BuildContext context){
        return new UpdatePage();
      }
  ));
  if(results != null && results.containsKey("data")){
    print(results['data']);
    _controller.apiPostList();
  }
}


@override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("GetX"),centerTitle: true,
        ),
        body: Obx(
              () => Stack(
            children: [
              ListView.builder(
                itemCount: _controller.items.length,
                itemBuilder: (ctx, index) {
                  return itemOfPost(_controller.items[index],_controller);
                },
              ),
              _controller.isLoading()
                  ? Center(
                child: CircularProgressIndicator(),
              )
                  : SizedBox.shrink(),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          onPressed: () {
            Get.to(DetailPage());
          },
          child: Icon(Icons.add),
        ));
  }
  Widget itemOfPost(Posting post, Controller controller) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.title.toUpperCase(),
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5,
            ),
            Text(post.body),
          ],
        ),
      ),
      actions: <Widget>[
        IconSlideAction(
          caption: 'Update',
          color: Colors.indigo,
          icon: Icons.edit,
          onTap: () {
           openDetails();
          },
        ),
      ],
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () {
            _controller.apiPostDelete(post).then((value) => {
              if(value){
                controller.apiPostList(),
              }
            });
          },
        ),
      ],
    );
  }
}