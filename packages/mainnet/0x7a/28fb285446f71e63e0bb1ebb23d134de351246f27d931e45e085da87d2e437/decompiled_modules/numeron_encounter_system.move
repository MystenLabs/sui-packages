module 0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_encounter_system {
    entry fun battle(arg0: &mut 0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_schema::Schema, arg1: &0x2::random::Random, arg2: u256, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_errors::not_in_encounter_error(0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::contains<address, 0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_encounter_info::EncounterInfo>(0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_schema::encounter(arg0), v0));
        let (v1, v2) = 0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_encounter_info::get(0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::get<address, 0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_encounter_info::EncounterInfo>(0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_schema::encounter(arg0), v0));
        if (!v2) {
            0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::set<address, 0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_encounter_info::EncounterInfo>(0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_schema::encounter(arg0), v0, 0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_encounter_info::new(v1, true));
        };
        let v3 = *0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::get<u256, 0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_monster_info::MonsterInfo>(0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_schema::monster(arg0), v1);
        let v4 = *0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::get<u256, 0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_monster_info::MonsterInfo>(0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_schema::monster(arg0), arg2);
        let (v5, v6, v7, v8, v9, v10, v11, v12, v13, v14) = 0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_monster_info::get(&v3);
        let (v15, v16, v17, v18, v19, v20, v21, v22, v23, v24) = 0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_monster_info::get(&v4);
        if (v7 <= v21) {
            0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::remove<u256, 0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_monster_info::MonsterInfo>(0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_schema::monster(arg0), v1);
            0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::remove<address, 0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_encounter_info::EncounterInfo>(0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_schema::encounter(arg0), v0);
            let v25 = 0x2::random::new_generator(arg1, arg3);
            0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_item_system::encounter_random_item_drop(arg0, &mut v25, v0, v4, v3);
        } else if (v17 <= v11) {
            0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::remove<u256, 0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_monster_info::MonsterInfo>(0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_schema::monster(arg0), v1);
            0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::remove<address, 0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_encounter_info::EncounterInfo>(0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_schema::encounter(arg0), v0);
            0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::set<address, 0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_position::Position>(0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_schema::position(arg0), v0, 0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_position::new(1, 5, 7));
        } else {
            0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::set<u256, 0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_monster_info::MonsterInfo>(0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_schema::monster(arg0), v1, 0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_monster_info::new(v5, v6, v7 - v21, v8, v9, v10, v11, v12, v13, v14));
            0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::set<u256, 0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_monster_info::MonsterInfo>(0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_schema::monster(arg0), arg2, 0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_monster_info::new(v15, v16, v17 - v11, v18, v19, v20, v21, v22, v23, v24));
        };
    }

    public entry fun capture(arg0: &mut 0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_schema::Schema, arg1: &0x2::random::Random, arg2: u256, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_errors::not_in_encounter_error(0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::contains<address, 0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_encounter_info::EncounterInfo>(0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_schema::encounter(arg0), v0));
        0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_item_system::burn(arg0, arg2, v0, 1);
        let v1 = 0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_encounter_info::get_monster_id(0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::get<address, 0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_encounter_info::EncounterInfo>(0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_schema::encounter(arg0), v0));
        let (_, _, v4, v5, _, _, _, _, _, _) = 0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_monster_info::get(0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::get<u256, 0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_monster_info::MonsterInfo>(0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_schema::monster(arg0), v1));
        let v12 = 0x2::random::new_generator(arg1, arg3);
        let (v13, v14) = if (arg2 == 6) {
            (100, 400)
        } else if (arg2 == 7) {
            (200, 600)
        } else if (arg2 == 8) {
            (300, 800)
        } else {
            (100, 400)
        };
        let v15 = v13 + (1000 - v4 * 1000 / v5) * (v14 - v13) / 1000;
        let v16 = if (v15 > v14) {
            v14
        } else {
            v15
        };
        let v17 = v16;
        0x1::debug::print<u256>(&v17);
        if (0x2::random::generate_u256(&mut v12) % 1000 + 1 <= v17) {
            0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::remove<address, 0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_encounter_info::EncounterInfo>(0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_schema::encounter(arg0), v0);
            0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::set<u256, address>(0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_schema::monster_owned_by(arg0), v1, v0);
            let v18 = 0x1::ascii::string(b"Monster captured successfully!");
            0x1::debug::print<0x1::ascii::String>(&v18);
            0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_events::monster_catch_attempt_event(v0, v1, 0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_monster_catch_result::new_caught());
        } else {
            let v19 = 0x1::ascii::string(b"Capture failed!");
            0x1::debug::print<0x1::ascii::String>(&v19);
            0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_events::monster_catch_attempt_event(v0, v1, 0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_monster_catch_result::new_missed());
        };
    }

    entry fun flee(arg0: &mut 0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_schema::Schema, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_errors::not_in_encounter_error(0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::contains<address, 0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_encounter_info::EncounterInfo>(0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_schema::encounter(arg0), v0));
        let (v1, v2) = 0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_encounter_info::get(0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::get<address, 0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_encounter_info::EncounterInfo>(0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_schema::encounter(arg0), v0));
        if (arg1 && v2) {
            0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_item_system::burn(arg0, 5, v0, 1);
        } else {
            0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_errors::already_in_battle_error(!v2);
        };
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::remove<address, 0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_encounter_info::EncounterInfo>(0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_schema::encounter(arg0), v0);
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::remove<u256, 0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_monster_info::MonsterInfo>(0x7a28fb285446f71e63e0bb1ebb23d134de351246f27d931e45e085da87d2e437::numeron_schema::monster(arg0), v1);
    }

    // decompiled from Move bytecode v6
}

