module 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::character {
    public entry fun customise(arg0: &mut 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::character_data::Character, arg1: &mut 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::game_data::GameData, arg2: u64, arg3: vector<u8>, arg4: u64, arg5: vector<u8>) {
        0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::customization::customise(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun decline_pending(arg0: &mut 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::character_data::Character, arg1: &mut 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::game_data::GameData, arg2: u64) {
        0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::customization::decline_pending(arg0, arg1, arg2);
    }

    public entry fun go_raid(arg0: &mut 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::character_data::Character, arg1: &mut 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::game_data::GameData, arg2: &0x2::random::Random, arg3: &0x2::clock::Clock, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::raid::go_raid(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

