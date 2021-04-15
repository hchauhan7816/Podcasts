import 'package:flutter/material.dart';
import 'package:podcasts/constants.dart';
import 'package:podcasts/views/podcastScreen.dart';
import 'package:podcasts/widgets/widget.dart';
import 'dart:math' as math;

class PodcastCard extends StatelessWidget {
  final String p_link, p_name, p_image, d_image;
  PodcastCard({this.p_link, this.p_name, this.p_image, this.d_image});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.symmetric(horizontal: cardMargin, vertical: cardMargin),
      height: 120,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color((math.Random().nextDouble() * 0xFF0277BD).toInt())
                  .withOpacity(1.0),
              boxShadow: [shadowProp],
            ),
            child: Container(
              margin: EdgeInsets.only(right: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Container(
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20)),
                      child: Image.network(
                        d_image,
                        fit: BoxFit.fill,
                        width: 160,
                        height: 140,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              bottomRight: Radius.circular(20)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Spacer(),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: defaultPadding * 1.5,
                                  vertical: defaultPadding / 2),
                              width: MediaQuery.of(context).size.width,
                              // color: Colors.blue,
                              child: Text(
                                p_name,
                                style: heading1(),
                              ),
                            ),
                            Spacer(),
                            Container(
                              padding: EdgeInsets.only(
                                  left: defaultPadding, top: defaultPadding),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Player(
                                        p_link: p_link,
                                        p_name: p_name,
                                        p_image: p_image,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: defaultPadding * 2.5,
                                      vertical: defaultPadding / 2),
                                  decoration: BoxDecoration(
                                    color: secondaryColor,
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(20),
                                        topLeft: Radius.circular(20)),
                                  ),
                                  child: Text(
                                    "Play",
                                    style: heading2(),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
