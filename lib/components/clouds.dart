// Importing necessary Flame components and utilities
import 'package:flame/components.dart'; // Base components for creating game objects
import 'package:flame/flame.dart'; // Core Flame library for asset management
import 'package:flame/parallax.dart'; // Provides support for parallax backgrounds

// Importing project-specific files
import '../game/assets.dart'; // Contains asset paths and constants
import '../game/configuration.dart'; // Game configuration settings, such as speeds and heights
import '../game/flappy_bird_game.dart'; // Main game class definition

// Clouds class represents a parallax component for rendering moving clouds.
// Extends ParallaxComponent and uses HasGameRef to access the FlappyBirdGame instance.
class Clouds extends ParallaxComponent<FlappyBirdGame>
    with HasGameRef<FlappyBirdGame> {
  // Constructor for the Clouds component
  Clouds();

  // Lifecycle method to load assets and initialize the component
  @override
  Future<void> onLoad() async {
    // Load the clouds image from assets using Flame's image loader
    final image = await Flame.images.load(Assets.clouds);

    // Set the initial position of the clouds relative to the game screen
    position = Vector2(x, -(gameRef.size.y - Config.cloudsHeight),); // Align clouds to a specific height

    // Create a parallax effect using the loaded image
    parallax = Parallax([
      // Add a layer with the clouds image. Set to not stretch or fill the screen.
      ParallaxLayer(
        ParallaxImage(image, fill: LayerFill.none),
      ),
    ]);
  }

  // Update method called every frame to adjust parallax movement
  @override
  void update(double dt) {
    super.update(dt); // Call the base class's update method

    // Set the horizontal movement speed for the parallax effect
    parallax?.baseVelocity.x = Config.gameSpeed;
  }
}
