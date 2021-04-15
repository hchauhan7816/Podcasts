import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:podcasts/views/home.dart';
import 'package:flutter_svg/svg.dart';
import 'package:podcasts/constants.dart';
import 'package:podcasts/services/database.dart';
import 'package:podcasts/views/homeBody.dart';
import 'package:podcasts/views/searchPage.dart';

// SEARCH BAR
class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  DBmethods dbmethods = new DBmethods();
  TextEditingController searchQuery = new TextEditingController();
  QuerySnapshot searchResult;

  initiate() {
    dbmethods.getSearchList(searchQuery.text).then((e) {
      setState(() {
        print(searchQuery.text);
        searchResult = e;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SearchPage(searchList: searchResult)));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 70,
                child: Container(
                  margin: EdgeInsets.only(
                      left: defaultMargin,
                      top: defaultMargin,
                      bottom: defaultMargin),
                  padding: EdgeInsets.symmetric(
                      vertical: defaultPadding / 4, horizontal: defaultPadding),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.45),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20))),
                  child: TextField(
                    controller: searchQuery,
                    decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      icon: SvgPicture.asset("images/icons/search.svg"),
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                      hintText: "Find Podcast",
                    ),
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 35,
                child: GestureDetector(
                  onTap: () {
                    initiate();
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        right: defaultMargin,
                        top: defaultMargin,
                        bottom: defaultMargin),
                    padding: EdgeInsets.symmetric(
                        vertical: defaultPadding / 1.21,
                        horizontal: defaultPadding / 2),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.45),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                    child: Text(
                      "Search",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
