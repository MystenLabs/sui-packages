module 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::faction_selection {
    public fun set_faction(arg0: &mut 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::character_data::Character, arg1: &0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::game_data::GameData, arg2: u64) {
        0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::errors::assert_invalid_item(0x1::option::is_none<u64>(0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::character_data::get_faction(arg0)));
        let v0 = 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::game_data::find_faction_by_id(arg1, arg2);
        0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::errors::assert_invalid_item(0x1::option::is_some<u64>(&v0));
        *0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::character_data::faction_mut(arg0) = 0x1::option::some<u64>(arg2);
        0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::character_data::update_attributes(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

