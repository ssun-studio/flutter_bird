// Importing necessary Flame and Flutter packages
import 'package:flame/flame.dart'; // Core Flame library for game-related utilities
import 'package:flame/game.dart'; // Provides the GameWidget to render the game
import 'package:flutter/material.dart'; // Flutter Material design components
import 'package:flutter/services.dart'; // For controlling system-level UI behaviors
import 'package:flutter_bird/game/flappy_bird_game.dart'; // The main FlappyBirdGame class
import 'package:flutter_bird/screens/main_menu_screen.dart'; // Main menu overlay screen
import 'screens/game_over_screen.dart'; // Game-over overlay screen

// The entry point of the Flutter application
Future<void> main() async {
  // Sets the status bar color to transparent for a seamless full-screen experience
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  // Ensures that Flutter's widget system is fully initialized before running the app
  WidgetsFlutterBinding.ensureInitialized();

  // Enables full-screen mode for the game
  await Flame.device.fullScreen();

  // Instantiates the FlappyBirdGame class, which contains the game logic
  final game = FlappyBirdGame();

  // Runs the app with the Flame GameWidget
  runApp(
    GameWidget(
      game: game, // The game instance to render
      initialActiveOverlays: const [MainMenuScreen.id], // Overlays to display at the start
      overlayBuilderMap: {
        // Map of overlays that can be activated during the game
        'mainMenu': (context, _) => MainMenuScreen(game: game), // Main menu screen
        'gameOver': (context, _) => GameOverScreen(game: game), // Game-over screen
      },
    ),
  );
}
