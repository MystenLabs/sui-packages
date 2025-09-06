module 0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::character {
    public(friend) fun go_raid_with_result(arg0: &mut 0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::character_data::Character, arg1: &mut 0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::game_data::GameData, arg2: &0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::global_buffs::GlobalBuffs, arg3: &0x2::random::Random, arg4: &0x2::clock::Clock, arg5: 0x1::option::Option<u64>, arg6: &mut 0x2::tx_context::TxContext) : 0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::raid_result::RaidResult {
        0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::raid::go_raid(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    // decompiled from Move bytecode v6
}

