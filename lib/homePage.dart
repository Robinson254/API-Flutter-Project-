import 'dart:convert';

import 'package:fifa/model/team.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http ;

class HomePage extends StatefulWidget {
   HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Team>teams=[];

  Future getTeams()async{
    var response =await http.get(Uri.https('balldontlie.io', 'api/v1/teams'));
    var jsonData=jsonDecode(response.body);

    for (var eachTeam in jsonData['data']){
      final team = Team(
          abbreviation: eachTeam['abbreviation'],
          city: eachTeam['city'],
          id: eachTeam['id'],
          name: eachTeam['name'],
          full_name: eachTeam['full_name'],
          division: eachTeam['division'],
          conference: eachTeam['conference'],
         );
         teams.add(team);
    }
    print(teams.length);
  }

  @override
  Widget build(BuildContext context) {
    getTeams();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        leading: Icon(Icons.more_vert,color: Colors.white,),
        title: Text("NBR Basketball Teams",style: TextStyle(color: Colors.green[100],fontWeight: FontWeight.w400,fontSize: 15),),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.search,color: Colors.white,),
          ),
          Icon(Icons.notifications,color: Colors.white,),
        ],
      ),
      body: FutureBuilder(
        future: getTeams(),
        builder:(context, snapshot) {
          //is it done  loading?show team data
          if(snapshot.connectionState==ConnectionState.done){
            return 
            ListView.builder(
              itemCount: teams.length,
              itemBuilder: (context,index){
                return SingleChildScrollView(
                  child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 130, 217, 137),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                       Text(teams[index].id.toString()),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            
                            Text(teams[index].abbreviation),
                            Text(teams[index].city),
                          ],
                        ),
                        Column(
                          children: [
                            Text(teams[index].conference),
                            Text(teams[index].division),
                          ],
                        ),
                        Column(
                          children: [
                            Text(teams[index].name),
                            Text(teams[index].full_name),
                          ],
                        )
                      ],
                      
                    ),
                  ),
                  
                );
              
                     });
               
        
          }
          //if its still loading show a  loading circularprogress indicator
          else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}