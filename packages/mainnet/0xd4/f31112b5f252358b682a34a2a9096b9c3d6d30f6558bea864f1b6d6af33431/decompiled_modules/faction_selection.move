module 0xd4f31112b5f252358b682a34a2a9096b9c3d6d30f6558bea864f1b6d6af33431::faction_selection {
    public fun set_faction(arg0: &mut 0xd4f31112b5f252358b682a34a2a9096b9c3d6d30f6558bea864f1b6d6af33431::character_data::Character, arg1: &0xd4f31112b5f252358b682a34a2a9096b9c3d6d30f6558bea864f1b6d6af33431::game_data::GameData, arg2: u64) {
        0xd4f31112b5f252358b682a34a2a9096b9c3d6d30f6558bea864f1b6d6af33431::errors::assert_invalid_item(0x1::option::is_none<u64>(0xd4f31112b5f252358b682a34a2a9096b9c3d6d30f6558bea864f1b6d6af33431::character_data::get_faction(arg0)));
        let v0 = 0xd4f31112b5f252358b682a34a2a9096b9c3d6d30f6558bea864f1b6d6af33431::game_data::find_faction_by_id(arg1, arg2);
        0xd4f31112b5f252358b682a34a2a9096b9c3d6d30f6558bea864f1b6d6af33431::errors::assert_invalid_item(0x1::option::is_some<u64>(&v0));
        *0xd4f31112b5f252358b682a34a2a9096b9c3d6d30f6558bea864f1b6d6af33431::character_data::faction_mut(arg0) = 0x1::option::some<u64>(arg2);
        0xd4f31112b5f252358b682a34a2a9096b9c3d6d30f6558bea864f1b6d6af33431::character_data::build_and_update_attributes(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

