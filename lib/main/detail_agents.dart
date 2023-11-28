import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../data_api/daftar_agents.dart';

class DetailAgents extends StatefulWidget {
  final Data agentsData;

  DetailAgents({required this.agentsData});

  @override
  State<DetailAgents> createState() => _DetailAgentsState();
}

class _DetailAgentsState extends State<DetailAgents> {
  List<bool> favoriteStatusList = List.filled(0, false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(widget.agentsData.displayName ?? "Agents Detail"),
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFBD3944), Color(0xFF000000)])),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Center(
                child: Column(
                  children: [
                    Image.network(widget.agentsData.fullPortrait!),
                    SizedBox(height: 20),
                    Card(
                      color: Color(0xFFdcdcd4),
                      elevation: 10,
                      shadowColor:
                          Colors.white, // Memberikan bayangan pada Card
                      margin: const EdgeInsets.symmetric(
                          horizontal: 25.0), // Memberikan jarak Card
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.agentsData.displayName!,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Center(
                              child: DataTable(
                                columnSpacing: 10, // Jarak antar kolom
                                columns: [
                                  DataColumn(
                                    label: Text(
                                      "Role",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  DataColumn(
                                      label: Text(
                                          "${widget.agentsData.role?.displayName ?? ""}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold))),
                                ],
                                rows: [],
                              ),
                            ),
                            Text(
                              widget.agentsData.description!,
                              style: TextStyle(fontSize: 14),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      widget.agentsData.displayName! + ' Abilities & Skills',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CarouselSlider(
                            items: widget.agentsData.abilities?.map((skill) {
                                  return Card(
                                    elevation: 10,
                                    shadowColor: Colors.white,
                                    color: Color(0xFFdcdcd4),
                                    margin: const EdgeInsets.only(right: 10.0),
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(skill.slot ?? "",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            SizedBox(
                                              width: 60,
                                              height: 60,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(
                                                              0.5), // Warna bayangan
                                                      spreadRadius:
                                                          2, // Penyebaran bayangan
                                                      blurRadius:
                                                          5, // Ketajaman bayangan
                                                    ),
                                                  ],
                                                ),
                                                child: Image.network(
                                                  skill.displayIcon ??
                                                      "URL_Default_Icon",
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(skill.displayName ?? "",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Text(
                                              skill.description ?? "",
                                              style: TextStyle(
                                                fontSize: 12,
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList() ??
                                [],
                            options: CarouselOptions(
                              height: 280,
                              enableInfiniteScroll: false,
                              autoPlay: true,
                              autoPlayAnimationDuration: Duration(seconds: 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

// void showFavoriteSnackbar(bool isFavorite, String skinName) {
//   final snackBarText = isFavorite
//       ? "Skin ditambahkan di Favorite"
//       : "Skin dihapus dari Favorite";
//
//   final snackBar = SnackBar(content: Text(snackBarText));
//   ScaffoldMessenger.of(context).showSnackBar(snackBar);
// }

// String _getHeadDamage(List<DamageRanges>? damageRanges) {
//   // Check if damageRanges is not null and not empty
//   if (damageRanges != null && damageRanges.isNotEmpty) {
//     // Assuming you want to display headDamage from the first element
//     return damageRanges[0].headDamage?.toString() ?? "N/A";
//   } else {
//     return "N/A";
//   }
// }
//
// String _getBodyDamage(List<DamageRanges>? damageRanges) {
//   // Check if damageRanges is not null and not empty
//   if (damageRanges != null && damageRanges.isNotEmpty) {
//     // Assuming you want to display headDamage from the first element
//     return damageRanges[0].bodyDamage?.toString() ?? "N/A";
//   } else {
//     return "N/A";
//   }
// }
//
// String _getLegDamage(List<DamageRanges>? damageRanges) {
//   // Check if damageRanges is not null and not empty
//   if (damageRanges != null && damageRanges.isNotEmpty) {
//     // Assuming you want to display headDamage from the first element
//     return damageRanges[0].legDamage?.toString() ?? "N/A";
//   } else {
//     return "N/A";
//   }
// }
}
