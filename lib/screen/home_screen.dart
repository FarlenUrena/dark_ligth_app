import 'package:app/app_theme.dart';
import 'package:app/screen/component/wire_draw.dart';
import 'package:app/constant/constant.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Offset initialPosition = const Offset(250, 0);
  Offset switchPosition = const Offset(350, 350);
  Offset containerPosition = const Offset(350, 350);
  Offset finalPosition = const Offset(350, 350);

  @override
  void didChangeDependencies() {
    final Size size = MediaQuery.of(context).size;
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    initialPosition = Offset(size.width * .9, 0);
    containerPosition = Offset(size.width * .9, size.height * .4);
    finalPosition = Offset(size.width * .9, size.height * .5 - size.width * .1);
    if (themeProvider.isLightTheme) {
      switchPosition = containerPosition;
    } else {
      switchPosition = finalPosition;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     themeProvider.toggleThemeData();
      //   },
      // ),
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: const Alignment(-0.8, -0.3),
            radius: 1,
            colors: themeProvider.themeMode().gradientColors!,
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            leftPart(size: size, themeProvider: themeProvider),
            Positioned(
              top: containerPosition.dy - size.width * .1 / 2 - 5,
              left: containerPosition.dx - size.width * .1 / 2 - 5,
              child: Container(
                width: size.width * .1 + 10,
                height: size.height * .1 + 10,
                decoration: BoxDecoration(
                  color: themeProvider.themeMode().switchBgColor!,
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            Wire(
              initialPosition: initialPosition,
              toOffset: switchPosition,
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 0),
              top: switchPosition.dy - size.width * 0.1 / 2,
              left: switchPosition.dx - size.width * 0.1 / 2,
              child: Draggable(
                feedback: Container(
                  width: size.width * .1,
                  height: size.width * .1,
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                    shape: BoxShape.rectangle,
                  ),
                ),
                onDragEnd: (details) {
                  if (themeProvider.isLightTheme) {
                    setState(() {
                      switchPosition = containerPosition;
                    });
                  } else {
                    setState(() {
                      switchPosition = finalPosition;
                    });
                  }
                  themeProvider.toggleThemeData();
                },
                onDragUpdate: ((details) => {
                      setState(() {
                        switchPosition = details.localPosition;
                      }),
                    }),
                child: Container(
                  width: size.width * .1,
                  height: size.width * .1,
                  decoration: BoxDecoration(
                    color: themeProvider.themeMode().thumbColor,
                    border: Border.all(
                      width: 5,
                      color: themeProvider.themeMode().switchColor!,
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class leftPart extends StatelessWidget {
  const leftPart({
    super.key,
    required this.size,
    required this.themeProvider,
  });

  final Size size;
  final ThemeProvider themeProvider;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            DateFormat('H').format(DateTime.now()),
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          SizedBox(
            width: size.width * .2,
            child: const Divider(
              height: 0,
              thickness: 1,
              color: AppColors.white,
            ),
          ),
          Text(
            DateFormat('mm').format(DateTime.now()),
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(color: AppColors.white),
          ),
          const Spacer(),
          const Text(
            "Light Dark\nPersonal\nSwitch",
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Container(
            width: size.width * .2,
            height: size.height * .2,
            decoration: BoxDecoration(
              color: themeProvider.themeMode().switchColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.nights_stay_outlined,
              size: 50,
              color: AppColors.white,
            ),
          ),
          SizedBox(
            width: size.width * .2,
            child: const Divider(
              //height: 0,
              thickness: 1,
              color: AppColors.white,
            ),
          ),
          Text(
            "30\u00B0C",
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(color: AppColors.white),
          ),
          Text(
            "Clear",
            style: Theme.of(context).textTheme.headlineSmall!,
          ),
          Text(
            DateFormat('EEEE').format(DateTime.now()),
            style: Theme.of(context).textTheme.headlineSmall!,
          ),
          Text(
            DateFormat('MMMM d').format(DateTime.now()),
            style: Theme.of(context).textTheme.headlineSmall!,
          ),
        ]),
      ),
    );
  }
}
