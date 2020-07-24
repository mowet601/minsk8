import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:provider/provider.dart';
import 'package:minsk8/import.dart';

class HowToPayScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Добавить Золотых'),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _Logo(),
                  _Title(),
                  _Menu(),
                ],
              ),
            ),
            FlatButton(
              child: Text(
                'КАК ЭТО РАБОТАЕТ',
                style: TextStyle(
                  fontSize: kFontSize,
                  color: Colors.black.withOpacity(0.6),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed('/how_it_works');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileModel>(context, listen: false);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'У Вас ${getPluralGold(profile.balance)}',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black.withOpacity(0.8),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          'увеличьте их одним из способов',
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 200,
      child: Stack(
        children: [
          Positioned(
            top: 150 / 2 - kBigButtonIconSize / 2 + 10,
            left: 200 / 2 - kBigButtonIconSize / 2,
            child: Icon(
              FontAwesomeIcons.gift,
              color: Colors.deepOrangeAccent,
              size: kBigButtonIconSize,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 20,
            child: Transform.rotate(
              angle: -.4,
              child: Icon(
                FontAwesomeIcons.book,
                color: Colors.deepOrangeAccent,
                // size: kButtonIconSize,
              ),
            ),
          ),
          Positioned(
            top: 30,
            left: 0,
            child: Transform.rotate(
              angle: -.4,
              child: Icon(
                FontAwesomeIcons.bicycle,
                color: Colors.deepOrangeAccent,
                // size: kButtonIconSize,
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 100,
            child: Transform.rotate(
              angle: .4,
              child: Icon(
                FontAwesomeIcons.chair,
                color: Colors.deepOrangeAccent,
                // size: kButtonIconSize,
              ),
            ),
          ),
          Positioned(
            top: 40,
            right: 0,
            child: Transform.rotate(
              angle: -.4,
              child: Icon(
                FontAwesomeIcons.mobileAlt,
                color: Colors.deepOrangeAccent,
                // size: kButtonIconSize,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 20,
            child: Transform.rotate(
              angle: -.4,
              child: Icon(
                FontAwesomeIcons.wineBottle,
                color: Colors.deepOrangeAccent,
                // size: kButtonIconSize,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Menu extends StatelessWidget {
  final _menu = {
    '/add_unit': [
      'ОТДАЙТЕ ХОРОШИЕ ВЕЩИ',
      'получите за них Золотые от участников'
    ],
    '/invite': ['ПРИГЛАСИТЕ ДРУЗЕЙ', 'получите +1 Золотой за каждого новичка'],
    '/payment': [
      'ПОЛУЧИТЕ БЫСТРО',
      'до +${getPluralGold(kMaxPay)} за поддержку проекта'
    ],
  }.entries.toList();

  @override
  Widget build(BuildContext context) {
    return GlowNotificationWidget(
      ListView.separated(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 16),
        itemCount: _menu.length,
        itemBuilder: (BuildContext context, int index) {
          final entry = _menu[index];
          return Material(
            color: index == _menu.length - 1 ? Colors.red : Colors.white,
            child: InkWell(
              child: ListTile(
                dense: true,
                title: index == _menu.length - 1
                    ? Text(
                        entry.value[0],
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )
                    : Text(entry.value[0]),
                subtitle: index == _menu.length - 1
                    ? Text(
                        entry.value[1],
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      )
                    : Text(entry.value[1]),
                trailing: Icon(
                  Icons.navigate_next,
                  color: index == _menu.length - 1
                      ? Colors.white
                      : Colors.black.withOpacity(0.8),
                  size: kButtonIconSize,
                ),
              ),
              onLongPress: () {}, // чтобы сократить время для splashColor
              onTap: () {
                if (entry.key == '/add_unit') {
                  Navigator.pushNamed(
                    context,
                    '/kinds',
                  ).then((kind) {
                    if (kind == null) return;
                    Navigator.pushNamed(
                      context,
                      '/add_unit',
                      arguments: AddUnitRouteArguments(
                        kind: kind,
                        tabIndex: AddUnitRouteArgumentsTabIndex(),
                      ),
                    );
                  });
                } else {
                  Navigator.of(context).pushNamed(entry.key);
                }
              },
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(height: 8);
        },
      ),
    );
  }
}
