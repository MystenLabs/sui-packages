module 0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::character {
    public(friend) fun go_raid_with_result(arg0: &mut 0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::character_data::Character, arg1: &mut 0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::game_data::GameData, arg2: &0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::global_buffs::GlobalBuffs, arg3: &0x2::random::Random, arg4: &0x2::clock::Clock, arg5: 0x1::option::Option<u64>, arg6: &mut 0x2::tx_context::TxContext) : 0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::raid_result::RaidResult {
        0xa8ff12fc9da0117c8e85e8970b87e9470bcbc1e774d469a47b826ca268b5e97::raid::go_raid(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    // decompiled from Move bytecode v6
}

