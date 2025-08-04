module 0x3ece324a504a6c5d83109488bc63bc1de48a5b0a486d5611cf7c52fbdfc5e701::faction_selection {
    public fun set_faction(arg0: &mut 0x3ece324a504a6c5d83109488bc63bc1de48a5b0a486d5611cf7c52fbdfc5e701::character_data::Character, arg1: &0x3ece324a504a6c5d83109488bc63bc1de48a5b0a486d5611cf7c52fbdfc5e701::game_data::GameData, arg2: u64) {
        0x3ece324a504a6c5d83109488bc63bc1de48a5b0a486d5611cf7c52fbdfc5e701::errors::assert_invalid_item(0x1::option::is_none<u64>(0x3ece324a504a6c5d83109488bc63bc1de48a5b0a486d5611cf7c52fbdfc5e701::character_data::get_faction(arg0)));
        let v0 = 0x3ece324a504a6c5d83109488bc63bc1de48a5b0a486d5611cf7c52fbdfc5e701::game_data::find_faction_by_id(arg1, arg2);
        0x3ece324a504a6c5d83109488bc63bc1de48a5b0a486d5611cf7c52fbdfc5e701::errors::assert_invalid_item(0x1::option::is_some<u64>(&v0));
        *0x3ece324a504a6c5d83109488bc63bc1de48a5b0a486d5611cf7c52fbdfc5e701::character_data::faction_mut(arg0) = 0x1::option::some<u64>(arg2);
        0x3ece324a504a6c5d83109488bc63bc1de48a5b0a486d5611cf7c52fbdfc5e701::character_data::update_attributes(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

