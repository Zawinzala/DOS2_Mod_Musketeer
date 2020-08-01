Musketeer for Divinity: Original Sin 2 - Definitive Edition
=======

# Features:
- New Weapon Types: Blunderbuss, Matchlock and Musket!
- New Class: Musketeer (12+ new unique Skills)
- Custom UI Display: Ammunition Bar helps you keep track of your Weapon's Ammunition
- Custom weapon model
- Custom icons for all skills and items
- Custom sounds
- Dynamic skill ranges, Rifle-Skills range is determined by your equipped firearm.
- Updated talents to interact with firearms

## Current Skill-List Overview:
![alt text](https://cdn.discordapp.com/attachments/358337334619406336/719880391334559844/Musketeer_Skills_Overview.png "Skill-List")

# Releases
* [Steam Workshop]() 
* [Nexus]()

# Attribution
- [Divinity: Original Sin 2](http://store.steampowered.com/app/435150/Divinity_Original_Sin_2/), a game by [Larian Studios](http://larian.com/)

# Working on right now (Will constitute Beta-Version for public testing):
- Finalize AmmoType effects
- Make AmmoType's apply Boosts for BeamFX on basic attacks and bonus damage
- Update SkillOverview Page
- Update AmmoType Descriptions and Displaynames
- Update enhanced Reload Skill-Icons
- Update enhanced Reload Skill requirements

# Current WIP Features
- [x] Reload Animation and SFX/FX (Still kinda meh)
- [x] Better distribution of Rifles throughout the game
- [ ] Finalize Alternative Reload variations
- [ ] AmmoBar custom GUI element for Ammunition Management (Currently testing for bugs)
- [x] Rework "Rend the Marked" again, because it's super lame
- [x] Make AmmoBar draggable
- [x] Rewrite "Covering Fire" logic in Lua


# Known Bugs/Issues
- [x] "Covering Fire" does not work correctly on some occasions (PRESUMABLY FIXED)
- [ ] Dynamic range not applying on some unknown occasions (perhaps level-up? After loading screen too)
- [x] "Blazing Flare" missing prepare effect
- [x] Rifles have a chance to spawn with the SkyShot (Maybe other skills too) Skill
- [x] Skillproperty "Force" combined with "Knock Down" causes enemy target's turn to time out. (Replaced "Knock Down" with "Stunned")
- [ ] Buckshot Skill Description param [2] is missing



# Planned Features
- [ ] Add AmmoType effects on basic attacks when attacking ground.
Currently not (easily) possible, waiting for additional ASAttack access options in the Extender
- [x] Improved Visualization of Remaining Ammo
UI Overlay Effect from a Status effect perhaps?
- [ ] Skill "Enforced Vaccination"
Ranged single-target rifle skill, damage enemies, heal allies. Set decaying on market enemies.
- [ ] Additional Talent interactions with rifles
