module 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::faction_selection {
    public(friend) fun set_faction(arg0: &mut 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::character_data::Character, arg1: &0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::game_data::GameData, arg2: u64) {
        0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::errors::assert_invalid_item(0x1::option::is_none<u64>(0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::character_data::get_faction(arg0)));
        let v0 = 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::game_data::find_faction_by_id(arg1, arg2);
        0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::errors::assert_invalid_item(0x1::option::is_some<u64>(&v0));
        *0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::character_data::faction_mut(arg0) = 0x1::option::some<u64>(arg2);
        0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::character_data::update_attributes(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

