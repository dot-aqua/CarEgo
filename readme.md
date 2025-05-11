# CarEgo

CarEgo is a FiveM script designed to enhance the driving experience in GTA V by adding advanced vehicle features such as a rear-view camera and parking sensors. This script is highly configurable and supports custom vehicle configurations.

## Features

- **Rear-View Camera**: Activate a dynamic rear-view camera with a realistic helicopter camera effect.
- **Parking Sensors**: Detect nearby objects and display the distance in real-time, with audio feedback for proximity.
- **Configurable Vehicles**: Define specific vehicles and their camera offsets in the configuration file.
- **First-Person Driving**: Automatically switches to first-person view when entering a vehicle.

## Installation

1. Clone or download this repository into your FiveM server's `resources` folder.
2. Ensure the script is named `CarEgo` in the `resources` folder.
3. Add `start CarEgo` to your server's `server.cfg`.

## Configuration

The script reads its configuration from the `_resource.lua` file. You can define:
- **Allowed Vehicles**: Specify which vehicles support the rear-view camera and their respective offsets.
- **Parking Sensor Toggle**: Enable or disable the parking sensor feature.

Example configuration:
```lua
allowedVehiclesConfig = {
    vehicles = {
        { model = "adder", offset = 0.5 },
        { model = "zentorno", offset = 0.7 }
    },
    enableParkingSensor = true
}
```

## Usage

- **Rear-View Camera**: Press and hold the `C` key while in a configured vehicle to activate the rear-view camera. Release the `C` key to deactivate it.
- **Parking Sensors**: Automatically active when the rear-view camera is enabled, providing distance feedback and beeping sounds.

## Dependencies

- FiveM server
- GTA V

## Contributing

Feel free to submit issues or pull requests to improve the script. Contributions are welcome!

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.