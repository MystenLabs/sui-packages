module 0xcc778e6d3e23e17ea3b7f2077a4896b5b44c1d83cea6b5ed62d2dc7203adabd8::faction_selection {
    public(friend) fun set_faction(arg0: &mut 0xcc778e6d3e23e17ea3b7f2077a4896b5b44c1d83cea6b5ed62d2dc7203adabd8::character_data::Character, arg1: &0xcc778e6d3e23e17ea3b7f2077a4896b5b44c1d83cea6b5ed62d2dc7203adabd8::game_data::GameData, arg2: u64) {
        0xcc778e6d3e23e17ea3b7f2077a4896b5b44c1d83cea6b5ed62d2dc7203adabd8::errors::assert_invalid_item(0x1::option::is_none<u64>(0xcc778e6d3e23e17ea3b7f2077a4896b5b44c1d83cea6b5ed62d2dc7203adabd8::character_data::get_faction(arg0)));
        let v0 = 0xcc778e6d3e23e17ea3b7f2077a4896b5b44c1d83cea6b5ed62d2dc7203adabd8::game_data::find_faction_by_id(arg1, arg2);
        0xcc778e6d3e23e17ea3b7f2077a4896b5b44c1d83cea6b5ed62d2dc7203adabd8::errors::assert_invalid_item(0x1::option::is_some<u64>(&v0));
        *0xcc778e6d3e23e17ea3b7f2077a4896b5b44c1d83cea6b5ed62d2dc7203adabd8::character_data::faction_mut(arg0) = 0x1::option::some<u64>(arg2);
        0xcc778e6d3e23e17ea3b7f2077a4896b5b44c1d83cea6b5ed62d2dc7203adabd8::character_data::update_attributes(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

