import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode: ThemeMode.light,
      theme: NeumorphicThemeData(
        baseColor: Color(0xFFFFFFFF),
        lightSource: LightSource.topLeft,
        depth: 10,
      ),
      darkTheme: NeumorphicThemeData(
        baseColor: Color(0xFF3E3E3E),
        lightSource: LightSource.topLeft,
        depth: 6,
      ),
      home: MyHomePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController licenseController = TextEditingController();
  final List<String> licenseTypes = ['Standard', 'Avancé'];
  String userType =
      ''; // Ajout d'une variable pour stocker le type d'utilisateur

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page de profil'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: firstNameController,
              decoration: InputDecoration(
                hintText: 'Prénom',
              ),
            ),
            TextField(
              controller: lastNameController,
              decoration: InputDecoration(
                hintText: 'Nom',
              ),
            ),
            TextField(
              controller: ageController,
              decoration: InputDecoration(
                hintText: 'Âge',
              ),
            ),
            TextField(
              controller: addressController,
              decoration: InputDecoration(
                hintText: 'Adresse / Ville',
              ),
            ),
            DropdownButton<String>(
              value: licenseController.text.isNotEmpty &&
                      licenseTypes.contains(licenseController.text)
                  ? licenseController.text
                  : null,
              hint: Text('Type de license'),
              onChanged: (newValue) {
                setState(() {
                  licenseController.text = newValue!;
                  // Définir le type d'utilisateur en fonction de la licence sélectionnée
                  if (newValue == 'Standard') {
                    userType = 'Utilisateur standard';
                  } else if (newValue == 'Avancé') {
                    userType = 'Utilisateur avancé';
                  }
                });
              },
              items: licenseTypes.map((licenseType) {
                return DropdownMenuItem<String>(
                  value: licenseType,
                  child: Text(licenseType),
                );
              }).toList(),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              child: Text('Enregistrer'),
              onPressed: () {
                // Ajouter ici le code pour enregistrer les informations de profil
                print(
                    'Type d\'utilisateur : $userType'); // Afficher le type d'utilisateur associé à la licence
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Profil Enregistré'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page d'accueil"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: NeumorphicButton(
                child: Text('Se connecter'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: NeumorphicButton(
                child: Text('S\'inscrire'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => InscriptionPage()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ResetPasswordScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Réinitialiser le mot de passe'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Adresse e-mail',
              ),
            ),
            SizedBox(height: 16.0),
            NeumorphicButton(
              child: Text('Envoyer le lien de réinitialisation'),
              onPressed: () {
                print(emailController.text);
                // Ajoutez ici le code pour envoyer le lien de réinitialisation du mot de passe
                String email = emailController.text;
                if (email.isNotEmpty) {
                  // Ajoutez ici le code pour envoyer l'e-mail de réinitialisation du mot de passe
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Veuillez saisir votre adresse e-mail'),
                  ));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class InscriptionPage extends StatefulWidget {
  @override
  _InscriptionPageState createState() => _InscriptionPageState();
}

class _InscriptionPageState extends State<InscriptionPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool isEmailValid = true;
  bool isPasswordValid = true;
  bool isConfirmPasswordValid = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page d\'inscription'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'Email',
                errorText: isEmailValid ? null : 'Veuillez entrer votre email',
              ),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Mot de passe',
                errorText: isPasswordValid
                    ? null
                    : 'Veuillez entrer votre mot de passe',
              ),
            ),
            TextField(
              controller: confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Confirmer le mot de passe',
                errorText: isConfirmPasswordValid
                    ? null
                    : 'Les mots de passe ne correspondent pas',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: NeumorphicButton(
                    child: Text('Annuler'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: NeumorphicButton(
                    child: Text('S\'inscrire'),
                    onPressed: () {
                      print(emailController.text);
                      print(passwordController.text);
                      setState(() {
                        isEmailValid = emailController.text.isNotEmpty;
                        isPasswordValid = passwordController.text.isNotEmpty;
                        isConfirmPasswordValid = passwordController.text ==
                            confirmPasswordController.text;
                      });

                      if (isEmailValid &&
                          isPasswordValid &&
                          isConfirmPasswordValid) {
                        // Ajoutez ici le code pour valider les textes
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Veuillez remplir tous les champs'),
                        ));
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isEmailValid = true;
  bool isPasswordValid = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page de connexion'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'Email',
                errorText: isEmailValid ? null : 'Veuillez entrer votre email',
              ),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Mot de passe',
                errorText: isPasswordValid
                    ? null
                    : 'Veuillez entrer votre mot de passe',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                NeumorphicButton(
                  child: Text('Annuler'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                NeumorphicButton(
                  child: Text('Mot de passe oublié'),
                  onPressed: () {
                    // Ajoutez ici le code pour afficher un nouvel écran pour la réinitialisation du mot de passe
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ResetPasswordScreen()),
                    );
                  },
                ),
                NeumorphicButton(
                  child: Text('Se connecter'),
                  onPressed: () {
                    print(emailController.text);
                    print(passwordController.text);
                    setState(() {
                      isEmailValid = emailController.text.isNotEmpty;
                      isPasswordValid = passwordController.text.isNotEmpty;
                    });
                    if (isEmailValid && isPasswordValid) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfilePage()),
                      ); // Ajoutez ici le code pour valider les textes
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Veuillez remplir tous les champs'),
                      ));
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
