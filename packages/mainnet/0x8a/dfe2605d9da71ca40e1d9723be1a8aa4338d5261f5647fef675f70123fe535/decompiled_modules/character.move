module 0x8adfe2605d9da71ca40e1d9723be1a8aa4338d5261f5647fef675f70123fe535::character {
    public(friend) fun go_raid_with_result(arg0: &mut 0x8adfe2605d9da71ca40e1d9723be1a8aa4338d5261f5647fef675f70123fe535::character_data::Character, arg1: &mut 0x8adfe2605d9da71ca40e1d9723be1a8aa4338d5261f5647fef675f70123fe535::game_data::GameData, arg2: &0x8adfe2605d9da71ca40e1d9723be1a8aa4338d5261f5647fef675f70123fe535::global_buffs::GlobalBuffs, arg3: &0x2::random::Random, arg4: &0x2::clock::Clock, arg5: 0x1::option::Option<u64>, arg6: &mut 0x2::tx_context::TxContext) : 0x8adfe2605d9da71ca40e1d9723be1a8aa4338d5261f5647fef675f70123fe535::raid_result::RaidResult {
        0x8adfe2605d9da71ca40e1d9723be1a8aa4338d5261f5647fef675f70123fe535::raid::go_raid(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    // decompiled from Move bytecode v6
}

