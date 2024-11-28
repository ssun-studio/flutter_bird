// Importing necessary Flame and Flutter packages
import 'package:flame/components.dart'; // Core components for the game
import 'package:flame/events.dart'; // Provides event handling like taps
import 'package:flame/game.dart'; // Base class for creating a Flame game
import 'package:flutter/painting.dart'; // For text styling
import 'package:flutter_bird/game/configuration.dart'; // Configuration constants

// Importing custom components specific to the game
import '../components/background.dart'; // Background component
import '../components/bird.dart'; // Bird component
import '../components/ground.dart'; // Ground component
import '../components/pipe_group.dart'; // Pipe group component for obstacles

// The main game class that extends FlameGame and uses mixins for tap detection and collision handling
class FlappyBirdGame extends FlameGame with TapDetector, HasCollisionDetection {
  // Constructor
  FlappyBirdGame();

  // Instance of the Bird component
  late Bird bird;

  // Timer for generating pipe groups at regular intervals
  Timer interval = Timer(Config.pipeInterval, repeat: true);

  // Flag to check if the bird has collided (game-over state)
  bool isHit = false;

  // Text component for displaying the score
  late TextComponent score;

  // Method to load and initialize all game components
  @override
  Future<void> onLoad() async {
    // Adding all essential game components to the game
    addAll([
      Background(), // Static background
      Ground(), // Ground component that might scroll
      bird = Bird(), // Bird component, initialized and assigned to the bird property
      score = buildScore(), // Score text component, created using a helper method
    ]);

    // Setting the timer to add new PipeGroup components on each tick
    interval.onTick = () => add(PipeGroup());
  }

  // Helper method to create and style the score text component
  TextComponent buildScore() {
    return TextComponent(
        position: Vector2(size.x / 2, size.y / 2 * 0.2), // Center-top position
        anchor: Anchor.center, // Center alignment for positioning
        textRenderer: TextPaint(
          style: const TextStyle(
              fontSize: 40, // Font size for score display
              fontFamily: 'Game', // Custom font family for the game
              fontWeight: FontWeight.bold), // Bold text
        ));
  }

  // Event handler for tap inputs
  @override
  void onTap() {
    // Make the bird fly when the screen is tapped
    bird.fly();
  }

  // Update method called every frame
  @override
  void update(double dt) {
    super.update(dt); // Call the base update method

    // Update the timer to handle pipe generation
    interval.update(dt);

    // Update the score display with the current score from the bird
    score.text = 'Score: ${bird.score}';
  }
}
