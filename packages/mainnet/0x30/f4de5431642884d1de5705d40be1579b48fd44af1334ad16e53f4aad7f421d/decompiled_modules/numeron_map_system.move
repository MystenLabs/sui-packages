module 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_map_system {
    entry fun move_position(arg0: &mut 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_schema::Schema, arg1: &0x2::random::Random, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_errors::not_registered_error(0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::contains<address, bool>(0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_schema::player(arg0), v0));
        0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_errors::already_in_encounter_error(!0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::contains<address, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_encounter_info::EncounterInfo>(0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_schema::encounter(arg0), v0));
        0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_errors::not_in_current_map_error(0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::contains<address, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_position::Position>(0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_schema::position(arg0), v0));
        let (v1, v2, v3) = 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_position::get(0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::get<address, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_position::Position>(0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_schema::position(arg0), v0));
        let v4 = v3;
        let v5 = v2;
        let v6 = &arg2;
        if (*v6 == 0) {
            v4 = v3 - 1;
        } else if (*v6 == 1) {
            v4 = v3 + 1;
        } else if (*v6 == 2) {
            v5 = v2 - 1;
        } else if (*v6 == 3) {
            v5 = v2 + 1;
        } else {
            0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_errors::invalid_direction_error(false);
        };
        let v7 = 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_position::new(v1, v5, v4);
        0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_errors::space_obstructed_error(!0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::contains<0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_position::Position, bool>(0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_schema::obstruction(arg0), v7));
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::set<address, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_position::Position>(0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_schema::position(arg0), v0, v7);
        let v8 = 0x2::random::new_generator(arg1, arg3);
        if (0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::contains<0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_position::Position, bool>(0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_schema::encounter_trigger(arg0), v7)) {
            let v9 = 0x2::random::generate_u128(&mut v8);
            0x1::debug::print<u128>(&v9);
            if (v9 % 2 == 0) {
                let v10 = &mut v8;
                start_encounter(arg0, v10, v0);
            };
        } else {
            0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_item_system::move_random_item_drop(arg0, &mut v8, v0);
        };
    }

    entry fun register(arg0: &mut 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_schema::Schema, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_errors::already_registered_error(!0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::contains<address, bool>(0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_schema::player(arg0), v0));
        let v1 = 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_position::new(arg1, arg2, arg3);
        0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_errors::space_obstructed_error(!0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::contains<0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_position::Position, bool>(0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_schema::obstruction(arg0), v1));
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::set<address, bool>(0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_schema::player(arg0), v0, true);
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::set<address, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_position::Position>(0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_schema::position(arg0), v0, v1);
        0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_events::player_registered_event(v0, v1);
    }

    fun start_encounter(arg0: &mut 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_schema::Schema, arg1: &mut 0x2::random::RandomGenerator, arg2: address) {
        0x2::random::generate_u256(arg1);
        let v0 = *0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::get<u256>(0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_schema::next_monster_id(arg0));
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::set<u256, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_monster_info::MonsterInfo>(0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_schema::monster(arg0), v0, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_monster_info::new(0x1::ascii::string(b"carnodusk"), 0, 25, 25, vector[1], 5, 5, 5, 52, 125));
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::set<address, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_encounter_info::EncounterInfo>(0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_schema::encounter(arg0), arg2, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_encounter_info::new(v0, false));
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::set<u256>(0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_schema::next_monster_id(arg0), v0 + 1);
    }

    entry fun switch_map(arg0: &mut 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_schema::Schema, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_errors::not_registered_error(0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::contains<address, bool>(0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_schema::player(arg0), v0));
        0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_errors::not_in_current_map_error(0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::contains<address, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_position::Position>(0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_schema::position(arg0), v0));
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::set<address, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_position::Position>(0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_schema::position(arg0), v0, *0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::get<address, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_position::Position>(0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_schema::position(arg0), v0));
    }

    public entry fun teleport(arg0: &mut 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_schema::Schema, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_errors::not_registered_error(0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::contains<address, bool>(0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_schema::player(arg0), v0));
        0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_errors::not_in_current_map_error(0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::contains<address, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_position::Position>(0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_schema::position(arg0), v0));
        let v1 = *0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::get<address, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_position::Position>(0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_schema::position(arg0), v0);
        0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_errors::not_teleport_point_error(0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::contains<0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_position::Position, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_position::Position>(0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_schema::teleport_point(arg0), v1));
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::set<address, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_position::Position>(0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_schema::position(arg0), v0, *0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::get<0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_position::Position, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_position::Position>(0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_schema::teleport_point(arg0), v1));
    }

    // decompiled from Move bytecode v6
}

