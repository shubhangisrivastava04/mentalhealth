import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MentalHealthApp());
}

class MentalHealthApp extends StatefulWidget 
{
  @override
  _MentalHealthAppState createState() => _MentalHealthAppState();

}

class _MentalHealthAppState extends State<MentalHealthApp>
{
  @override 
  Widget build(BuildContext context)
  {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mental Health App',
      home: LoginScreen()
    );
  }
}

class LoginScreen extends StatelessWidget
{
  final TextEditingController _userController = TextEditingController();

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign in"),
        backgroundColor: Colors.lightBlue[100],
      ),
      body: Stack(
        children: [
          RiveAnimation.asset('assets/dory_demo.riv',
          fit: BoxFit.cover),
          Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _userController,
              decoration: InputDecoration(labelText: "Enter Your Name", labelStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600)),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              child: Text('Continue', style: TextStyle(color: Colors.white),),
              
              onPressed: () {
                String username = _userController.text;
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage(username: username))
                );          
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 144, 208, 237))
              ),
            )
          ],
        )
      )

     ]
        
    ));
  }
}

Map<String, List<Uri>> moodSongs = {
  'happy': [
    Uri.parse('https://open.spotify.com/playlist/37i9dQZF1EIgG2NEOhqsD7?si=8tExcGSDSR6bhm4-RcE01Q&pi=a-gxGaDxLCSpKY'), //feel good
    Uri.parse('https://open.spotify.com/playlist/37i9dQZF1EIeEZPgsd7pko?si=SxjkgY2_RO6q7pDB-sx96Q&pi=a-zZFsRjB0S5aj'), //energetic
    Uri.parse('https://open.spotify.com/playlist/37i9dQZF1EIgNoWOvbnUCk?si=5YBk1pJmSSi_R_Dpo_td5A&pi=a-p6Y0NhnBRx2R'), //good mood
  ],
  'calm': [
     Uri.parse('https://open.spotify.com/playlist/37i9dQZF1EIfTmpqlGn32s?si=1b74e59f60494119'),     //calm relaxing mix
     Uri.parse('https://open.spotify.com/playlist/37i9dQZF1EIcNUtFW3CJZc?si=a68ff80404174846'),     //soft mix
     Uri.parse('https://open.spotify.com/playlist/37i9dQZF1EIgZ4krjKXewt?si=853ac30bd84d41c9'),     //calm gentle mix
  ],
  'upset': [
    Uri.parse('https://open.spotify.com/playlist/37i9dQZF1EIh7odv9xOtA0?si=ca87467395a840e2'),    //sad soft mix
    Uri.parse('https://open.spotify.com/playlist/37i9dQZF1EIgQSl88QXPwP?si=74af9e57ff2c44b4'),    //quiet sad mix
    Uri.parse('https://open.spotify.com/playlist/37i9dQZF1EIhMKkmqL8Byi?si=0350c59a4d9f40ab'),    //comforting sad mix
  ],
  'anxious': [
    Uri.parse('https://open.spotify.com/playlist/37i9dQZF1EIg42NGihn0NZ?si=0f2d59042e0e4c3e'),    //anti anxiety mix
    Uri.parse('https://open.spotify.com/playlist/37i9dQZF1EIeNoBMmwUjGA?si=ac50a185ac794eb9'),    //angst mix
    Uri.parse('https://open.spotify.com/playlist/37i9dQZF1EVKuMoAJjoTIw?si=919e214291004103'),    //moody mix
  ],
  'annoyed': [
    Uri.parse('https://open.spotify.com/playlist/37i9dQZF1EIdUlw9vCCjcD?si=3e9e0b9ffc82434d'),    //annoyed mix
    Uri.parse('https://open.spotify.com/playlist/37i9dQZF1EIhuCNl2WSFYd?si=9c45a19c6e01485b'),    //rage mix
    Uri.parse('https://open.spotify.com/playlist/37i9dQZF1EIgTgrTnECAde?si=97799842f7704878'),    //annoyed rock mix
  ],
};

