module 0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::character {
    public(friend) fun go_raid_with_result(arg0: &mut 0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::character_data::Character, arg1: &mut 0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::game_data::GameData, arg2: &0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::global_buffs::GlobalBuffs, arg3: &0x2::random::Random, arg4: &0x2::clock::Clock, arg5: 0x1::option::Option<u64>, arg6: &mut 0x2::tx_context::TxContext) : 0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::raid_result::RaidResult {
        0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::raid::go_raid(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    // decompiled from Move bytecode v6
}

