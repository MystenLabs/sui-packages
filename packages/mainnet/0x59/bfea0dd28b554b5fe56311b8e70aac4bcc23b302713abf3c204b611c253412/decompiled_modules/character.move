module 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character {
    public entry fun allocate_character_stats(arg0: &mut 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::Character, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::progression_logic::allocate_stat_points_character(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun customise(arg0: &mut 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::Character, arg1: &mut 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::game_data::GameData, arg2: &0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::render_config::RenderConfig, arg3: u64, arg4: vector<u8>, arg5: u64, arg6: vector<u8>) {
        0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::customization::customise(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun decline_pending(arg0: &mut 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::Character, arg1: &mut 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::game_data::GameData, arg2: u64) {
        0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::customization::decline_pending(arg0, arg1, arg2);
    }

    public entry fun go_raid(arg0: &mut 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::Character, arg1: &mut 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::game_data::GameData, arg2: &0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::global_buffs::GlobalBuffs, arg3: &0x2::random::Random, arg4: &0x2::clock::Clock, arg5: bool, arg6: 0x1::option::Option<u64>, arg7: &mut 0x2::tx_context::TxContext) {
        0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::raid::go_raid_entry(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun go_raid_with_result(arg0: &mut 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::Character, arg1: &mut 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::game_data::GameData, arg2: &0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::global_buffs::GlobalBuffs, arg3: &0x2::random::Random, arg4: &0x2::clock::Clock, arg5: bool, arg6: 0x1::option::Option<u64>, arg7: &mut 0x2::tx_context::TxContext) : 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::raid_result::RaidResult {
        0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::raid::go_raid(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public entry fun update_character_state(arg0: &mut 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::Character, arg1: &0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::global_buffs::GlobalBuffs, arg2: &0x2::clock::Clock) {
        let v0 = 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::stats(arg0);
        0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::progression_logic::recover_stamina(0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::stamina_mut(arg0), 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::progression::stats_endurance(v0), arg2, arg1);
        0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::progression_logic::update_wanted_level(0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::wanted_mut(arg0), 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::progression::stats_stealth(v0), arg2);
        0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::progression_logic::update_newbie_buff_state(arg0, arg2);
    }

    // decompiled from Move bytecode v6
}