Map<String, String> moodQuotes = {
  'happy': "Happiness is not something ready-made. It comes from your own actions. - Dalai Lama",
  'calm': "Calmness is the cradle of power. - Josiah Gilbert Holland",
  'upset': "You don't have to control your thoughts. You just have to stop letting them control you. - Dan Millman",
  'anxious': "You don't have to see the whole staircase, just take the first step. - Martin Luther King Jr.",
  'annoyed': "Don't let the behavior of others destroy your inner peace. - Dalai Lama",
};

class Option {
  final String title;
  final Widget page;

  Option({required this.title, required this.page});
}

class HomePage extends StatefulWidget
{
  final String username;
  HomePage({required this.username});
  @override
  _HomePage createState() => _HomePage(username: username);
  
}

class _HomePage extends State<HomePage>
{
  final String username;
  _HomePage({required this.username});
  final List<Option> options= [
    Option (
      title: 'happy',
      page: HappyPage()
    ),
    Option (
      title: 'calm',
      page: CalmPage()
    ),
    Option (
      title: 'upset',
      page: UpsetPage()
    ),
    Option (
      title: 'anxious',
      page: AnxiousPage()
    ),
    Option (
      title: 'annoyed',
      page: AnnoyedPage()
    )

  ];
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/moodbg.png'),
          fit: BoxFit.fill)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 35.0,
              child: Text("hi $username,", style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.w400)),
            ),
            SizedBox(height: 50.0,
            child: Text('how are you feeling today?', style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.w600),),
            ),
            SizedBox(
              height: 70.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(10.0),
                    child: ClipRRect(
                      
                    borderRadius: BorderRadius.circular(30.0),
                    child: Container(
                      width: 55.0,
                      child: InkWell(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context)=>(options[index].page))
                          );
                        },
                        child: Image.asset(
                          'assets/mood$index.png',
                          fit: BoxFit.fill,
                        ),
                      )
                    ),
                    )
                  );
                },
              )
            )
          ],
        ),
      ),
    );
  }
}

class HappyPage extends StatefulWidget {
  @override
  _HappyPage createState() => _HappyPage();
}

