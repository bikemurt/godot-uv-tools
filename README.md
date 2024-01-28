<img src="icon.png" width="64" align="left" />

## godot-uv-tools

[Youtube video](https://www.youtube.com/watch?v=Igqqg7R-4sA)
 
**Simple Godot 4 plugin to that includes various tools to manipulate UVs.**
- *ProtoCube* node. Automatically performs a cube projection so that prototyping textures scale:
![image](https://github.com/bikemurt/godot-uv-tools/assets/23486102/9b9f14d1-e9de-4c05-b917-7105059c9616)

After scaling on the x axis, notice that the texture repeats and does not stretch:
![image](https://github.com/bikemurt/godot-uv-tools/assets/23486102/8ca0c3bd-0a8c-44c2-b8f3-71f3aab10ead)

- *ProtoBody* node. Basically the same as ProtoCube but wraps with a Rigid/StaticBody3D and collision shape.
- Quick texture selection for the purposes of prototyping:
- ![image](https://github.com/bikemurt/godot-uv-tools/assets/23486102/cacb6cfe-6219-464c-b655-e3c44624ab5d)


---

**Godot Versions Tested**

- v4.2.1

---
## 🚀 Install & Use

1. Download this [repository](https://github.com/bikemurt/godot-uv-tools/), or download from the [Godot Asset Library](https://godotengine.org/asset-library/asset/2544)
    - Import the addons folder into your project (if it already isn't present).
2. Activate the UV Tools addon under Project > Project Settings > Plugins. If an error dialog appears, restart the engine and try activating it again.
3. Add a "ProtoCube" node to your scene. Drop a texture onto the Albedo of the material override, and then scale the cube. You should see the cube projection update so that the texture tiles.

## ⚠️ Limitations

## 🏠 Links

- [Homepage](https://www.michaeljared.ca/)
- [Youtube](https://www.youtube.com/@michaeljburt)
- [Blender Market](https://blendermarket.com/creators/michaeljared)

## 🗒️ License

[MIT License](/LICENSE)
