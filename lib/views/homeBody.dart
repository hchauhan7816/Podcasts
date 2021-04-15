import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:podcasts/constants.dart';
import 'package:podcasts/services/database.dart';
import 'package:podcasts/widgets/audioCard.dart';
import 'package:podcasts/widgets/searchBar.dart';

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  DBmethods dbmethods = new DBmethods();
  Stream allPodcasts;

  @override
  void initState() {
    dbmethods.getAllPodcastsLink().then((val) {
      setState(() {
        allPodcasts = val;
      });
    });
    super.initState();
  }

  Widget podcastsList() {
    return StreamBuilder(
      stream: allPodcasts,
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return CircularProgressIndicator();
        }

        return ListView.builder(
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index) {
            return PodcastCard(
              p_link: snapshot.data.docs[index].data()["p_link"],
              p_name: snapshot.data.docs[index].data()["p_name"],
              p_image: snapshot.data.docs[index].data()["p_image"],
              d_image: snapshot.data.docs[index].data()["d_image"],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SearchBar(),
          // SizedBox(height: defaultPadding),
          Expanded(
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 80),
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40)),
                  ),
                ),
                podcastsList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
