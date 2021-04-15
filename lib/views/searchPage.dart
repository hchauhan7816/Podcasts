import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:podcasts/services/database.dart';
import 'package:podcasts/widgets/audioCard.dart';
import 'package:podcasts/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchPage extends StatefulWidget {
  final QuerySnapshot searchList;
  SearchPage({this.searchList});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Widget podcastsList1() {
    return widget.searchList.docs.length != 0
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: widget.searchList.docs.length,
            itemBuilder: (context, index) {
              return PodcastCard(
                p_link: widget.searchList.docs[index].data()["p_link"],
                p_name: widget.searchList.docs[index].data()["p_name"],
                p_image: widget.searchList.docs[index].data()["p_image"],
                d_image: widget.searchList.docs[index].data()["d_image"],
              );
            },
          )
        : Column(
            children: [
              SizedBox(height: 150),
              Center(
                child: Text(
                  "No Podcast Found",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
                ),
              ),
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Text(
            "Back",
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        backgroundColor: backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset("images/icons/back.svg"),
          padding: EdgeInsets.only(left: defaultPadding),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        child: Stack(
          children: [
            SizedBox(height: 25),
            podcastsList1(),
          ],
        ),
      ),
    );
  }
}
