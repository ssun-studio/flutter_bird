// Importing necessary libraries and components
import 'dart:math'; // To generate random values for pipe spacing and positioning
import 'package:flame/components.dart'; // Core components for Flame game engine
import 'package:flame_audio/flame_audio.dart'; // For playing audio (sound effects)
import 'package:flutter_bird/components/pipe.dart'; // Pipe component (custom implementation)

// Importing project-specific files
import '../game/assets.dart'; // Contains asset paths for sound effects
import '../game/configuration.dart'; // Game configuration settings such as speed, pipe spacing
import '../game/flappy_bird_game.dart'; // The main game class
import '../game/pipe_position.dart'; // Defines the positioning logic for pipes

// PipeGroup class is responsible for managing a pair of pipes (top and bottom) 
// and their movement, scoring, and removal from the screen.
class PipeGroup extends PositionComponent with HasGameRef<FlappyBirdGame> {
  // Constructor for the PipeGroup class
  PipeGroup();

  // Random number generator used to calculate random pipe positioning
  final _random = Random();

  // onLoad method is called when the component is loaded into the game
  @override
  Future<void> onLoad() async {
    // Set the initial x-position of the pipes to be off-screen (at the right side)
    position.x = gameRef.size.x;

    // Calculate the available height for the pipes by subtracting ground height from the screen height
    final heightMinusGround = gameRef.size.y - Config.groundHeight;

    // Randomly decide the spacing between the top and bottom pipes, ensuring it is within a range
    final spacing = 100 + _random.nextDouble() * (heightMinusGround / 4);

    // Calculate the Y position for the center of the gap between the two pipes
    final centerY = spacing + _random.nextDouble() * (heightMinusGround - spacing);

    // Add the top and bottom pipes to the PipeGroup. The top pipe's height is based on the calculated `centerY`.
    // The bottom pipe's height is calculated by subtracting the `centerY` and the pipe gap (`spacing`).
    addAll([
      Pipe(pipePosition: PipePosition.top, height: centerY - spacing / 2), // Top pipe
      Pipe(pipePosition: PipePosition.bottom, height: heightMinusGround - (centerY + spacing / 2)), // Bottom pipe
    ]);
  }

  // Method to update the score when the bird successfully passes a pair of pipes
  void updateScore() {
    // Increment the bird's score
    gameRef.bird.score += 1;

    // Play the "point" sound effect
    FlameAudio.play(Assets.point);
  }

  // Update method is called every frame to handle the movement of pipes and collisions
  @override
  void update(double dt) {
    super.update(dt); // Call the base class's update method

    // Move the pipes to the left by the game speed, multiplied by delta time for smooth movement
    position.x -= Config.gameSpeed * dt;

    // If the pipe is completely off-screen (x-position < -10), remove it from the parent (destroy it)
    if (position.x < -10) {
      removeFromParent(); // Remove the PipeGroup from the game scene
      updateScore(); // Call the method to update the score when the pipes pass
    }

    // If the game is hit (collision occurs), remove the pipe group and reset the hit state
    if (gameRef.isHit) {
      removeFromParent(); // Remove the PipeGroup from the game scene
      gameRef.isHit = false; // Reset the hit state
    }
  }
}
