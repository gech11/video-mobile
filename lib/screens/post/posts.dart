import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:video_mobile/models/channel.dart';
import 'package:video_mobile/services/dio.dart';

class Posts extends StatefulWidget {
  const Posts({super.key});

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  dynamic posts=[];
  late Channel channel;

  @override
  void initState() {
    getChannelPosts();
    super.initState();
  }

  Future getChannelPosts() async{
    Response res=await dio().get('/channel/${channel.id}/viedos');
    posts=res.data;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context,index){
        var post=posts[index];
        return GestureDetector(
          onTap: (){
            //Navigator.push(context, MaterialPageRoute(builder: (context)=>PostShow()));
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Row(
              crossAxisAlignment:CrossAxisAlignment.start,
              children: [
                post.image?
                Image.network(
                  width:MediaQuery.of(context).size.width/2,
                  '${post.image}'
                  //'https://media.istockphoto.com/id/1405163092/photo/3d-render-of-sport-running-shoe-isolated-on-pastel-background-3d-background-minimal-scene.jpg?s=612x612&w=is&k=20&c=55ZC86AZBWD60IbclH2UnKj-93DpR34dDVI9HXzCpFo='
                )
                :SizedBox(),
                SizedBox(width: 5,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${post.title}',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600)),
                    Text('${post.description}',style: TextStyle(fontSize: 16,color: Colors.grey[700])),
                  ],
                )
              ],
            ), 
          ),
        );
      }
      )
    ); 
  }
}