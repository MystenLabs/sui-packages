module 0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::faction_selection {
    public fun set_faction(arg0: &mut 0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::character_data::Character, arg1: &0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::game_data::GameData, arg2: u64) {
        0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::errors::assert_invalid_item(0x1::option::is_none<u64>(0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::character_data::get_faction(arg0)));
        let v0 = 0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::game_data::find_faction_by_id(arg1, arg2);
        0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::errors::assert_invalid_item(0x1::option::is_some<u64>(&v0));
        *0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::character_data::faction_mut(arg0) = 0x1::option::some<u64>(arg2);
        0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::character_data::build_and_update_attributes(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

