import 'package:flutter/material.dart';
import 'package:minsk8/import.dart';

class AnimationScreen extends StatefulWidget {
  @override
  _AnimationScreenState createState() {
    return _AnimationScreenState();
  }
}

class _AnimationScreenState extends State<AnimationScreen>
    with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _controller;
  bool _visible;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    _visible = false;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animation'),
      ),
      drawer: MainDrawer('/animation'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8.0),
            color: Colors.green.withOpacity(_animation.value),
            child: Text(
              '1111',
              style: TextStyle(
                color: Colors.black.withOpacity(_animation.value),
              ),
            ),
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  if (_visible) {
                    _controller.reverse();
                  } else {
                    _controller.forward();
                  }
                  setState(() {
                    _visible = !_visible;
                  });
                },
                child: Text(_visible ? 'On' : 'Off'),
              ),
              // SizedBox(width: 16.0),
              // RaisedButton(
              //     onPressed: () {
              //       _controller.reverse();
              //       setState(() {
              //         _visible = false;
              //       });
              //     },
              //     child: Text('Off')),
            ],
          ),
        ],
      ),
    );
  }
}
