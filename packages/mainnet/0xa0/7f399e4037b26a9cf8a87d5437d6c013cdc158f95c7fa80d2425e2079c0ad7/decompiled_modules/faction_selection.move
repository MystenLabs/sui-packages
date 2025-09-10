module 0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::faction_selection {
    public(friend) fun set_faction(arg0: &mut 0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::character_data::Character, arg1: &0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::game_data::GameData, arg2: u64) {
        0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::errors::assert_invalid_item(0x1::option::is_none<u64>(0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::character_data::get_faction(arg0)));
        let v0 = 0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::game_data::find_faction_by_id(arg1, arg2);
        0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::errors::assert_invalid_item(0x1::option::is_some<u64>(&v0));
        *0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::character_data::faction_mut(arg0) = 0x1::option::some<u64>(arg2);
        0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::character_data::update_attributes(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

