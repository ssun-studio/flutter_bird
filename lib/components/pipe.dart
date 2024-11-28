// Import necessary libraries for the game functionality
import 'package:flame/collisions.dart'; // Collision detection functionality
import 'package:flame/components.dart'; // Flame's components system
import 'package:flame/flame.dart'; // Flame image and audio loading
import '../game/assets.dart'; // Importing assets (e.g., images) from the game folder
import '../game/configuration.dart'; // Game configuration file for settings like ground height
import '../game/flappy_bird_game.dart'; // Reference to the main game class
import '../game/pipe_position.dart'; // Enum or constants defining pipe positions

// Pipe class is used to create and manage the individual pipes in the game
class Pipe extends SpriteComponent with HasGameRef<FlappyBirdGame> {
  // Constructor to initialize the pipe with its position and height
  Pipe({
    required this.pipePosition, // The position of the pipe (top or bottom)
    required this.height, // The height of the pipe, which can vary for each pipe group
  });

  // The height of the pipe (specific for each instance)
  @override
  final double height;

  // Enum or variable representing whether the pipe is positioned at the top or bottom
  final PipePosition pipePosition;

  // onLoad method is called when the pipe is loaded into the game world
  @override
  Future<void> onLoad() async {
    // Load the images for the pipe and the rotated pipe (used for top pipe)
    final pipe = await Flame.images.load(Assets.pipe); // Load the regular pipe image
    final pipeRotated = await Flame.images.load(Assets.pipeRotated); // Load the rotated pipe image

    // Set the size of the pipe, width is fixed (50) and height is passed in the constructor
    size = Vector2(50, height);

    // Position and sprite setup based on the pipe position (top or bottom)
    switch (pipePosition) {
      case PipePosition.top:
        // For the top pipe, set the y-position to 0 (top of the screen)
        position.y = 0;
        // Set the sprite to the rotated pipe image for the top pipe
        sprite = Sprite(pipeRotated);
        break;
      case PipePosition.bottom:
        // For the bottom pipe, set the y-position to the bottom of the screen, accounting for the ground height
        position.y = gameRef.size.y - size.y - Config.groundHeight;
        // Set the sprite to the regular pipe image for the bottom pipe
        sprite = Sprite(pipe);
        break;
    }

    // Add a collision hitbox around the pipe, to detect collisions with the bird
    add(RectangleHitbox());
  }
}
