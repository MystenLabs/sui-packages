module 0xd4f31112b5f252358b682a34a2a9096b9c3d6d30f6558bea864f1b6d6af33431::character {
    public entry fun customise(arg0: &mut 0xd4f31112b5f252358b682a34a2a9096b9c3d6d30f6558bea864f1b6d6af33431::character_data::Character, arg1: &mut 0xd4f31112b5f252358b682a34a2a9096b9c3d6d30f6558bea864f1b6d6af33431::game_data::GameData, arg2: &0xd4f31112b5f252358b682a34a2a9096b9c3d6d30f6558bea864f1b6d6af33431::render_config::RenderConfig, arg3: u64, arg4: vector<u8>, arg5: u64, arg6: vector<u8>) {
        0xd4f31112b5f252358b682a34a2a9096b9c3d6d30f6558bea864f1b6d6af33431::customization::customise(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun decline_pending(arg0: &mut 0xd4f31112b5f252358b682a34a2a9096b9c3d6d30f6558bea864f1b6d6af33431::character_data::Character, arg1: &mut 0xd4f31112b5f252358b682a34a2a9096b9c3d6d30f6558bea864f1b6d6af33431::game_data::GameData, arg2: u64) {
        0xd4f31112b5f252358b682a34a2a9096b9c3d6d30f6558bea864f1b6d6af33431::customization::decline_pending(arg0, arg1, arg2);
    }

    public entry fun go_raid(arg0: &mut 0xd4f31112b5f252358b682a34a2a9096b9c3d6d30f6558bea864f1b6d6af33431::character_data::Character, arg1: &mut 0xd4f31112b5f252358b682a34a2a9096b9c3d6d30f6558bea864f1b6d6af33431::game_data::GameData, arg2: &0x2::random::Random, arg3: &0x2::clock::Clock, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) {
        0xd4f31112b5f252358b682a34a2a9096b9c3d6d30f6558bea864f1b6d6af33431::raid::go_raid(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

