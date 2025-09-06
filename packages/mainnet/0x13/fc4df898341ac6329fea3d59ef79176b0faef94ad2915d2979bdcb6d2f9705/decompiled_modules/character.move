module 0x13fc4df898341ac6329fea3d59ef79176b0faef94ad2915d2979bdcb6d2f9705::character {
    public(friend) fun go_raid_with_result(arg0: &mut 0x13fc4df898341ac6329fea3d59ef79176b0faef94ad2915d2979bdcb6d2f9705::character_data::Character, arg1: &mut 0x13fc4df898341ac6329fea3d59ef79176b0faef94ad2915d2979bdcb6d2f9705::game_data::GameData, arg2: &0x13fc4df898341ac6329fea3d59ef79176b0faef94ad2915d2979bdcb6d2f9705::global_buffs::GlobalBuffs, arg3: &0x2::random::Random, arg4: &0x2::clock::Clock, arg5: 0x1::option::Option<u64>, arg6: &mut 0x2::tx_context::TxContext) : 0x13fc4df898341ac6329fea3d59ef79176b0faef94ad2915d2979bdcb6d2f9705::raid_result::RaidResult {
        0x13fc4df898341ac6329fea3d59ef79176b0faef94ad2915d2979bdcb6d2f9705::raid::go_raid(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    // decompiled from Move bytecode v6
}

