module 0x552fbece09b8a8dcbc27614577b89e98a840bca4a2573c912138fc50a02d9e28::faction_selection {
    public fun set_faction(arg0: &mut 0x552fbece09b8a8dcbc27614577b89e98a840bca4a2573c912138fc50a02d9e28::character_data::Character, arg1: &0x552fbece09b8a8dcbc27614577b89e98a840bca4a2573c912138fc50a02d9e28::game_data::GameData, arg2: u64) {
        0x552fbece09b8a8dcbc27614577b89e98a840bca4a2573c912138fc50a02d9e28::errors::assert_invalid_item(0x1::option::is_none<u64>(0x552fbece09b8a8dcbc27614577b89e98a840bca4a2573c912138fc50a02d9e28::character_data::get_faction(arg0)));
        let v0 = 0x552fbece09b8a8dcbc27614577b89e98a840bca4a2573c912138fc50a02d9e28::game_data::find_faction_by_id(arg1, arg2);
        0x552fbece09b8a8dcbc27614577b89e98a840bca4a2573c912138fc50a02d9e28::errors::assert_invalid_item(0x1::option::is_some<u64>(&v0));
        *0x552fbece09b8a8dcbc27614577b89e98a840bca4a2573c912138fc50a02d9e28::character_data::faction_mut(arg0) = 0x1::option::some<u64>(arg2);
        0x552fbece09b8a8dcbc27614577b89e98a840bca4a2573c912138fc50a02d9e28::character_data::update_attributes_json(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

