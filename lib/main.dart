import 'package:flutter/material.dart';
import 'package:colorful_safe_area/colorful_safe_area.dart';



void main() {
  runApp( MyApp());
}
class MyApp extends StatelessWidget {
      MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tic Tac Toe',
      theme: ThemeData(primaryColor: Colors.teal,),
      home: Home()
    );
  }
}

class Home extends StatefulWidget {
   Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var grid = [
    '-',
    '-',
    '-',
    '-',
    '-',
    '-',
    '-',
    '-',
    '-',
  ];
  var winner = "";
  var draw = false;
  var currentplyer ='x';
  void drawxo(i){
    if(grid[i]=='-') {
      setState(() {
        grid[i] = currentplyer;
        currentplyer = currentplyer == 'x' ? 'o' : 'x';
      });
      findwinner(grid[i]);
    }
  }
  bool checkMove(i1,i2,i3,sign){
    if(grid[i1]==sign && grid[i2]==sign && grid[i3]==sign){
      return true;
    }
    return false;

  }

  void findwinner(currentsign){
    if(
    checkMove(0,1,2,currentsign)|| checkMove(3,4,5,currentsign) || checkMove(6,7,8,currentsign) ||
        checkMove(0,3,6,currentsign)|| checkMove(1,4,7,currentsign) || checkMove(2,5,8,currentsign) ||
        checkMove(0,4,8,currentsign)|| checkMove(2,4,6,currentsign)
    ) {
      setState(() {
        winner = currentsign;
        draw = false;
      });
    }else if (grid.indexOf('-') == -1) {
      setState((){
        draw = true;
      });

    }
  }

  void reset(){
    setState((){
      winner = "";
      grid = [
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
        '-',
      ];

    });


  }


  @override
  Widget build(BuildContext context) {
    return ColorfulSafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreenAccent,

          title: Text("Tic Tac Toe",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
            color: Colors.black
          ),
        ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if(winner!="")
                Text("$winner won the game",
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.orange,
                ),
              ),
           if (draw)
              Text("Draw game!",
               style: TextStyle(
                 fontSize: 30,
               color: Colors.orange,
               ),
                 ),




              Container(
                constraints: BoxConstraints(maxHeight: 400, maxWidth: 400,),
                margin: EdgeInsets.all(20),
                color: Colors.black,
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                  itemCount:grid.length ,
                  itemBuilder: (context, index) => Material(
                    color: Colors.teal,
                    child: InkWell(
                      splashColor: Colors.yellowAccent,
                      onTap: ()=>drawxo(index),
                      child: Center(
                        child: Text(grid[index],

                          style: TextStyle(
                            fontSize: 50,
                            color: Colors.purple
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              ElevatedButton.icon(
                  onPressed: reset,
                  icon: Icon(Icons.refresh),
                label: Text("play again",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),


              )
            ],
          ),
        ),


      ),
    );
  }
}

