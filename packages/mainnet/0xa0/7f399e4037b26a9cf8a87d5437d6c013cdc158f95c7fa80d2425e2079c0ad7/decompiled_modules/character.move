module 0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::character {
    public(friend) fun go_raid_with_result(arg0: &mut 0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::character_data::Character, arg1: &mut 0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::game_data::GameData, arg2: &0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::global_buffs::GlobalBuffs, arg3: &0x2::random::Random, arg4: &0x2::clock::Clock, arg5: 0x1::option::Option<u64>, arg6: &mut 0x2::tx_context::TxContext) : 0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::raid_result::RaidResult {
        0xa07f399e4037b26a9cf8a87d5437d6c013cdc158f95c7fa80d2425e2079c0ad7::raid::go_raid(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    // decompiled from Move bytecode v6
}

