module 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::faction_selection {
    public fun set_faction(arg0: &mut 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::Character, arg1: &0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::game_data::GameData, arg2: u64) {
        0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::errors::assert_invalid_item(0x1::option::is_none<u64>(0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::get_faction(arg0)));
        let v0 = 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::game_data::find_faction_by_id(arg1, arg2);
        0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::errors::assert_invalid_item(0x1::option::is_some<u64>(&v0));
        *0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::faction_mut(arg0) = 0x1::option::some<u64>(arg2);
        0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::update_attributes(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

