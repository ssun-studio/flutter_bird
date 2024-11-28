import 'package:flutter/material.dart'; // Importing Flutter's material design library for UI components
import '../game/assets.dart'; // Importing the game's assets (e.g., images)
import '../game/flappy_bird_game.dart'; // Importing the main game class to access game state

// MainMenuScreen widget represents the screen shown when the game is in the main menu
class MainMenuScreen extends StatelessWidget {
  final FlappyBirdGame game; // The game instance, passed to the screen to access game data
  static const String id = 'mainMenu'; // Static identifier for the main menu screen (used in overlays)

  // Constructor to initialize the MainMenuScreen with the required game instance
  const MainMenuScreen({
    super.key, // Constructor key to handle widget identity
    required this.game, // Required game instance
  });

  // Build method to create the UI for the main menu screen
  @override
  Widget build(BuildContext context) {
    game.pauseEngine(); // Pauses the game engine when the main menu is shown

    // Scaffold widget provides the basic structure of the screen
    return Scaffold(
      body: GestureDetector( // Detects a tap gesture anywhere on the screen
        onTap: () {
          game.overlays.remove('mainMenu'); // Removes the main menu overlay when tapped
          game.resumeEngine(); // Resumes the game engine, transitioning to the game
        },
        child: Container(
          width: double.infinity, // Make the container take up the full width of the screen
          height: double.infinity, // Make the container take up the full height of the screen
          decoration: const BoxDecoration( // Adds decoration to the container
            image: DecorationImage( // Set the background image of the main menu
              image: AssetImage(Assets.menu), // Image loaded from the assets
              fit: BoxFit.cover, // Ensures the image covers the entire container area
            ),
          ),
          child: Image.asset(Assets.message), // Display a message or logo image from assets
        ),
      ),
    );
  }
}
