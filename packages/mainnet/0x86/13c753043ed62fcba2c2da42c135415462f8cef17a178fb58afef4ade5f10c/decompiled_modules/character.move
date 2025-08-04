module 0x8613c753043ed62fcba2c2da42c135415462f8cef17a178fb58afef4ade5f10c::character {
    public entry fun customise(arg0: &mut 0x8613c753043ed62fcba2c2da42c135415462f8cef17a178fb58afef4ade5f10c::character_data::Character, arg1: &mut 0x8613c753043ed62fcba2c2da42c135415462f8cef17a178fb58afef4ade5f10c::game_data::GameData, arg2: &0x8613c753043ed62fcba2c2da42c135415462f8cef17a178fb58afef4ade5f10c::render_config::RenderConfig, arg3: u64, arg4: vector<u8>, arg5: u64, arg6: vector<u8>) {
        0x8613c753043ed62fcba2c2da42c135415462f8cef17a178fb58afef4ade5f10c::customization::customise(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun decline_pending(arg0: &mut 0x8613c753043ed62fcba2c2da42c135415462f8cef17a178fb58afef4ade5f10c::character_data::Character, arg1: &mut 0x8613c753043ed62fcba2c2da42c135415462f8cef17a178fb58afef4ade5f10c::game_data::GameData, arg2: u64) {
        0x8613c753043ed62fcba2c2da42c135415462f8cef17a178fb58afef4ade5f10c::customization::decline_pending(arg0, arg1, arg2);
    }

    public entry fun go_raid(arg0: &mut 0x8613c753043ed62fcba2c2da42c135415462f8cef17a178fb58afef4ade5f10c::character_data::Character, arg1: &mut 0x8613c753043ed62fcba2c2da42c135415462f8cef17a178fb58afef4ade5f10c::game_data::GameData, arg2: &0x2::random::Random, arg3: &0x2::clock::Clock, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        0x8613c753043ed62fcba2c2da42c135415462f8cef17a178fb58afef4ade5f10c::raid::go_raid(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

