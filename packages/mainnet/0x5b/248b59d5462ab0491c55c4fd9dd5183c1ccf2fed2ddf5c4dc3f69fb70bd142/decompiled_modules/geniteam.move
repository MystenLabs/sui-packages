module 0x5b248b59d5462ab0491c55c4fd9dd5183c1ccf2fed2ddf5c4dc3f69fb70bd142::geniteam {
    struct Player has key {
        id: 0x2::object::UID,
        player_name: 0x1::ascii::String,
        water_runes_count: u64,
        fire_runes_count: u64,
        wind_runes_count: u64,
        earth_runes_count: u64,
        owned_farm: 0x1::option::Option<0x5b248b59d5462ab0491c55c4fd9dd5183c1ccf2fed2ddf5c4dc3f69fb70bd142::typed_id::TypedID<Farm>>,
        inventory: 0x2::object_bag::ObjectBag,
    }

    struct Farm has store, key {
        id: 0x2::object::UID,
        farm_name: 0x1::ascii::String,
        farm_img_index: u64,
        level: u64,
        current_xp: u64,
        total_monster_slots: u64,
        occupied_monster_slots: u64,
        pet_monsters: 0x2::object_table::ObjectTable<0x2::object::ID, Monster>,
        applied_farm_cosmetic_0: 0x1::option::Option<0x5b248b59d5462ab0491c55c4fd9dd5183c1ccf2fed2ddf5c4dc3f69fb70bd142::typed_id::TypedID<FarmCosmetic>>,
        applied_farm_cosmetic_1: 0x1::option::Option<0x5b248b59d5462ab0491c55c4fd9dd5183c1ccf2fed2ddf5c4dc3f69fb70bd142::typed_id::TypedID<FarmCosmetic>>,
    }

    struct Monster has store, key {
        id: 0x2::object::UID,
        monster_name: 0x1::ascii::String,
        monster_img_index: u64,
        breed: u8,
        monster_affinity: u8,
        monster_description: 0x1::ascii::String,
        monster_level: u64,
        monster_xp: u64,
        hunger_level: u64,
        affection_level: u64,
        buddy_level: u8,
        display: 0x1::ascii::String,
        applied_monster_cosmetic_0: 0x1::option::Option<0x5b248b59d5462ab0491c55c4fd9dd5183c1ccf2fed2ddf5c4dc3f69fb70bd142::typed_id::TypedID<MonsterCosmetic>>,
        applied_monster_cosmetic_1: 0x1::option::Option<0x5b248b59d5462ab0491c55c4fd9dd5183c1ccf2fed2ddf5c4dc3f69fb70bd142::typed_id::TypedID<MonsterCosmetic>>,
    }

    struct FarmCosmetic has store, key {
        id: 0x2::object::UID,
        cosmetic_type: u8,
        display: 0x1::ascii::String,
    }

    struct MonsterCosmetic has store, key {
        id: 0x2::object::UID,
        cosmetic_type: u8,
        display: 0x1::ascii::String,
    }

    public entry fun create_farm(arg0: &mut Player, arg1: u64, arg2: vector<u8>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_none<0x5b248b59d5462ab0491c55c4fd9dd5183c1ccf2fed2ddf5c4dc3f69fb70bd142::typed_id::TypedID<Farm>>(&arg0.owned_farm), 1);
        let v0 = new_farm(arg2, arg1, arg3, arg4);
        let v1 = 0x5b248b59d5462ab0491c55c4fd9dd5183c1ccf2fed2ddf5c4dc3f69fb70bd142::typed_id::new<Farm>(&v0);
        0x2::dynamic_object_field::add<0x5b248b59d5462ab0491c55c4fd9dd5183c1ccf2fed2ddf5c4dc3f69fb70bd142::typed_id::TypedID<Farm>, Farm>(&mut arg0.id, v1, v0);
        0x1::option::fill<0x5b248b59d5462ab0491c55c4fd9dd5183c1ccf2fed2ddf5c4dc3f69fb70bd142::typed_id::TypedID<Farm>>(&mut arg0.owned_farm, v1);
    }

    public fun create_farm_cosmetics(arg0: &mut Player, arg1: u8, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = FarmCosmetic{
            id            : 0x2::object::new(arg3),
            cosmetic_type : arg1,
            display       : 0x1::ascii::string(arg2),
        };
        0x2::object_bag::add<0x2::object::ID, FarmCosmetic>(&mut arg0.inventory, 0x2::object::id<FarmCosmetic>(&v0), v0);
    }

    public entry fun create_monster(arg0: &mut Player, arg1: vector<u8>, arg2: u64, arg3: u8, arg4: u8, arg5: vector<u8>, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = new_monster(arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0x2::object_table::add<0x2::object::ID, Monster>(&mut 0x2::dynamic_object_field::borrow_mut<0x5b248b59d5462ab0491c55c4fd9dd5183c1ccf2fed2ddf5c4dc3f69fb70bd142::typed_id::TypedID<Farm>, Farm>(&mut arg0.id, *0x1::option::borrow<0x5b248b59d5462ab0491c55c4fd9dd5183c1ccf2fed2ddf5c4dc3f69fb70bd142::typed_id::TypedID<Farm>>(&arg0.owned_farm)).pet_monsters, 0x2::object::id<Monster>(&v0), v0);
    }

    public fun create_monster_cosmetics(arg0: &mut Player, arg1: u8, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = MonsterCosmetic{
            id            : 0x2::object::new(arg3),
            cosmetic_type : arg1,
            display       : 0x1::ascii::string(arg2),
        };
        0x2::object_bag::add<0x2::object::ID, MonsterCosmetic>(&mut arg0.inventory, 0x2::object::id<MonsterCosmetic>(&v0), v0);
    }

    public entry fun create_player(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = new_player(arg0, arg1);
        0x2::transfer::transfer<Player>(v0, 0x2::tx_context::sender(arg1));
    }

    fun new_farm(arg0: vector<u8>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : Farm {
        Farm{
            id                      : 0x2::object::new(arg3),
            farm_name               : 0x1::ascii::string(arg0),
            farm_img_index          : arg1,
            level                   : 0,
            current_xp              : 0,
            total_monster_slots     : arg2,
            occupied_monster_slots  : 0,
            pet_monsters            : 0x2::object_table::new<0x2::object::ID, Monster>(arg3),
            applied_farm_cosmetic_0 : 0x1::option::none<0x5b248b59d5462ab0491c55c4fd9dd5183c1ccf2fed2ddf5c4dc3f69fb70bd142::typed_id::TypedID<FarmCosmetic>>(),
            applied_farm_cosmetic_1 : 0x1::option::none<0x5b248b59d5462ab0491c55c4fd9dd5183c1ccf2fed2ddf5c4dc3f69fb70bd142::typed_id::TypedID<FarmCosmetic>>(),
        }
    }

    fun new_monster(arg0: vector<u8>, arg1: u64, arg2: u8, arg3: u8, arg4: vector<u8>, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) : Monster {
        Monster{
            id                         : 0x2::object::new(arg6),
            monster_name               : 0x1::ascii::string(arg0),
            monster_img_index          : arg1,
            breed                      : arg2,
            monster_affinity           : arg3,
            monster_description        : 0x1::ascii::string(arg4),
            monster_level              : 0,
            monster_xp                 : 0,
            hunger_level               : 0,
            affection_level            : 0,
            buddy_level                : 0,
            display                    : 0x1::ascii::string(arg5),
            applied_monster_cosmetic_0 : 0x1::option::none<0x5b248b59d5462ab0491c55c4fd9dd5183c1ccf2fed2ddf5c4dc3f69fb70bd142::typed_id::TypedID<MonsterCosmetic>>(),
            applied_monster_cosmetic_1 : 0x1::option::none<0x5b248b59d5462ab0491c55c4fd9dd5183c1ccf2fed2ddf5c4dc3f69fb70bd142::typed_id::TypedID<MonsterCosmetic>>(),
        }
    }

    fun new_player(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) : Player {
        Player{
            id                : 0x2::object::new(arg1),
            player_name       : 0x1::ascii::string(arg0),
            water_runes_count : 0,
            fire_runes_count  : 0,
            wind_runes_count  : 0,
            earth_runes_count : 0,
            owned_farm        : 0x1::option::none<0x5b248b59d5462ab0491c55c4fd9dd5183c1ccf2fed2ddf5c4dc3f69fb70bd142::typed_id::TypedID<Farm>>(),
            inventory         : 0x2::object_bag::new(arg1),
        }
    }

    public fun update_farm_cosmetics(arg0: &mut Player, arg1: FarmCosmetic, arg2: u64) {
        assert!(arg2 <= 1, 4);
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x5b248b59d5462ab0491c55c4fd9dd5183c1ccf2fed2ddf5c4dc3f69fb70bd142::typed_id::TypedID<Farm>, Farm>(&mut arg0.id, *0x1::option::borrow<0x5b248b59d5462ab0491c55c4fd9dd5183c1ccf2fed2ddf5c4dc3f69fb70bd142::typed_id::TypedID<Farm>>(&arg0.owned_farm));
        let v1 = 0x5b248b59d5462ab0491c55c4fd9dd5183c1ccf2fed2ddf5c4dc3f69fb70bd142::typed_id::new<FarmCosmetic>(&arg1);
        0x2::dynamic_object_field::add<0x5b248b59d5462ab0491c55c4fd9dd5183c1ccf2fed2ddf5c4dc3f69fb70bd142::typed_id::TypedID<FarmCosmetic>, FarmCosmetic>(&mut v0.id, v1, arg1);
        if (arg2 == 0) {
            0x1::option::fill<0x5b248b59d5462ab0491c55c4fd9dd5183c1ccf2fed2ddf5c4dc3f69fb70bd142::typed_id::TypedID<FarmCosmetic>>(&mut v0.applied_farm_cosmetic_0, v1);
        } else {
            0x1::option::fill<0x5b248b59d5462ab0491c55c4fd9dd5183c1ccf2fed2ddf5c4dc3f69fb70bd142::typed_id::TypedID<FarmCosmetic>>(&mut v0.applied_farm_cosmetic_1, v1);
        };
    }

    public fun update_farm_stats(arg0: &mut Player, arg1: &mut Farm, arg2: u64, arg3: u64) {
        arg1.current_xp = arg3;
        arg1.level = arg2;
    }

    public fun update_monster_cosmetics(arg0: &mut Player, arg1: 0x2::object::ID, arg2: MonsterCosmetic, arg3: u64) {
        assert!(arg3 <= 1, 4);
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, Monster>(&mut 0x2::dynamic_object_field::borrow_mut<0x5b248b59d5462ab0491c55c4fd9dd5183c1ccf2fed2ddf5c4dc3f69fb70bd142::typed_id::TypedID<Farm>, Farm>(&mut arg0.id, *0x1::option::borrow<0x5b248b59d5462ab0491c55c4fd9dd5183c1ccf2fed2ddf5c4dc3f69fb70bd142::typed_id::TypedID<Farm>>(&arg0.owned_farm)).pet_monsters, arg1);
        let v1 = 0x5b248b59d5462ab0491c55c4fd9dd5183c1ccf2fed2ddf5c4dc3f69fb70bd142::typed_id::new<MonsterCosmetic>(&arg2);
        0x2::dynamic_object_field::add<0x5b248b59d5462ab0491c55c4fd9dd5183c1ccf2fed2ddf5c4dc3f69fb70bd142::typed_id::TypedID<MonsterCosmetic>, MonsterCosmetic>(&mut v0.id, v1, arg2);
        if (arg3 == 0) {
            0x1::option::fill<0x5b248b59d5462ab0491c55c4fd9dd5183c1ccf2fed2ddf5c4dc3f69fb70bd142::typed_id::TypedID<MonsterCosmetic>>(&mut v0.applied_monster_cosmetic_0, v1);
        } else {
            0x1::option::fill<0x5b248b59d5462ab0491c55c4fd9dd5183c1ccf2fed2ddf5c4dc3f69fb70bd142::typed_id::TypedID<MonsterCosmetic>>(&mut v0.applied_monster_cosmetic_1, v1);
        };
    }

    public fun update_monster_stats(arg0: &mut Player, arg1: 0x2::object::ID, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: u8, arg7: vector<u8>) {
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, Monster>(&mut 0x2::dynamic_object_field::borrow_mut<0x5b248b59d5462ab0491c55c4fd9dd5183c1ccf2fed2ddf5c4dc3f69fb70bd142::typed_id::TypedID<Farm>, Farm>(&mut arg0.id, *0x1::option::borrow<0x5b248b59d5462ab0491c55c4fd9dd5183c1ccf2fed2ddf5c4dc3f69fb70bd142::typed_id::TypedID<Farm>>(&arg0.owned_farm)).pet_monsters, arg1);
        v0.monster_affinity = arg2;
        v0.monster_level = arg3;
        v0.hunger_level = arg4;
        v0.affection_level = arg5;
        v0.buddy_level = arg6;
        if (0x1::vector::length<u8>(&arg7) != 0) {
            v0.display = 0x1::ascii::string(arg7);
        };
    }

    public fun update_player(arg0: &mut Player, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        arg0.water_runes_count = arg1;
        arg0.fire_runes_count = arg2;
        arg0.wind_runes_count = arg3;
        arg0.earth_runes_count = arg4;
    }

    // decompiled from Move bytecode v6
}

