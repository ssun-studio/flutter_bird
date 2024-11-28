// Importing Dart's asynchronous support for futures and delays
import 'dart:async';

// Importing Flame's base components and utilities
import 'package:flame/components.dart'; // Provides the SpriteComponent class
import 'package:flame/flame.dart'; // Core Flame library for loading assets

// Importing project-specific files
import '../game/assets.dart'; // Contains asset paths and constants
import '../game/flappy_bird_game.dart'; // Main game class definition

// The Background class represents the game's background and is a type of SpriteComponent.
// It uses HasGameRef to get a reference to the main FlappyBirdGame.
class Background extends SpriteComponent with HasGameRef<FlappyBirdGame> {
  // Constructor for the Background component
  Background();

  // Lifecycle method called when the component is added to the game
  @override
  Future<void> onLoad() async {
    // Loads the background image from the assets using Flame's image loader
    final background = await Flame.images.load(Assets.backgorund);

    // Sets the size of the background to match the game screen size
    size = gameRef.size;

    // Creates a sprite from the loaded image and assigns it to the component
    sprite = Sprite(background);
  }
}
