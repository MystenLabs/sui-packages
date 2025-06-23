module 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_item_system {
    public(friend) fun burn(arg0: &mut 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_schema::Schema, arg1: u256, arg2: address, arg3: u256) {
        let v0 = 0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_double_map::try_get<address, u256, u256>(0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_schema::balance(arg0), arg2, arg1);
        0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_errors::balance_too_low_error(0x1::option::is_some<u256>(&v0));
        let v1 = 0x1::option::extract<u256>(&mut v0);
        0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_errors::balance_too_low_error(v1 >= arg3);
        if (v1 == arg3) {
            0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_double_map::remove<address, u256, u256>(0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_schema::balance(arg0), arg2, arg1);
        } else {
            0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_double_map::set<address, u256, u256>(0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_schema::balance(arg0), arg2, arg1, v1 - arg3);
        };
    }

    public entry fun craft(arg0: &mut 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_schema::Schema, arg1: u256, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let (v1, v2, v3) = 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_craft_path::get(0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::get<u256, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_craft_path::CraftPath>(0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_schema::item_craft_path(arg0), arg1));
        let v4 = v2;
        let v5 = v1;
        let v6 = 0;
        while (v6 < 0x1::vector::length<u256>(&v5)) {
            burn(arg0, *0x1::vector::borrow<u256>(&v5, v6), v0, *0x1::vector::borrow<u256>(&v4, v6));
            v6 = v6 + 1;
        };
        mint(arg0, arg1, v0, v3);
    }

    public fun encounter_random_item_drop(arg0: &mut 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_schema::Schema, arg1: &mut 0x2::random::RandomGenerator, arg2: address, arg3: 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_monster_info::MonsterInfo, arg4: 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_monster_info::MonsterInfo) {
        let (v0, v1, _, v3) = 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_item_drop::get(0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::get<0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_item_drop::ItemDrop>(0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_schema::encounter_item_drop_config(arg0)));
        let v4 = v3;
        let v5 = v1;
        let v6 = v0;
        let v7 = 0x2::random::generate_u256(arg1) % 1000 + 1;
        0x1::debug::print<u256>(&v7);
        let (_, _, _, v11, _, _, v14, _, _, _) = 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_monster_info::get(&arg3);
        let (_, _, _, v21, _, _, v24, _, _, _) = 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_monster_info::get(&arg4);
        let v28 = if (v21 > v11) {
            (v21 - v11) * 100 / v11
        } else {
            0
        };
        let v29 = if (v24 > v14) {
            (v24 - v14) * 100 / v14
        } else {
            0
        };
        let v30 = (v28 + v29) / 10;
        let v31 = if (v30 > 50) {
            50
        } else {
            v30
        };
        let v32 = v31;
        0x1::debug::print<u256>(&v32);
        let v33 = 0;
        while (v33 < 0x1::vector::length<u256>(&v6)) {
            let v34 = *0x1::vector::borrow<u256>(&v4, v33) + v32;
            0x1::debug::print<u256>(&v34);
            if (v7 <= v34) {
                let v35 = *0x1::vector::borrow<u256>(&v6, v33);
                let v36 = *0x1::vector::borrow<u256>(&v5, v33);
                mint(arg0, v35, arg2, v36);
                0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_events::item_dropped_event(0x1::ascii::string(b"Encounter"), arg2, v35, v36, v7);
                break
            };
            v33 = v33 + 1;
        };
    }

    public(friend) fun mint(arg0: &mut 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_schema::Schema, arg1: u256, arg2: address, arg3: u256) {
        let v0 = 0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_double_map::try_get<address, u256, u256>(0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_schema::balance(arg0), arg2, arg1);
        if (0x1::option::is_some<u256>(&v0)) {
            0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_double_map::set<address, u256, u256>(0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_schema::balance(arg0), arg2, arg1, 0x1::option::extract<u256>(&mut v0) + arg3);
        } else {
            0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_double_map::set<address, u256, u256>(0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_schema::balance(arg0), arg2, arg1, arg3);
        };
    }

    public fun move_random_item_drop(arg0: &mut 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_schema::Schema, arg1: &mut 0x2::random::RandomGenerator, arg2: address) {
        let (v0, v1, _, v3) = 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_item_drop::get(0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::get<0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_item_drop::ItemDrop>(0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_schema::move_item_drop_config(arg0)));
        let v4 = v3;
        let v5 = v1;
        let v6 = v0;
        let v7 = 0x2::random::generate_u256(arg1) % 1000 + 1;
        0x1::debug::print<u256>(&v7);
        let v8 = 0;
        while (v8 < 0x1::vector::length<u256>(&v6)) {
            let v9 = *0x1::vector::borrow<u256>(&v4, v8);
            0x1::debug::print<u256>(&v9);
            if (v7 <= v9) {
                let v10 = *0x1::vector::borrow<u256>(&v6, v8);
                let v11 = *0x1::vector::borrow<u256>(&v5, v8);
                mint(arg0, v10, arg2, v11);
                0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_events::item_dropped_event(0x1::ascii::string(b"Move"), arg2, v10, v11, v7);
                break
            };
            v8 = v8 + 1;
        };
    }

    public entry fun open_treasure_chest(arg0: &mut 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_schema::Schema, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let (v1, v2, _, v4) = 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_item_drop::get(0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::get<0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_item_drop::ItemDrop>(0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_schema::chest_item_drop_config(arg0)));
        let v5 = v4;
        let v6 = v2;
        let v7 = v1;
        let v8 = 0x2::random::new_generator(arg1, arg2);
        let v9 = 0x2::random::generate_u256(&mut v8) % 1000 + 1;
        0x1::debug::print<u256>(&v9);
        let v10 = 0;
        while (v10 < 0x1::vector::length<u256>(&v7)) {
            let v11 = *0x1::vector::borrow<u256>(&v5, v10);
            0x1::debug::print<u256>(&v11);
            if (v9 <= v11) {
                let v12 = *0x1::vector::borrow<u256>(&v7, v10);
                let v13 = *0x1::vector::borrow<u256>(&v6, v10);
                burn(arg0, 9, v0, 1);
                mint(arg0, v12, v0, v13);
                0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_events::item_dropped_event(0x1::ascii::string(b"Treasure Chest"), v0, v12, v13, v9);
                break
            };
            v10 = v10 + 1;
        };
    }

    public fun register(arg0: &mut 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_schema::Schema, arg1: 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_item_type::ItemType, arg2: 0x1::ascii::String, arg3: 0x1::ascii::String, arg4: bool) {
        let v0 = *0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::get<u256>(0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_schema::next_item_id(arg0));
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::set<u256, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_item_metadata::ItemMetadata>(0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_schema::item_metadata(arg0), v0, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_item_metadata::new(arg1, arg2, arg3, arg4));
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::set<u256>(0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_schema::next_item_id(arg0), v0 + 1);
    }

    public(friend) fun transfer(arg0: &mut 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_schema::Schema, arg1: u256, arg2: address, arg3: address, arg4: u256) {
        burn(arg0, arg1, arg2, arg4);
        mint(arg0, arg1, arg3, arg4);
    }

    public fun update_chest_drop_config(arg0: &mut 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_schema::Schema, arg1: vector<u256>, arg2: vector<u256>, arg3: vector<u256>, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<u256>();
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u256>(&arg2)) {
            v1 = v1 + *0x1::vector::borrow<u256>(&arg3, v2);
            0x1::vector::push_back<u256>(&mut v0, v1);
            v2 = v2 + 1;
        };
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::set<0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_item_drop::ItemDrop>(0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_schema::chest_item_drop_config(arg0), 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_item_drop::new(arg1, arg2, arg3, v0));
    }

    public fun update_craft_path(arg0: &mut 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_schema::Schema, arg1: u256, arg2: vector<u256>, arg3: vector<u256>, arg4: u256, arg5: &0x2::tx_context::TxContext) {
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::set<u256, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_craft_path::CraftPath>(0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_schema::item_craft_path(arg0), arg1, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_craft_path::new(arg2, arg3, arg4));
    }

    public fun update_encounter_drop_config(arg0: &mut 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_schema::Schema, arg1: vector<u256>, arg2: vector<u256>, arg3: vector<u256>, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<u256>();
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u256>(&arg2)) {
            v1 = v1 + *0x1::vector::borrow<u256>(&arg3, v2);
            0x1::vector::push_back<u256>(&mut v0, v1);
            v2 = v2 + 1;
        };
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::set<0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_item_drop::ItemDrop>(0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_schema::encounter_item_drop_config(arg0), 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_item_drop::new(arg1, arg2, arg3, v0));
    }

    public fun update_move_drop_config(arg0: &mut 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_schema::Schema, arg1: vector<u256>, arg2: vector<u256>, arg3: vector<u256>, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<u256>();
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u256>(&arg2)) {
            v1 = v1 + *0x1::vector::borrow<u256>(&arg3, v2);
            0x1::vector::push_back<u256>(&mut v0, v1);
            v2 = v2 + 1;
        };
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::set<0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_item_drop::ItemDrop>(0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_schema::move_item_drop_config(arg0), 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_item_drop::new(arg1, arg2, arg3, v0));
    }

    // decompiled from Move bytecode v6
}

