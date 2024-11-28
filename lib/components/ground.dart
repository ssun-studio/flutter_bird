// Importing necessary Flame components and utilities
import 'package:flame/collisions.dart'; // Provides collision detection components
import 'package:flame/components.dart'; // Base components for game objects
import 'package:flame/flame.dart'; // Core Flame library for asset management
import 'package:flame/parallax.dart'; // Enables parallax backgrounds

// Importing project-specific files
import '../game/assets.dart'; // Contains asset paths and constants
import '../game/configuration.dart'; // Game configuration settings
import '../game/flappy_bird_game.dart'; // Main game class definition

// The Ground class represents the game's ground and implements parallax movement.
// It extends ParallaxComponent and uses HasGameRef to access the FlappyBirdGame instance.
class Ground extends ParallaxComponent<FlappyBirdGame>
    with HasGameRef<FlappyBirdGame> {
  // Constructor for the Ground component
  Ground();

  // Lifecycle method for loading assets and initializing the component
  @override
  Future<void> onLoad() async {
    // Load the ground image from assets using Flame's image loader
    final ground = await Flame.images.load(Assets.ground);

    // Create a parallax effect for the ground with a single layer
    parallax = Parallax([
      ParallaxLayer(
        ParallaxImage(ground, fill: LayerFill.none), // Layer without stretching the image
      ),
    ]);

    // Add a collision hitbox for the ground
    add(
      RectangleHitbox(
        // Position the hitbox at the bottom of the screen
        position: Vector2(0, gameRef.size.y - Config.groundHeight),
        // Set the hitbox size to match the ground's width and height
        size: Vector2(gameRef.size.x, Config.groundHeight),
      ),
    );
  }

  // Update method called every frame to adjust the ground's movement
  @override
  void update(double dt) {
    super.update(dt); // Call the base class's update method

    // Set the horizontal movement speed for the parallax effect
    parallax?.baseVelocity.x = Config.gameSpeed;
  }
}
