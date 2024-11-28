import 'package:flutter/material.dart'; // Importing Flutter's material design library for UI components
import '../game/assets.dart'; // Importing the game's assets (e.g., images)
import '../game/flappy_bird_game.dart'; // Importing the main game class to access game state

// GameOverScreen widget shows a screen when the game is over
class GameOverScreen extends StatelessWidget {
  final FlappyBirdGame game; // The game instance, passed to the screen to access game data

  // Constructor to initialize the GameOverScreen with the required game instance
  const GameOverScreen({super.key, required this.game});

  // Build method to create the UI for the game over screen
  @override
  Widget build(BuildContext context) => Material(
        color: Colors.black38, // Set the background color to a semi-transparent black
        child: Center( // Center the contents on the screen
          child: Column( // Use a column to stack elements vertically
            mainAxisSize: MainAxisSize.min, // Ensure the column takes up only as much space as needed
            children: [
              // Display the score, showing the score from the bird object in the game
              Text(
                'Score: ${game.bird.score}', // Display the score dynamically
                style: const TextStyle(
                  fontSize: 60, // Large text size
                  color: Colors.white, // White text color
                  fontFamily: 'Game', // Custom font family for the text
                ),
              ),
              const SizedBox(height: 20), // Add some space between the score and the image
              Image.asset(Assets.gameOver), // Display the "game over" image from assets
              const SizedBox(height: 20), // Add space between the image and the button
              ElevatedButton(
                // Button to restart the game
                onPressed: onRestart, // When the button is pressed, call the onRestart function
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange), // Style the button with an orange background
                child: const Text(
                  'Restart', // Button label
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontFamily: 'Game',
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  // Function to handle restarting the game
  void onRestart() {
    game.bird.reset(); // Reset the bird's position and score
    game.overlays.remove('gameOver'); // Remove the 'gameOver' overlay, hiding the game over screen
    game.resumeEngine(); // Resume the game engine, starting the game again
  }
}
