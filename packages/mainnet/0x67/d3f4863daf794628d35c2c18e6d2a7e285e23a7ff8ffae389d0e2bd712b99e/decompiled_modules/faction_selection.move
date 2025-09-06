module 0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::faction_selection {
    public(friend) fun set_faction(arg0: &mut 0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::character_data::Character, arg1: &0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::game_data::GameData, arg2: u64) {
        0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::errors::assert_invalid_item(0x1::option::is_none<u64>(0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::character_data::get_faction(arg0)));
        let v0 = 0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::game_data::find_faction_by_id(arg1, arg2);
        0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::errors::assert_invalid_item(0x1::option::is_some<u64>(&v0));
        *0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::character_data::faction_mut(arg0) = 0x1::option::some<u64>(arg2);
        0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::character_data::update_attributes(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

