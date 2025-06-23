module 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_monster_system {
    entry fun claim_monster(arg0: &mut 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_schema::Schema, arg1: &0x2::tx_context::TxContext) {
        let v0 = *0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::get<u256>(0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_schema::next_monster_id(arg0));
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::set<u256, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_monster_info::MonsterInfo>(0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_schema::monster(arg0), v0, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_monster_info::new(0x1::ascii::string(b"iguanignite"), 0, 25, 25, vector[1], 5, 5, 5, 52, 125));
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::set<u256, address>(0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_schema::monster_owned_by(arg0), v0, 0x2::tx_context::sender(arg1));
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_value::set<u256>(0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_schema::next_monster_id(arg0), v0 + 1);
    }

    public entry fun enhance_monster(arg0: &mut 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_schema::Schema, arg1: u256, arg2: u256, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_errors::monster_not_found_error(0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::contains<u256, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_monster_info::MonsterInfo>(0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_schema::monster(arg0), arg2));
        0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_errors::not_your_monster_error(*0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::get<u256, address>(0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_schema::monster_owned_by(arg0), arg2) == v0);
        let (v1, v2, v3, v4, v5, v6, v7, v8, v9, v10) = 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_monster_info::get(0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::get<u256, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_monster_info::MonsterInfo>(0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_schema::monster(arg0), arg2));
        let v11 = v3;
        if (arg1 == 3) {
            v11 = v4;
        } else if (arg1 == 4) {
            v11 = 0x1::u256::min(v3 + v4 / 2, v4);
        };
        0x20b06284790f183076402b03c055add0b7010e158e8f21356f6d607288d38a40::storage_map::set<u256, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_monster_info::MonsterInfo>(0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_schema::monster(arg0), arg2, 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_monster_info::new(v1, v2, v11, v4, v5, v6, v7, v8, v9, v10));
        0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_item_system::burn(arg0, arg1, v0, 1);
    }

    // decompiled from Move bytecode v6
}

