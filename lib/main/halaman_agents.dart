import 'package:flutter/material.dart';
import '../data_api/api_data_souce.dart';
import '../data_api/daftar_agents.dart';
import '../fitur/clock.dart';
import '../models_hive/fav.dart';
import 'detail_agents.dart';

class HalamanAgents extends StatefulWidget {
  const HalamanAgents({Key? key}) : super(key: key);

  @override
  _HalamanAgentsState createState() => _HalamanAgentsState();
}

class _HalamanAgentsState extends State<HalamanAgents> {
  String favName = "APA";
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFBD3944), Color(0xFF000000)]
            )
        ),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30,),
                  Center(
                    child: SizedBox(
                      height: 140,
                      child: Image.network(
                        "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fc/Valorant_logo_-_pink_color_version.svg/2560px-Valorant_logo_-_pink_color_version.svg.png",
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Center(
                      child: Text(
                        'Welcome to VIP',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            color: Colors.white),
                      )
                  ),
                  Center(
                    child: Text(
                      'Valorant Information Page',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Center(
                    child: Text(
                      'Provides information about Valorant. Find your favorite Agent and find out the information',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Center(
                    child: SizedBox(
                      height: 30,
                      width: 150,
                      child: Container(
                        child: Jam(),
                      ),
                    ),
                  ),
                  SizedBox(height: 30,)
                ],
              ),
            ),
            _buildDaftarAgentsBody(),
          ],
        ),
      ),
    );
  }

  Widget _buildDaftarAgentsBody() {
    return FutureBuilder(
      future: ApiDataSourceAgents.instance.loadAgents(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          return _buildErrorSection();
        } else if (snapshot.hasData) {
          DaftarAgents daftarAgents = DaftarAgents.fromJson(snapshot.data);
          return _buildSuccessSection(daftarAgents);
        }
        return _buildLoadingSection();
      },
    );
  }

  Widget _buildErrorSection() {
    return Text("Error");
  }

  Widget _buildSuccessSection(DaftarAgents daftarAgents) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: daftarAgents.data!.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildItemUsers(context, daftarAgents.data![index]);
      },
    );
  }

  Widget _buildLoadingSection() {
    return Center(
      child: Image.network(
        'https://media.tenor.com/1_EIhMNuXRAAAAAd/omen-valorant.gif',
        fit: BoxFit.cover,
        width: 300,
        height: 300,
      ),
    );
  }

  Widget _buildItemUsers(BuildContext context, Data agentsData) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailAgents(agentsData: agentsData),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
        child: Card(
          elevation:10,
          shadowColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          color: Color(0xFFdcdcd4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  width: 600,
                  height: 200,
                  child: Image.network(agentsData.displayIcon!),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    agentsData.displayName!,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16
                    ),
                  ),
                  SizedBox(width: 10),
                  FavoriteIcon(agentsData: agentsData),
                ],
              ),
              SizedBox(height: 10,),
            ],
          ),
        ),
      ),
    );
  }
}
class FavoriteIcon extends StatefulWidget {
  final Data agentsData;

  FavoriteIcon({required this.agentsData});

  @override
  _FavoriteIconState createState() => _FavoriteIconState();
}

class _FavoriteIconState extends State<FavoriteIcon> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkIsFavorite();
  }

  //fixed bug, tadinya senjata yang difavorite saat direload icon berubah tapi list masih ada
  Future<void> _checkIsFavorite() async {
    final favorites = await FavoriteProvider().getFavorites();
    setState(() {
      isFavorite = favorites
          .any((favorite) => favorite.displayName == widget.agentsData.displayName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: isFavorite ? Colors.red : null,
      ),
      onPressed: () async {
        setState(() {
          isFavorite = !isFavorite;
        });

        final snackBarText = isFavorite
            ? "Success added to Favorite Agents"
            : "Success deleted from Favorite Agents";

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(snackBarText),
            duration: Duration(seconds: 1),
          ),
        );

        final favoriteProvider = FavoriteProvider();
        if (isFavorite) {
          await favoriteProvider.addToFavorites(
              widget.agentsData.displayName!, widget.agentsData.displayIcon!);
        } else {
          await favoriteProvider.removeFromFavorites(widget.agentsData.displayName!);
        }
      },
    );
  }
}

