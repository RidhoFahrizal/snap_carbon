import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart'; // Tambahkan ini
import 'package:snapcarbon/routes/router.dart';

@RoutePage()
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [
        HomeRoute(),
        ChallengeRoute(),
        CameraRoute(),
        HistoryRoute(),
        ProfileRoute(),
      ],
      transitionBuilder: (context, child, animation) {
        return child;
      },
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          extendBody: true,
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: tabsRouter.activeIndex,
            onTap: tabsRouter.setActiveIndex,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.green,
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(icon: Icon(Iconsax.home), label: 'Home'),
              BottomNavigationBarItem(
                icon: Icon(Iconsax.medal),
                label: 'Challenge',
              ),
              BottomNavigationBarItem(
                icon: Icon(Iconsax.camera),
                label: 'Camera',
              ),
              BottomNavigationBarItem(
                icon: Icon(Iconsax.clock),
                label: 'History',
              ),
              BottomNavigationBarItem(
                icon: Icon(Iconsax.user),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }
}
