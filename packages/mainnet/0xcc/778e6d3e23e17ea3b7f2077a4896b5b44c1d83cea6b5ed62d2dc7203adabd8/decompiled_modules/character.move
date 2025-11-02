module 0xcc778e6d3e23e17ea3b7f2077a4896b5b44c1d83cea6b5ed62d2dc7203adabd8::character {
    public(friend) fun go_raid_with_result(arg0: &mut 0xcc778e6d3e23e17ea3b7f2077a4896b5b44c1d83cea6b5ed62d2dc7203adabd8::character_data::Character, arg1: &mut 0xcc778e6d3e23e17ea3b7f2077a4896b5b44c1d83cea6b5ed62d2dc7203adabd8::game_data::GameData, arg2: &0xcc778e6d3e23e17ea3b7f2077a4896b5b44c1d83cea6b5ed62d2dc7203adabd8::global_buffs::GlobalBuffs, arg3: &0x2::random::Random, arg4: &0x2::clock::Clock, arg5: 0x1::option::Option<u64>, arg6: &mut 0x2::tx_context::TxContext) : 0xcc778e6d3e23e17ea3b7f2077a4896b5b44c1d83cea6b5ed62d2dc7203adabd8::raid_result::RaidResult {
        0xcc778e6d3e23e17ea3b7f2077a4896b5b44c1d83cea6b5ed62d2dc7203adabd8::raid::go_raid(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    // decompiled from Move bytecode v6
}

