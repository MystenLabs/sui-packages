module 0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::character {
    public entry fun customise(arg0: &mut 0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::character_data::Character, arg1: &mut 0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::game_data::GameData, arg2: &0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::render_config::RenderConfig, arg3: u64, arg4: vector<u8>, arg5: u64, arg6: vector<u8>) {
        0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::customization::customise(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun decline_pending(arg0: &mut 0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::character_data::Character, arg1: &mut 0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::game_data::GameData, arg2: u64) {
        0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::customization::decline_pending(arg0, arg1, arg2);
    }

    public entry fun go_raid(arg0: &mut 0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::character_data::Character, arg1: &mut 0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::game_data::GameData, arg2: &0x2::random::Random, arg3: &0x2::clock::Clock, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::raid::go_raid(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

