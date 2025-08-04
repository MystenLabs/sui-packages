module 0x8613c753043ed62fcba2c2da42c135415462f8cef17a178fb58afef4ade5f10c::faction_selection {
    public fun set_faction(arg0: &mut 0x8613c753043ed62fcba2c2da42c135415462f8cef17a178fb58afef4ade5f10c::character_data::Character, arg1: &0x8613c753043ed62fcba2c2da42c135415462f8cef17a178fb58afef4ade5f10c::game_data::GameData, arg2: u64) {
        0x8613c753043ed62fcba2c2da42c135415462f8cef17a178fb58afef4ade5f10c::errors::assert_invalid_item(0x1::option::is_none<u64>(0x8613c753043ed62fcba2c2da42c135415462f8cef17a178fb58afef4ade5f10c::character_data::get_faction(arg0)));
        let v0 = 0x8613c753043ed62fcba2c2da42c135415462f8cef17a178fb58afef4ade5f10c::game_data::find_faction_by_id(arg1, arg2);
        0x8613c753043ed62fcba2c2da42c135415462f8cef17a178fb58afef4ade5f10c::errors::assert_invalid_item(0x1::option::is_some<u64>(&v0));
        *0x8613c753043ed62fcba2c2da42c135415462f8cef17a178fb58afef4ade5f10c::character_data::faction_mut(arg0) = 0x1::option::some<u64>(arg2);
        0x8613c753043ed62fcba2c2da42c135415462f8cef17a178fb58afef4ade5f10c::character_data::update_attributes(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

