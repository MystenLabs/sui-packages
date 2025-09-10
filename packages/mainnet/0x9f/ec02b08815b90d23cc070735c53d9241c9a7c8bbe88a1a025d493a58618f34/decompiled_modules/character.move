module 0x9fec02b08815b90d23cc070735c53d9241c9a7c8bbe88a1a025d493a58618f34::character {
    public(friend) fun go_raid_with_result(arg0: &mut 0x9fec02b08815b90d23cc070735c53d9241c9a7c8bbe88a1a025d493a58618f34::character_data::Character, arg1: &mut 0x9fec02b08815b90d23cc070735c53d9241c9a7c8bbe88a1a025d493a58618f34::game_data::GameData, arg2: &0x9fec02b08815b90d23cc070735c53d9241c9a7c8bbe88a1a025d493a58618f34::global_buffs::GlobalBuffs, arg3: &0x2::random::Random, arg4: &0x2::clock::Clock, arg5: 0x1::option::Option<u64>, arg6: &mut 0x2::tx_context::TxContext) : 0x9fec02b08815b90d23cc070735c53d9241c9a7c8bbe88a1a025d493a58618f34::raid_result::RaidResult {
        0x9fec02b08815b90d23cc070735c53d9241c9a7c8bbe88a1a025d493a58618f34::raid::go_raid(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    // decompiled from Move bytecode v6
}

