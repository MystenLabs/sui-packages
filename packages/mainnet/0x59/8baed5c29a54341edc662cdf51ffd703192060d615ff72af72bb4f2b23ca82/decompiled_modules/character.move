module 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::character {
    public(friend) fun customise(arg0: &mut 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::character_data::Character, arg1: &0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::game_data::GameData, arg2: &0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::render_config::RenderConfig, arg3: u64, arg4: 0x1::option::Option<0x1::string::String>, arg5: u64, arg6: vector<u8>, arg7: &0x2::clock::Clock) {
        0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::customization::customise(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public(friend) fun go_raid_with_result(arg0: &mut 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::character_data::Character, arg1: &mut 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::game_data::GameData, arg2: &0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::global_buffs::GlobalBuffs, arg3: &0x2::random::Random, arg4: &0x2::clock::Clock, arg5: 0x1::option::Option<u64>, arg6: &mut 0x2::tx_context::TxContext) : 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::raid_result::RaidResult {
        0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::raid::go_raid(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    // decompiled from Move bytecode v6
}

