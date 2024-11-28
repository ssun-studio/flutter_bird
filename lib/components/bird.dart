// Importing necessary packages for the game functionality
import 'package:flame/collisions.dart'; // Handles collision detection
import 'package:flame/components.dart'; // Provides core components for the game
import 'package:flame/effects.dart'; // Enables animations and effects
import 'package:flame_audio/flame_audio.dart'; // Handles audio playback
import 'package:flutter/material.dart'; // Provides UI components

// Importing game-specific assets and configurations
import '../game/assets.dart'; // Contains paths to asset files
import '../game/bird_movement.dart'; // Enum for bird movement states
import '../game/configuration.dart'; // Stores configuration values
import '../game/flappy_bird_game.dart'; // Main game class

// The Bird class defines the behavior and attributes of the bird in the game
class Bird extends SpriteGroupComponent<BirdMovement>
    with HasGameRef<FlappyBirdGame>, CollisionCallbacks {
  Bird();

  // The player's score
  int score = 0;

  // Method called when the Bird component is loaded
  @override
  Future<void> onLoad() async {
    // Loading all bird sprites from assets
    final birdMidFlap = await gameRef.loadSprite(Assets.birdMidFlap);
    final birdUpFlap = await gameRef.loadSprite(Assets.birdUpFlap);
    final birdDownFlap = await gameRef.loadSprite(Assets.birdDownFlap);

    // Assigning the loaded sprites to their respective movement states
    sprites = {
      BirdMovement.middle: birdMidFlap,
      BirdMovement.up: birdUpFlap,
      BirdMovement.down: birdDownFlap,
    };

    // Setting the size and initial position of the bird
    size = Vector2(50, 40);
    position = Vector2(50, gameRef.size.y / 2 - size.y / 2);

    // Setting the initial sprite state
    current = BirdMovement.middle;

    // Adding a circular hitbox for collision detection
    add(CircleHitbox());
  }

  // Method called every frame to update the bird's position and state
  @override
  void update(double dt) {
    super.update(dt);

    // Adjusting the bird's vertical position based on velocity
    position.y += Config.birdVelocity * dt;

    // Checking if the bird goes out of bounds
    if (position.y < 1 || position.y > gameRef.size.y - size.y) {
      gameOver(); // End the game if the bird goes out of bounds
    }
  }

  // Method to make the bird fly upwards
  void fly() {
    // Ensuring the bird isn't already flying up
    if (current != BirdMovement.up) {
      // Adding an upward movement effect with deceleration
      add(
        MoveByEffect(
          Vector2(0, Config.gravity),
          EffectController(duration: 0.2, curve: Curves.decelerate),
          onComplete: () => current = BirdMovement.down, // Return to downward state
        ),
      );

      // Playing flying sound effect
      FlameAudio.play(Assets.flying);

      // Setting the current sprite state to "up"
      current = BirdMovement.up;
    }
  }

  // Method called when a collision starts
  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);

    // End the game on collision
    gameOver();
  }

  // Method to reset the bird's position, state, and score
  void reset() {
    position = Vector2(50, gameRef.size.y / 2 - size.y / 2); // Reset position
    current = BirdMovement.middle; // Reset sprite state
    score = 0; // Reset score
  }

  // Method to handle game-over logic
  void gameOver() {
    if (!game.isHit) {
      // Ensuring the game-over logic runs only once
      game.isHit = true;

      // Playing collision sound effect
      FlameAudio.play(Assets.collision);

      // Displaying the game-over overlay and pausing the game engine
      gameRef.overlays.add('gameOver');
      gameRef.pauseEngine();
    }
  }
}
