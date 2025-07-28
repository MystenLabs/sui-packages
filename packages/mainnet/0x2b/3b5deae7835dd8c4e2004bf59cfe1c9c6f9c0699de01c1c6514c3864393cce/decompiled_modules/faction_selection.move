module 0x2b3b5deae7835dd8c4e2004bf59cfe1c9c6f9c0699de01c1c6514c3864393cce::faction_selection {
    public fun set_faction(arg0: &mut 0x2b3b5deae7835dd8c4e2004bf59cfe1c9c6f9c0699de01c1c6514c3864393cce::character_data::Character, arg1: &0x2b3b5deae7835dd8c4e2004bf59cfe1c9c6f9c0699de01c1c6514c3864393cce::game_data::GameData, arg2: u64) {
        0x2b3b5deae7835dd8c4e2004bf59cfe1c9c6f9c0699de01c1c6514c3864393cce::errors::assert_invalid_item(0x1::option::is_none<u64>(0x2b3b5deae7835dd8c4e2004bf59cfe1c9c6f9c0699de01c1c6514c3864393cce::character_data::get_faction(arg0)));
        let v0 = 0x2b3b5deae7835dd8c4e2004bf59cfe1c9c6f9c0699de01c1c6514c3864393cce::game_data::find_faction_by_id(arg1, arg2);
        0x2b3b5deae7835dd8c4e2004bf59cfe1c9c6f9c0699de01c1c6514c3864393cce::errors::assert_invalid_item(0x1::option::is_some<u64>(&v0));
        *0x2b3b5deae7835dd8c4e2004bf59cfe1c9c6f9c0699de01c1c6514c3864393cce::character_data::faction_mut(arg0) = 0x1::option::some<u64>(arg2);
        0x2b3b5deae7835dd8c4e2004bf59cfe1c9c6f9c0699de01c1c6514c3864393cce::character_data::update_attributes(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

