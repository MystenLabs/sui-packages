module 0x3ece324a504a6c5d83109488bc63bc1de48a5b0a486d5611cf7c52fbdfc5e701::character {
    public entry fun customise(arg0: &mut 0x3ece324a504a6c5d83109488bc63bc1de48a5b0a486d5611cf7c52fbdfc5e701::character_data::Character, arg1: &mut 0x3ece324a504a6c5d83109488bc63bc1de48a5b0a486d5611cf7c52fbdfc5e701::game_data::GameData, arg2: &0x3ece324a504a6c5d83109488bc63bc1de48a5b0a486d5611cf7c52fbdfc5e701::render_config::RenderConfig, arg3: u64, arg4: vector<u8>, arg5: u64, arg6: vector<u8>) {
        0x3ece324a504a6c5d83109488bc63bc1de48a5b0a486d5611cf7c52fbdfc5e701::customization::customise(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun decline_pending(arg0: &mut 0x3ece324a504a6c5d83109488bc63bc1de48a5b0a486d5611cf7c52fbdfc5e701::character_data::Character, arg1: &mut 0x3ece324a504a6c5d83109488bc63bc1de48a5b0a486d5611cf7c52fbdfc5e701::game_data::GameData, arg2: u64) {
        0x3ece324a504a6c5d83109488bc63bc1de48a5b0a486d5611cf7c52fbdfc5e701::customization::decline_pending(arg0, arg1, arg2);
    }

    public entry fun go_raid(arg0: &mut 0x3ece324a504a6c5d83109488bc63bc1de48a5b0a486d5611cf7c52fbdfc5e701::character_data::Character, arg1: &mut 0x3ece324a504a6c5d83109488bc63bc1de48a5b0a486d5611cf7c52fbdfc5e701::game_data::GameData, arg2: &0x2::random::Random, arg3: &0x2::clock::Clock, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        0x3ece324a504a6c5d83109488bc63bc1de48a5b0a486d5611cf7c52fbdfc5e701::raid::go_raid(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

