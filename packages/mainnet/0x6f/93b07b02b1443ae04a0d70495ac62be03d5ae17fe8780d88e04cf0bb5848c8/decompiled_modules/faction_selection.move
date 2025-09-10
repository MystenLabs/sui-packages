module 0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::faction_selection {
    public(friend) fun set_faction(arg0: &mut 0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::character_data::Character, arg1: &0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::game_data::GameData, arg2: u64) {
        0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::errors::assert_invalid_item(0x1::option::is_none<u64>(0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::character_data::get_faction(arg0)));
        let v0 = 0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::game_data::find_faction_by_id(arg1, arg2);
        0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::errors::assert_invalid_item(0x1::option::is_some<u64>(&v0));
        *0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::character_data::faction_mut(arg0) = 0x1::option::some<u64>(arg2);
        0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::character_data::update_attributes(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

