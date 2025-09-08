module 0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::faction_selection {
    public(friend) fun set_faction(arg0: &mut 0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::character_data::Character, arg1: &0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::game_data::GameData, arg2: u64) {
        0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::errors::assert_invalid_item(0x1::option::is_none<u64>(0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::character_data::get_faction(arg0)));
        let v0 = 0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::game_data::find_faction_by_id(arg1, arg2);
        0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::errors::assert_invalid_item(0x1::option::is_some<u64>(&v0));
        *0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::character_data::faction_mut(arg0) = 0x1::option::some<u64>(arg2);
        0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::character_data::update_attributes(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

