import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:furnitures_app/const.dart';
import 'package:furnitures_app/pages/detail_page.dart';
import 'package:furnitures_app/widgets/category_widget.dart';
import 'package:furnitures_app/widgets/header.dart';
import 'package:furnitures_app/widgets/product_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey catListKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                const SizedBox(height: 15,),
                const Header(),
                SizedBox(height: 310,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Hero(tag: 'blue_card', child: Material(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 270,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          color: Theme.of(context).primaryColor
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Image.asset('assets/images/weather.png',width: 25,),
                                      const  Text(" 32'C",style: TextStyle(fontSize: 12,color: Colors.white),)
                                        
                                      ],

                                    ),
                                    const  Text("24",style: TextStyle(fontSize: 50,color: Colors.white,
                                    height: 1.1,
                                      fontWeight: FontWeight.bold
                                    ),),
                                    const  Text("January",style: TextStyle(fontSize: 12,color: Colors.white,
                                        height: 0.2,
                                        fontWeight: FontWeight.w500
                                    ),)

                                  ],
                                ),
                              ),
                              
                            ],
                          ),
                        ),
                      ),
                    )),
                    Positioned(
                        bottom: 25,
                        right: 0,
                        left: 0,
                        child: Hero(tag: 'cat',child: listView(),)),
                    Positioned(
                        top: 0,
                        right: 10,
                        child: Image.asset('assets/images/ladder.png',height: 180,),)

                  ],
                ),
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  const  Text('Recommend',style: TextStyle(fontSize: 14,color: Colors.white,fontWeight: FontWeight.w500),),
                    SvgPicture.asset('assets/svg/right_arrow.svg',height: 18,),

                  ],
                ),
                ),
                SizedBox(height: 250,
                child: ListView.builder(
                    itemCount: recommend.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context,int index){
                  return ProductCard(product: recommend[index]);
                }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget listView(){
    return Material(
      color: Colors.transparent,
      child: SizedBox(
        key: catListKey,
        height: 85,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (BuildContext context, int index){
          return InkWell(
            onTap: (){
              final _offset = (catListKey.currentContext!.findRenderObject() as RenderBox)
                  .localToGlobal(Offset.zero);
              Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation1,animation2)=>DetailPage(
                selectedCat: index,catListOffset: _offset,
              ),
                transitionDuration:  const Duration(milliseconds: 500),
                transitionsBuilder: (_, a,__, c)=>FadeTransition(opacity: a,child: c,),
              ));
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: CategoryWidget(category: categories[index],),
            ),
          );
        }),
      ),
    );
  }
}