class _HappyPage extends State<HappyPage> {
  List<Uri> happyplaylists = moodSongs['happy'] ?? [];
  String quote = moodQuotes['happy'] ?? '';

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('happy'),
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/moodbg.png',
            fit: BoxFit.cover,
            width: screenWidth,
            height: screenHeight,
          ),
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.05), // Responsive padding
            child: Column(
              children: <Widget>[
                Text(
                  quote,
                  style: TextStyle(
                    fontSize: screenWidth * 0.05, // Responsive font size
                    fontStyle: FontStyle.italic,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenHeight * 0.03), // Responsive spacing
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(screenWidth * 0.05),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25.0),
                      child: Container(
                        height: screenHeight * 0.25, // Responsive height
                        width: screenWidth * 0.8, // Responsive width
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => JournalPage()),
                            );
                          },
                          child: Image.asset(
                            'assets/journalbg.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.05), // Responsive spacing
                SizedBox(
                  height: screenHeight * 0.06, // Responsive height
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "music: ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: screenWidth * 0.06, // Responsive font size
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.3, // Responsive height
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: happyplaylists.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.all(screenWidth * 0.045),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25.0),
                          child: Container(
                            width: screenWidth * 0.4, // Responsive width
                            child: InkWell(
                              onTap: () {
                                launchUrl(happyplaylists[index]);
                              },
                              child: Image.asset(
                                'assets/happymusic$index.png',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class CalmPage extends StatefulWidget
{
  @override
  _CalmPage createState() => _CalmPage();
}

class _CalmPage extends State<CalmPage>
{
  List<Uri> calmplaylists = moodSongs['calm'] ?? [];
  String quote = moodQuotes['calm'] ?? '';

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('calm'),
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/moodbg.png',
            fit: BoxFit.cover,
            width: screenWidth,
            height: screenHeight,
          ),
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.05), // Responsive padding
            child: Column(
              children: <Widget>[
                Text(
                  quote,
                  style: TextStyle(
                    fontSize: screenWidth * 0.05, // Responsive font size
                    fontStyle: FontStyle.italic,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenHeight * 0.03), // Responsive spacing
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(screenWidth * 0.05),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25.0),
                      child: Container(
                        height: screenHeight * 0.25, // Responsive height
                        width: screenWidth * 0.8, // Responsive width
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => JournalPage()),
                            );
                          },
                          child: Image.asset(
                            'assets/journalbg.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.05), // Responsive spacing
                SizedBox(
                  height: screenHeight * 0.06, // Responsive height
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "music: ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: screenWidth * 0.06, // Responsive font size
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.3, // Responsive height
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: calmplaylists.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.all(screenWidth * 0.045),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25.0),
                          child: Container(
                            width: screenWidth * 0.4, // Responsive width
                            child: InkWell(
                              onTap: () {
                                launchUrl(calmplaylists[index]);
                              },
                              child: Image.asset(
                                'assets/calmmusic$index.png',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class UpsetPage extends StatefulWidget
{
  @override
  _UpsetPage createState() => _UpsetPage();
}

class _UpsetPage extends State<UpsetPage>
{
  List<Uri> upsetplaylists = moodSongs['upset'] ?? [];
  String quote = moodQuotes['upset'] ?? '';

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('upset'),
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/moodbg.png',
            fit: BoxFit.cover,
            width: screenWidth,
            height: screenHeight,
          ),
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.05), // Responsive padding
            child: Column(
              children: <Widget>[
                Text(
                  quote,
                  style: TextStyle(
                    fontSize: screenWidth * 0.05, // Responsive font size
                    fontStyle: FontStyle.italic,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenHeight * 0.03), // Responsive spacing
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(screenWidth * 0.05),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25.0),
                      child: Container(
                        height: screenHeight * 0.25, // Responsive height
                        width: screenWidth * 0.8, // Responsive width
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => JournalPage()),
                            );
                          },
                          child: Image.asset(
                            'assets/journalbg.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.05), // Responsive spacing
                SizedBox(
                  height: screenHeight * 0.06, // Responsive height
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "music: ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: screenWidth * 0.06, // Responsive font size
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.3, // Responsive height
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: upsetplaylists.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.all(screenWidth * 0.045),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25.0),
                          child: Container(
                            width: screenWidth * 0.4, // Responsive width
                            child: InkWell(
                              onTap: () {
                                launchUrl(upsetplaylists[index]);
                              },
                              child: Image.asset(
                                'assets/upsetmusic$index.png',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AnxiousPage extends StatefulWidget
{
  @override
  _AnxiousPage createState() => _AnxiousPage();
}

class _AnxiousPage extends State<AnxiousPage>
{
  List<Uri> anxiousplaylists = moodSongs['anxious'] ?? [];
  String quote = moodQuotes['anxious'] ?? '';

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('anxious'),
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/moodbg.png',
            fit: BoxFit.cover,
            width: screenWidth,
            height: screenHeight,
          ),
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.05), // Responsive padding
            child: Column(
              children: <Widget>[
                Text(
                  quote,
                  style: TextStyle(
                    fontSize: screenWidth * 0.05, // Responsive font size
                    fontStyle: FontStyle.italic,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenHeight * 0.03), // Responsive spacing
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(screenWidth * 0.05),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25.0),
                      child: Container(
                        height: screenHeight * 0.25, // Responsive height
                        width: screenWidth * 0.8, // Responsive width
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => JournalPage()),
                            );
                          },
                          child: Image.asset(
                            'assets/journalbg.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.05), // Responsive spacing
                SizedBox(
                  height: screenHeight * 0.06, // Responsive height
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "music: ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: screenWidth * 0.06, // Responsive font size
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.3, // Responsive height
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: anxiousplaylists.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.all(screenWidth * 0.045),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25.0),
                          child: Container(
                            width: screenWidth * 0.4, // Responsive width
                            child: InkWell(
                              onTap: () {
                                launchUrl(anxiousplaylists[index]);
                              },
                              child: Image.asset(
                                'assets/anxiousmusic$index.png',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class AnnoyedPage extends StatefulWidget
{
  @override
  _AnnoyedPage createState() => _AnnoyedPage();
}

class _AnnoyedPage extends State<AnnoyedPage>
{
  List<Uri> annoyedplaylists = moodSongs['annoyed'] ?? [];
  String quote = moodQuotes['annoyed'] ?? '';

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('annoyed'),
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/moodbg.png',
            fit: BoxFit.cover,
            width: screenWidth,
            height: screenHeight,
          ),
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.05), // Responsive padding
            child: Column(
              children: <Widget>[
                Text(
                  quote,
                  style: TextStyle(
                    fontSize: screenWidth * 0.05, // Responsive font size
                    fontStyle: FontStyle.italic,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenHeight * 0.03), // Responsive spacing
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(screenWidth * 0.05),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25.0),
                      child: Container(
                        height: screenHeight * 0.25, // Responsive height
                        width: screenWidth * 0.8, // Responsive width
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => JournalPage()),
                            );
                          },
                          child: Image.asset(
                            'assets/journalbg.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.05), // Responsive spacing
                SizedBox(
                  height: screenHeight * 0.06, // Responsive height
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "music: ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: screenWidth * 0.06, // Responsive font size
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.3, // Responsive height
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: annoyedplaylists.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.all(screenWidth * 0.045),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25.0),
                          child: Container(
                            width: screenWidth * 0.4, // Responsive width
                            child: InkWell(
                              onTap: () {
                                launchUrl(annoyedplaylists[index]);
                              },
                              child: Image.asset(
                                'assets/annoyedmusic$index.png',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class JournalPage extends StatefulWidget {
  @override
  _JournalPageState createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage> {
  List<String> tasks = [];
  List<Color> taskColors = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Journal"),
        backgroundColor: Colors.purple[100],
      ),
      body: Stack(
        children: [
          RiveAnimation.asset(
            'assets/happybg.riv',
            fit: BoxFit.cover,
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return Container(
                  child: ClipRRect(borderRadius: BorderRadius.circular(25.0),
                  child: Container(
                  decoration: BoxDecoration(
                    color: Colors.purple[100 * (index + 1)],
                  ),
                  child: ListTile(
                    title: Center(
                      child: Text(
                        tasks[index],
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),)
                ));
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AddEntryScreen(
                onEntryAdded: (entry) {
                  setState(() {
                    taskColors.add(Color.fromARGB(255, 200, 200, 200));
                    tasks.add(entry);
                  });
                },
              );
            },
          );
        },
        backgroundColor: Colors.purple[100],
        child: Icon(Icons.add, color: Colors.white, size: 40),
      ),
    );
  }
}


class AddEntryScreen extends StatelessWidget {
  final Function(String) onEntryAdded;

  const AddEntryScreen({Key? key, required this.onEntryAdded})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    double dialogHeight = isLandscape ? screenHeight * 0.7 : screenHeight * 0.3;

    String entry = '';

    return Dialog(
        child: SizedBox(
            width: screenWidth * 0.8,
            height: dialogHeight,
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
                child: Scaffold(
                    appBar: AppBar(title: Text("Add Entry")),
                    body: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextField(
                              decoration:
                                  InputDecoration(labelText: 'Pen down your thoughts'),
                              onChanged: (value) {
                                entry = value;
                              },
                            ),
                            MaterialButton(
                                color: Colors.black,
                                child: Text('Save',
                                    style: TextStyle(color: Colors.white)),
                                onPressed: () {
                                  onEntryAdded(entry);
                                  Navigator.pop(context);
                                })
                          ],
                     ))))));
}
}