import 'package:flutter/material.dart';
import 'package:math_puzzle/data.dart';
import 'package:math_puzzle/sizedata.dart';
import 'package:math_puzzle/winpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class page1 extends StatefulWidget {
  int? pos;
  page1(this.pos);

  @override
  State<page1> createState() => _page1State();
}

class _page1State extends State<page1> {
  String currentnumber="";
  SharedPreferences? prefs;

  memory() async {
     prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    memory();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: sizedeta.height,
        width: sizedeta.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("photos/gameplaybackground.jpg"),
                fit: BoxFit.fill)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () async {
                    await prefs!.setInt('lastlevel', widget.pos!);
                    await prefs!.setString('level${widget.pos}', "skip");

                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                      return page1(widget.pos!+1);
                    },));
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    height: sizedeta.width! / 10,
                    width: sizedeta.width! / 10,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("photos/skip.png"))),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  height: 50,
                  width: 200,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("photos/level_board.png"),
                          fit: BoxFit.fill)),
                  alignment: Alignment.center,
                  child: Text(
                    "Puzzle ${widget.pos!+1}",
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  height: sizedeta.width! / 10,
                  width: sizedeta.width! / 10,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("photos/hint.png"))),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              height: sizedeta.width,
              width: sizedeta.width! - 30,
              decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage("photos/p${widget.pos!+1}.png"))),
            ),
            Spacer(),
            Container(
              width: sizedeta.width,
              color: Colors.black,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height:sizedeta.height!*0.05,
                        width: sizedeta.width!/1.9,
                        color: Colors.white,
                        child: Text("${currentnumber}"),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            //123-0,2
                            if (currentnumber.length> 0) {
                              currentnumber=currentnumber.substring(0,currentnumber.length-1);
                            }
                          });
                        },
                        child: Container(
                          height: sizedeta.height!*0.05,
                          width: sizedeta.width!*0.2,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("photos/delete.png")
                              )
                          ),

                        ),
                      ),
                      InkWell(
                          onTap: () async {

                            if(currentnumber==data.anslist[widget.pos!])
                              {

                                await prefs!.setInt('lastlevel', widget.pos!);
                                await prefs!.setString('level${widget.pos}', "win");

                                Navigator.push(context, MaterialPageRoute(builder: (context) {
                                  return winpage(widget.pos);
                                },));
                              }
                            else{
                              print("wrong");
                            }


                          },
                          child: Container(
                              child: Text("SUBMIT",style: TextStyle(fontSize: 15,color: Colors.white),)))
                    ],
                  ),
                  SizedBox(
                    height: sizedeta.bdheight!/7.5,
                    width: sizedeta.width! - 30,
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 5,
                          crossAxisCount: 10),
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              currentnumber=currentnumber+data.number[index];
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.white,width: 1)
                            ),
                            alignment: Alignment.center,
                            child: Text("${data.number[index]}",
                              style: TextStyle(color: Colors.white),),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}
