import 'dart:io';
import 'package:competitive_exam_app/Screens/Add%20Bank%20Details/BnkDtls_screen.dart';
import 'package:competitive_exam_app/Screens/Dashboard/SellerProdile.dart';
import 'package:competitive_exam_app/Screens/Dashboard/TearmsCondition.dart';
import 'package:competitive_exam_app/Screens/Exam/Exam_screen.dart';
import 'package:competitive_exam_app/Screens/Login/components/Slider.dart';
import 'package:competitive_exam_app/Screens/Profile/Profile_screen.dart';
import 'package:competitive_exam_app/Screens/QuestionBank/QBank_screen.dart';
import 'package:competitive_exam_app/Screens/Result/Result_screen.dart';
import 'package:competitive_exam_app/Screens/Wallet/Wallet_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:competitive_exam_app/Screens/Dashboard/Dashboard_screen.dart';
import 'package:competitive_exam_app/Screens/Login/login_screen.dart';
import 'package:competitive_exam_app/Utils/Constant.dart';
import 'Screens/Welcome/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
String selectedNotificationPayload;

class BusDev extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GoogleSignIn().signOut();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Dashboard",
      home: Constants.prefs.getBool("loggedIn") == true
          ? DashBoardScreen()
          : WelcomeScreen(),
      // home: DashBoardScreen(),
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      routes: {
        "/dashBoard": (context) => DashBoardScreen(),
        "/LoginScreen": (context) => LoginScreen(),
        "/Profile": (context) => Profile(),
        "/Exam": (context) => ExamScreen(),
        "/wallet": (context) => Wallet(),
        "/Result": (context) => Result(),
        "/BankDtls": (context) => BnkDtls(),
        "/SellerProfile": (context) => SellerProfile(),
        "/TearmCondition": (context) => TearmsCondition(),
        "/Sliders": (context) => Sliders(),
        "/QBank": (context) => QBank(),
      },
      // initialRoute: initialRoute,
      // routes: <String, WidgetBuilder>{
      //   HomePage.routeName: (_) => HomePage(notificationAppLaunchDetails),
      //   SecondPage.routeName: (_) => SecondPage(selectedNotificationPayload)
      // },
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> _configureLocalTimeZone() async {
  if (kIsWeb || Platform.isLinux) {
    return;
  }
  tz.initializeTimeZones();
  final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(timeZoneName));
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _configureLocalTimeZone();
//  print('object');
   await Firebase.initializeApp(
    name: 'questionking1-ad7d6',
    options: DefaultFirebaseOptions.currentPlatform,
   );

  final NotificationAppLaunchDetails notificationAppLaunchDetails = !kIsWeb &&
          Platform.isLinux
      ? null
      : await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
  );

 // print("init messagin");
  initMessaging();

  // String initialRoute = HomePage.routeName;
  // if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
  //   selectedNotificationPayload = notificationAppLaunchDetails.payload;
  //   initialRoute = SecondPage.routeName;
  Constants.prefs = await SharedPreferences.getInstance();
  HttpOverrides.global = new MyHttpOverrides();
  // MobileAds.instance.initialize();
  runApp(BusDev());
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
 // print("MESSAGE :- " + message.data.toString());

  RemoteNotification notificationMessage = message.notification;

  if (notificationMessage != null) {
    showNotification(
      notificationMessage.title,
      notificationMessage.body
    );
  }
}

initMessaging() async {
  FirebaseMessaging _fcm = FirebaseMessaging.instance;

  await _fcm.setForegroundNotificationPresentationOptions(
      alert: true, badge: true, sound: true);

  String fcmToken = await _fcm.getToken();

  print("fcmToken : " + fcmToken);

  try {
    await _fcm.subscribeToTopic("notification_topic");
  } catch (error) {
    print("error : " + error.toString());
  }
  _fcm.getInitialMessage().then((value) {
    //when app is termeinated and user click on notification we get value of notification here
  });

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  FirebaseMessaging.onMessage.listen(
    (RemoteMessage message) {
      print("MESSAGE 123:- " + message.toString());

      RemoteNotification notificationMessage = message.notification;

      if (notificationMessage != null) {
        showNotification(
          notificationMessage.title,
          notificationMessage.body,
        );
      }
    },
  );

  FirebaseMessaging.onMessageOpenedApp.listen(
    (RemoteMessage message) {
      // when app is in background not terminated and user click on notification we get value of notification here

      //  Map<String, dynamic> notification = message.data;

      //  Navigator.pushReplacementNamed(context, "/dashBoard");

      //  setupLocator();
      //  NavigationService _navigationService = locator<NavigationService>();
      //  _navigationService.clearStackAndShow(Routes.itemView);
      //  _navigationService.navigateTo(Routes.notificationView);
    },
  );
}

showNotification(String title, String description) async {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
          'question_kin_8923_channel', 'Question king updates',
          channelDescription: 'Question king updates',
          importance: Importance.max,
          priority: Priority.high);

  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
      0, title, description, platformChannelSpecifics);
}
