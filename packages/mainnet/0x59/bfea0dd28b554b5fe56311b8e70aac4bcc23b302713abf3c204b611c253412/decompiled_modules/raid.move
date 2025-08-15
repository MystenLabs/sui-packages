module 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::raid {
    fun apply_type_penalty(arg0: &mut 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::Character, arg1: u64) {
        let v0 = get_type_weight(arg0, arg1);
        let v1 = if (v0 < 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::constants::min_weight() + 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::constants::weight_penalty()) {
            0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::constants::min_weight()
        } else {
            v0 - 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::constants::weight_penalty()
        };
        update_type_weight(arg0, arg1, v1);
    }

    fun check_item_drop(arg0: &0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::Character, arg1: &0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::game_data::GameData, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::global_buffs::GlobalBuffs) : bool {
        let v0 = 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::item_types::item_info_drop_rate(0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::game_data::get_item_by_id(arg1, arg2));
        let v1 = if (0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::progression_logic::is_newbie_buff_active(arg0, arg4)) {
            0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::constants::newbie_buff_drop_bonus()
        } else {
            0
        };
        let v2 = 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::stat_effects::agility_drop_bonus(0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::progression::stats_agility(0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::stats(arg0))) + v1 + 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::global_buffs::get_buff_strength(arg5, 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::global_buffs::buff_type_drop_rate(), arg4);
        let v3 = if (v0 + v2 > 9900) {
            9900
        } else {
            v0 + v2
        };
        arg3 % 10000 < v3
    }

    fun find_type_weight_by_id(arg0: &0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::Character, arg1: u64) : 0x1::option::Option<u64> {
        let v0 = 0;
        let v1 = 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::type_history(arg0);
        while (v0 < 0x1::vector::length<0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::traits::TypeWeight>(v1)) {
            if (0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::traits::type_weight_type_id(0x1::vector::borrow<0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::traits::TypeWeight>(v1, v0)) == arg1) {
                return 0x1::option::some<u64>(v0)
            };
            v0 = v0 + 1;
        };
        0x1::option::none<u64>()
    }

    fun get_available_items_of_type(arg0: &0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::Character, arg1: &0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::game_data::GameData, arg2: u64) : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::equipped_items(arg0);
        let v2 = 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::faction(arg0);
        let v3 = 0;
        let v4 = 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::game_data::game_data_items_registry(arg1);
        while (v3 < 0x1::vector::length<0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::item_types::ItemInfo>(v4)) {
            let v5 = 0x1::vector::borrow<0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::item_types::ItemInfo>(v4, v3);
            if (0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::item_types::item_info_type_id(v5) == arg2) {
                let v6 = 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::item_types::item_info_faction(v5);
                let v7 = 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::item_types::item_info_id(v5);
                if ((0x1::option::is_none<u64>(v6) || 0x1::option::is_some<u64>(v2) && *0x1::option::borrow<u64>(v2) == *0x1::option::borrow<u64>(v6)) && !0x1::vector::contains<u64>(v1, &v7)) {
                    let v8 = 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::item_types::item_info_max_supply(v5);
                    if (v8 == 0 || 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::item_types::item_info_current_count(v5) < v8) {
                        0x1::vector::push_back<u64>(&mut v0, v7);
                    };
                };
            };
            v3 = v3 + 1;
        };
        v0
    }

    fun get_type_weight(arg0: &0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::Character, arg1: u64) : u64 {
        let v0 = find_type_weight_by_id(arg0, arg1);
        if (0x1::option::is_some<u64>(&v0)) {
            0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::traits::type_weight_weight(0x1::vector::borrow<0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::traits::TypeWeight>(0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::type_history(arg0), 0x1::option::extract<u64>(&mut v0)))
        } else {
            0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::constants::default_type_weight()
        }
    }

    public fun go_raid(arg0: &mut 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::Character, arg1: &mut 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::game_data::GameData, arg2: &0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::global_buffs::GlobalBuffs, arg3: &0x2::random::Random, arg4: &0x2::clock::Clock, arg5: bool, arg6: 0x1::option::Option<u64>, arg7: &mut 0x2::tx_context::TxContext) : 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::raid_result::RaidResult {
        sync_type_history(arg0, arg1);
        0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::errors::assert_not_arrested(!0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::progression::is_arrested(0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::wanted(arg0)));
        0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::errors::assert_sufficient_stamina(0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::progression::has_sufficient_stamina(0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::stamina(arg0), 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::constants::raid_stamina_cost()));
        let v0 = 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::stats(arg0);
        let v1 = 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::progression::stats_stealth(v0);
        let v2 = 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::progression::stats_endurance(v0);
        0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::progression_logic::update_wanted_level(0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::wanted_mut(arg0), v1, arg4);
        0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::progression_logic::recover_stamina(0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::stamina_mut(arg0), v2, arg4, arg2);
        let v3 = 0x1::option::none<u64>();
        let v4 = false;
        let v5 = false;
        let v6 = v5;
        let v7 = 0;
        if (arg5) {
            0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::customization::auto_decline_pending(arg0, arg1);
        };
        0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::errors::assert_pending_exists(0x1::option::is_none<u64>(0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::get_pending(arg0)));
        let v8 = 0x2::random::new_generator(arg3, arg7);
        let v9 = &mut v8;
        let (v10, v11, v12, v13) = roll_for_item(arg0, arg1, arg6, v9, arg4, arg2);
        let v14 = v10;
        if (0x1::option::is_some<0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::item_types::ItemSelectionResult>(&v14)) {
            let v15 = 0x1::option::extract<0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::item_types::ItemSelectionResult>(&mut v14);
            let v16 = 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::item_types::selection_result_item_id(&v15);
            v3 = 0x1::option::some<u64>(v16);
            let v17 = 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::game_data::get_item_by_id_mut(arg1, v16);
            let v18 = 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::item_types::item_info_max_supply(v17);
            if (v18 != 0) {
                0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::errors::assert_invalid_item(0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::item_types::item_info_current_count(v17) < v18);
            };
            let v19 = 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::item_types::item_info_drop_rate(v17);
            0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::item_types::increment_current_count(v17);
            *0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::pending_item_mut(arg0) = 0x1::option::some<u64>(v16);
            v4 = true;
            let v20 = 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::global_buffs::get_buff_strength(arg2, 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::global_buffs::buff_type_wanted_reduction(), arg4);
            let v21 = if (v20 > 0) {
                (0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::stat_effects::stealth_wanted_gain(v1) + 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::progression_logic::calculate_rarity_wanted_bonus(v19)) * (10000 - v20) / 10000
            } else {
                0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::stat_effects::stealth_wanted_gain(v1) + 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::progression_logic::calculate_rarity_wanted_bonus(v19)
            };
            v7 = v21;
            0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::progression_logic::add_wanted_level_with_stealth_and_rarity(0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::wanted_mut(arg0), v1, v19);
        };
        0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::set_last_raid_time(arg0, 0x2::clock::timestamp_ms(arg4));
        0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::set_total_raids(arg0, 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::total_raids(arg0) + 1);
        0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::progression_logic::update_newbie_buff_state(arg0, arg4);
        let v22 = if (v4) {
            if (!v5) {
                0x1::option::is_some<u64>(&v3)
            } else {
                false
            }
        } else {
            false
        };
        let v23 = if (v22) {
            0x1::option::some<u64>(0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::item_types::item_info_drop_rate(0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::game_data::get_item_by_id(arg1, *0x1::option::borrow<u64>(&v3))))
        } else {
            0x1::option::none<u64>()
        };
        0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::progression_logic::gain_experience_with_newbie_buff_check(arg0, v23, 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::global_buffs::get_buff_strength(arg2, 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::global_buffs::buff_type_experience(), arg4), arg4);
        0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::progression_logic::consume_stamina(0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::stamina_mut(arg0), 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::constants::raid_stamina_cost());
        let (v24, v25, v26) = if (0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::global_buffs::is_buff_active(arg2, 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::global_buffs::buff_type_police_disabled(), arg4)) {
            (false, false, 0x1::option::none<u8>())
        } else {
            0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::progression_logic::check_arrest_with_separate_rolls(0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::wanted_mut(arg0), v2, v1, 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::progression::stats_luck(v0), &mut v8, arg4)
        };
        let v27 = if (v24) {
            if (!v25) {
                v4
            } else {
                false
            }
        } else {
            false
        };
        if (v27) {
            if (0x1::option::is_some<u64>(&v3)) {
                let v28 = 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::game_data::get_item_by_id_mut(arg1, *0x1::option::borrow<u64>(&v3));
                0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::item_types::decrement_current_count(v28);
                *0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::pending_item_mut(arg0) = 0x1::option::none<u64>();
                v4 = false;
                v6 = true;
                v7 = 0;
                let v29 = 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::progression::wanted_level(0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::wanted(arg0));
                let v30 = 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::stat_effects::stealth_wanted_gain(v1) + 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::progression_logic::calculate_rarity_wanted_bonus(0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::item_types::item_info_drop_rate(v28));
                let v31 = if (v29 > v30) {
                    v29 - v30
                } else {
                    0
                };
                0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::progression::set_wanted_level(0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::wanted_mut(arg0), v31);
            };
        };
        0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::raid_result::new_raid_result(v3, v4, v6, v24, v25, v26, v11, v12, v13, 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::constants::raid_stamina_cost(), v7)
    }

    public entry fun go_raid_entry(arg0: &mut 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::Character, arg1: &mut 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::game_data::GameData, arg2: &0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::global_buffs::GlobalBuffs, arg3: &0x2::random::Random, arg4: &0x2::clock::Clock, arg5: bool, arg6: 0x1::option::Option<u64>, arg7: &mut 0x2::tx_context::TxContext) {
        go_raid(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    fun recover_type_weights(arg0: &mut 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::Character) {
        let v0 = 0;
        let v1 = 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::type_history_mut(arg0);
        while (v0 < 0x1::vector::length<0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::traits::TypeWeight>(v1)) {
            let v2 = 0x1::vector::borrow_mut<0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::traits::TypeWeight>(v1, v0);
            let v3 = 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::traits::type_weight_weight(v2);
            let v4 = if (v3 + 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::constants::weight_recovery() > 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::constants::max_weight()) {
                0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::constants::max_weight()
            } else {
                v3 + 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::constants::weight_recovery()
            };
            0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::traits::set_type_weight_weight(v2, v4);
            v0 = v0 + 1;
        };
    }

    fun roll_for_item(arg0: &mut 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::Character, arg1: &0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::game_data::GameData, arg2: 0x1::option::Option<u64>, arg3: &mut 0x2::random::RandomGenerator, arg4: &0x2::clock::Clock, arg5: &0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::global_buffs::GlobalBuffs) : (0x1::option::Option<0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::item_types::ItemSelectionResult>, bool, 0x1::option::Option<u64>, 0x1::option::Option<u64>) {
        recover_type_weights(arg0);
        let v0 = if (0x1::option::is_some<u64>(&arg2)) {
            if (0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::progression::stats_level(0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::stats(arg0)) >= 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::constants::min_level_for_type_selection()) {
                let v1 = 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::game_data::find_type_by_id(arg1, *0x1::option::borrow<u64>(&arg2));
                if (0x1::option::is_some<u64>(&v1)) {
                    arg2
                } else {
                    select_item_type(arg0, 0x2::random::generate_u64(arg3))
                }
            } else {
                select_item_type(arg0, 0x2::random::generate_u64(arg3))
            }
        } else {
            select_item_type(arg0, 0x2::random::generate_u64(arg3))
        };
        let v2 = v0;
        if (0x1::option::is_none<u64>(&v2)) {
            return (0x1::option::none<0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::item_types::ItemSelectionResult>(), false, 0x1::option::none<u64>(), 0x1::option::none<u64>())
        };
        let v3 = 0x1::option::extract<u64>(&mut v2);
        let v4 = get_available_items_of_type(arg0, arg1, v3);
        if (0x1::vector::is_empty<u64>(&v4)) {
            return (0x1::option::none<0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::item_types::ItemSelectionResult>(), false, 0x1::option::none<u64>(), 0x1::option::none<u64>())
        };
        let v5 = select_random_item(&v4, 0x2::random::generate_u64(arg3));
        if (0x1::option::is_none<u64>(&v5)) {
            return (0x1::option::none<0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::item_types::ItemSelectionResult>(), false, 0x1::option::none<u64>(), 0x1::option::none<u64>())
        };
        let v6 = 0x1::option::extract<u64>(&mut v5);
        if (!check_item_drop(arg0, arg1, v6, 0x2::random::generate_u64(arg3), arg4, arg5)) {
            return (0x1::option::none<0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::item_types::ItemSelectionResult>(), false, 0x1::option::none<u64>(), 0x1::option::none<u64>())
        };
        let v7 = v6;
        let v8 = v3;
        let v9 = false;
        let v10 = 0x1::option::none<u64>();
        let v11 = 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::progression::stats_luck(0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::stats(arg0));
        if (v11 > 0) {
            if (0x2::random::generate_u64(arg3) % 10000 < 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::stat_effects::luck_reroll_chance(v11)) {
                v9 = true;
                let v12 = select_item_type(arg0, 0x2::random::generate_u64(arg3));
                if (0x1::option::is_some<u64>(&v12)) {
                    let v13 = 0x1::option::extract<u64>(&mut v12);
                    let v14 = get_available_items_of_type(arg0, arg1, v13);
                    if (!0x1::vector::is_empty<u64>(&v14)) {
                        let v15 = select_random_item(&v14, 0x2::random::generate_u64(arg3));
                        if (0x1::option::is_some<u64>(&v15)) {
                            let v16 = 0x1::option::extract<u64>(&mut v15);
                            v10 = 0x1::option::some<u64>(v16);
                            if (0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::item_types::item_info_drop_rate(0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::game_data::get_item_by_id(arg1, v16)) < 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::item_types::item_info_drop_rate(0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::game_data::get_item_by_id(arg1, v6))) {
                                v7 = v16;
                                v8 = v13;
                            };
                        };
                    };
                };
            };
        };
        apply_type_penalty(arg0, v8);
        (0x1::option::some<0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::item_types::ItemSelectionResult>(0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::item_types::new_item_selection_result(v7, v8)), v9, 0x1::option::some<u64>(v6), v10)
    }

    fun select_item_type(arg0: &0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::Character, arg1: u64) : 0x1::option::Option<u64> {
        let v0 = 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::type_history(arg0);
        if (0x1::vector::is_empty<0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::traits::TypeWeight>(v0)) {
            return 0x1::option::none<u64>()
        };
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::traits::TypeWeight>(v0)) {
            v1 = v1 + 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::traits::type_weight_weight(0x1::vector::borrow<0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::traits::TypeWeight>(v0, v2));
            v2 = v2 + 1;
        };
        if (v1 == 0) {
            return 0x1::option::none<u64>()
        };
        let v3 = arg1 % v1;
        let v4 = 0;
        v2 = 0;
        while (v2 < 0x1::vector::length<0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::traits::TypeWeight>(v0)) {
            let v5 = 0x1::vector::borrow<0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::traits::TypeWeight>(v0, v2);
            let v6 = 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::traits::type_weight_weight(v5);
            if (v3 >= v4 && v3 < v4 + v6) {
                return 0x1::option::some<u64>(0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::traits::type_weight_type_id(v5))
            };
            v4 = v4 + v6;
            v2 = v2 + 1;
        };
        0x1::option::none<u64>()
    }

    fun select_random_item(arg0: &vector<u64>, arg1: u64) : 0x1::option::Option<u64> {
        if (0x1::vector::is_empty<u64>(arg0)) {
            return 0x1::option::none<u64>()
        };
        0x1::option::some<u64>(*0x1::vector::borrow<u64>(arg0, arg1 % 0x1::vector::length<u64>(arg0)))
    }

    fun sync_type_history(arg0: &mut 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::Character, arg1: &0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::game_data::GameData) {
        let v0 = 0;
        let v1 = 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::game_data::game_data_item_types(arg1);
        while (v0 < 0x1::vector::length<0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::item_types::ItemType>(v1)) {
            let v2 = 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::item_types::item_type_id(0x1::vector::borrow<0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::item_types::ItemType>(v1, v0));
            let v3 = find_type_weight_by_id(arg0, v2);
            if (0x1::option::is_none<u64>(&v3)) {
                0x1::vector::push_back<0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::traits::TypeWeight>(0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::type_history_mut(arg0), 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::traits::new_type_weight(v2, 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::constants::default_type_weight()));
            };
            v0 = v0 + 1;
        };
    }

    fun update_type_weight(arg0: &mut 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::Character, arg1: u64, arg2: u64) {
        let v0 = find_type_weight_by_id(arg0, arg1);
        if (0x1::option::is_some<u64>(&v0)) {
            0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::traits::set_type_weight_weight(0x1::vector::borrow_mut<0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::traits::TypeWeight>(0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::type_history_mut(arg0), 0x1::option::extract<u64>(&mut v0)), arg2);
        } else {
            0x1::vector::push_back<0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::traits::TypeWeight>(0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::character_data::type_history_mut(arg0), 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::traits::new_type_weight(arg1, arg2));
        };
    }

    // decompiled from Move bytecode v6
}

