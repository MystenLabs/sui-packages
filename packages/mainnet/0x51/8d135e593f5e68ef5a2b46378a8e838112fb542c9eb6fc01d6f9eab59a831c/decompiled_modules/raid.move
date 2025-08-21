module 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::raid {
    fun apply_type_penalty(arg0: &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::Character, arg1: u64) {
        let v0 = get_type_weight(arg0, arg1);
        let v1 = if (v0 < 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::constants::min_weight() + 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::constants::weight_penalty()) {
            0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::constants::min_weight()
        } else {
            v0 - 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::constants::weight_penalty()
        };
        update_type_weight(arg0, arg1, v1);
    }

    fun check_item_drop(arg0: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::Character, arg1: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::game_data::GameData, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::global_buffs::GlobalBuffs) : bool {
        let v0 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::item_types::item_info_drop_rate(0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::game_data::get_item_by_id(arg1, arg2));
        let v1 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::total_stats::calculate_total_stats(arg0);
        let v2 = if (0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression_logic::is_newbie_buff_active(arg0, arg4)) {
            0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::constants::newbie_buff_drop_bonus()
        } else {
            0
        };
        let v3 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::stat_effects::agility_drop_bonus(0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::total_stats::total_agility(&v1)) + v2 + 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::global_buffs::get_buff_strength(arg5, 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::global_buffs::buff_type_drop_rate(), arg4);
        let v4 = if (v0 + v3 > 9900) {
            9900
        } else {
            v0 + v3
        };
        arg3 % 10000 < v4
    }

    fun find_type_weight_by_id(arg0: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::Character, arg1: u64) : 0x1::option::Option<u64> {
        let v0 = 0;
        let v1 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::type_history(arg0);
        while (v0 < 0x1::vector::length<0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::traits::TypeWeight>(v1)) {
            if (0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::traits::type_weight_type_id(0x1::vector::borrow<0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::traits::TypeWeight>(v1, v0)) == arg1) {
                return 0x1::option::some<u64>(v0)
            };
            v0 = v0 + 1;
        };
        0x1::option::none<u64>()
    }

    fun get_available_items_of_type(arg0: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::Character, arg1: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::game_data::GameData, arg2: u64) : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::faction(arg0);
        let v2 = 0;
        let v3 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::game_data::game_data_items_registry(arg1);
        while (v2 < 0x1::vector::length<0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::item_types::ItemInfo>(v3)) {
            let v4 = 0x1::vector::borrow<0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::item_types::ItemInfo>(v3, v2);
            if (0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::item_types::item_info_type_id(v4) == arg2) {
                let v5 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::item_types::item_info_faction(v4);
                if (0x1::option::is_none<u64>(v5) || 0x1::option::is_some<u64>(v1) && *0x1::option::borrow<u64>(v1) == *0x1::option::borrow<u64>(v5)) {
                    let v6 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::item_types::item_info_max_supply(v4);
                    if (v6 == 0 || 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::item_types::item_info_current_count(v4) < v6) {
                        0x1::vector::push_back<u64>(&mut v0, 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::item_types::item_info_id(v4));
                    };
                };
            };
            v2 = v2 + 1;
        };
        v0
    }

    fun get_type_weight(arg0: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::Character, arg1: u64) : u64 {
        let v0 = find_type_weight_by_id(arg0, arg1);
        if (0x1::option::is_some<u64>(&v0)) {
            0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::traits::type_weight_weight(0x1::vector::borrow<0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::traits::TypeWeight>(0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::type_history(arg0), 0x1::option::extract<u64>(&mut v0)))
        } else {
            0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::constants::default_type_weight()
        }
    }

    public(friend) fun go_raid(arg0: &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::Character, arg1: &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::game_data::GameData, arg2: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::global_buffs::GlobalBuffs, arg3: &0x2::random::Random, arg4: &0x2::clock::Clock, arg5: 0x1::option::Option<u64>, arg6: &mut 0x2::tx_context::TxContext) : 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::raid_result::RaidResult {
        sync_type_history(arg0, arg1);
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression_logic::auto_release_if_time_passed(0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::wanted_mut(arg0), arg4);
        let v0 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::total_stats::calculate_total_stats(arg0);
        let v1 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::total_stats::total_stealth(&v0);
        let v2 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::total_stats::total_endurance(&v0);
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression_logic::update_wanted_level(0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::wanted_mut(arg0), v1, arg4);
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression_logic::recover_stamina(0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::stamina_mut(arg0), v2, arg4, arg2);
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::errors::assert_not_arrested(!0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression::is_arrested(0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::wanted(arg0)));
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::errors::assert_sufficient_stamina(0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression::has_sufficient_stamina(0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::stamina(arg0), 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::constants::raid_stamina_cost()));
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::errors::assert_inventory_full(0x1::vector::length<0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::inventory_item::InventoryItem>(0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::inventory(arg0)) < 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::constants::max_equipped());
        let v3 = 0x1::option::none<u64>();
        let v4 = false;
        let v5 = false;
        let v6 = v5;
        let v7 = 0;
        let v8 = 0x2::random::new_generator(arg3, arg6);
        let v9 = &mut v8;
        let (v10, v11, v12, v13) = roll_for_item(arg0, arg1, arg5, v9, arg4, arg2);
        let v14 = v12;
        let v15 = v10;
        if (0x1::option::is_some<0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::item_types::ItemSelectionResult>(&v15)) {
            let v16 = 0x1::option::extract<0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::item_types::ItemSelectionResult>(&mut v15);
            let v17 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::item_types::selection_result_item_id(&v16);
            v3 = 0x1::option::some<u64>(v17);
            let v18 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::game_data::get_item_by_id_mut(arg1, v17);
            let v19 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::item_types::item_info_max_supply(v18);
            if (v19 != 0) {
                0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::errors::assert_invalid_item(0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::item_types::item_info_current_count(v18) < v19);
            };
            0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::item_types::increment_current_count(v18);
            0x1::vector::push_back<0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::inventory_item::InventoryItem>(0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::inventory_mut(arg0), 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::inventory_item::new_basic_item(0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::generate_next_instance_id(arg0), v17, 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::item_types::item_info_type_id(v18)));
            v4 = true;
        } else if (0x1::option::is_some<u64>(&v14)) {
            v3 = v14;
        };
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::set_last_raid_time(arg0, 0x2::clock::timestamp_ms(arg4));
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::set_total_raids(arg0, 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::total_raids(arg0) + 1);
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression_logic::update_newbie_buff_state(arg0, arg4);
        let v20 = if (v4) {
            if (!v5) {
                0x1::option::is_some<u64>(&v3)
            } else {
                false
            }
        } else {
            false
        };
        let v21 = if (v20) {
            0x1::option::some<u64>(0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::item_types::item_info_drop_rate(0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::game_data::get_item_by_id(arg1, *0x1::option::borrow<u64>(&v3))))
        } else {
            0x1::option::none<u64>()
        };
        if (0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression_logic::gain_experience_with_newbie_buff_check(arg0, v21, 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::global_buffs::get_buff_strength(arg2, 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::global_buffs::buff_type_experience(), arg4), arg4)) {
            0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::update_attributes(arg0, arg1);
        };
        let v22 = if (0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::global_buffs::is_buff_active(arg2, 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::global_buffs::buff_type_police_disabled(), arg4)) {
            0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::arrest_result::new_no_arrest()
        } else {
            0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression_logic::check_arrest_with_separate_rolls(0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::wanted_mut(arg0), v2, v1, 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::total_stats::total_luck(&v0), arg3, arg6, arg4)
        };
        let v23 = v22;
        let v24 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::arrest_result::arrest_attempted(&v23);
        let v25 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::arrest_result::avoided_arrest(&v23);
        if (v4) {
            if (v24 && !v25) {
                if (0x1::option::is_some<u64>(&v3)) {
                    0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::item_types::decrement_current_count(0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::game_data::get_item_by_id_mut(arg1, *0x1::option::borrow<u64>(&v3)));
                    let v26 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::inventory_mut(arg0);
                    if (0x1::vector::length<0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::inventory_item::InventoryItem>(v26) > 0) {
                        0x1::vector::pop_back<0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::inventory_item::InventoryItem>(v26);
                    };
                    v4 = false;
                    v6 = true;
                    v7 = 0;
                };
            } else if (0x1::option::is_some<u64>(&v3)) {
                let v27 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::item_types::item_info_drop_rate(0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::game_data::get_item_by_id(arg1, *0x1::option::borrow<u64>(&v3)));
                let v28 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::global_buffs::get_buff_strength(arg2, 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::global_buffs::buff_type_wanted_reduction(), arg4);
                let v29 = if (v28 > 0) {
                    (0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::stat_effects::stealth_wanted_gain(v1) + 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression_logic::calculate_rarity_wanted_bonus(v27)) * (10000 - v28) / 10000
                } else {
                    0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::stat_effects::stealth_wanted_gain(v1) + 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression_logic::calculate_rarity_wanted_bonus(v27)
                };
                v7 = v29;
                0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression_logic::add_wanted_level_with_stealth_and_rarity(0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::wanted_mut(arg0), v1, v27);
            };
        };
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression_logic::consume_stamina(0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::stamina_mut(arg0), 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::constants::raid_stamina_cost());
        0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::raid_result::new_raid_result(v3, v4, v6, v24, v25, *0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::arrest_result::save_reason(&v23), v11, v14, v13, 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::constants::raid_stamina_cost(), v7)
    }

    fun recover_type_weights(arg0: &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::Character) {
        let v0 = 0;
        let v1 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::type_history_mut(arg0);
        while (v0 < 0x1::vector::length<0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::traits::TypeWeight>(v1)) {
            let v2 = 0x1::vector::borrow_mut<0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::traits::TypeWeight>(v1, v0);
            let v3 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::traits::type_weight_weight(v2);
            let v4 = if (v3 + 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::constants::weight_recovery() > 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::constants::max_weight()) {
                0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::constants::max_weight()
            } else {
                v3 + 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::constants::weight_recovery()
            };
            0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::traits::set_type_weight_weight(v2, v4);
            v0 = v0 + 1;
        };
    }

    fun roll_for_item(arg0: &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::Character, arg1: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::game_data::GameData, arg2: 0x1::option::Option<u64>, arg3: &mut 0x2::random::RandomGenerator, arg4: &0x2::clock::Clock, arg5: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::global_buffs::GlobalBuffs) : (0x1::option::Option<0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::item_types::ItemSelectionResult>, bool, 0x1::option::Option<u64>, 0x1::option::Option<u64>) {
        recover_type_weights(arg0);
        let v0 = if (0x1::option::is_some<u64>(&arg2)) {
            if (0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::progression::stats_level(0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::stats(arg0)) >= 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::constants::min_level_for_type_selection()) {
                let v1 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::game_data::find_type_by_id(arg1, *0x1::option::borrow<u64>(&arg2));
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
            return (0x1::option::none<0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::item_types::ItemSelectionResult>(), false, 0x1::option::none<u64>(), 0x1::option::none<u64>())
        };
        let v3 = 0x1::option::extract<u64>(&mut v2);
        let v4 = get_available_items_of_type(arg0, arg1, v3);
        if (0x1::vector::is_empty<u64>(&v4)) {
            return (0x1::option::none<0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::item_types::ItemSelectionResult>(), false, 0x1::option::none<u64>(), 0x1::option::none<u64>())
        };
        let v5 = select_random_item(&v4, 0x2::random::generate_u64(arg3));
        if (0x1::option::is_none<u64>(&v5)) {
            return (0x1::option::none<0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::item_types::ItemSelectionResult>(), false, 0x1::option::none<u64>(), 0x1::option::none<u64>())
        };
        let v6 = 0x1::option::extract<u64>(&mut v5);
        if (!check_item_drop(arg0, arg1, v6, 0x2::random::generate_u64(arg3), arg4, arg5)) {
            return (0x1::option::none<0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::item_types::ItemSelectionResult>(), false, 0x1::option::some<u64>(v6), 0x1::option::none<u64>())
        };
        let v7 = v6;
        let v8 = v3;
        let v9 = false;
        let v10 = 0x1::option::none<u64>();
        let v11 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::total_stats::calculate_total_stats(arg0);
        let v12 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::total_stats::total_luck(&v11);
        if (v12 > 0) {
            if (0x2::random::generate_u64(arg3) % 10000 < 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::stat_effects::luck_reroll_chance(v12)) {
                v9 = true;
                let v13 = select_item_type(arg0, 0x2::random::generate_u64(arg3));
                if (0x1::option::is_some<u64>(&v13)) {
                    let v14 = 0x1::option::extract<u64>(&mut v13);
                    let v15 = get_available_items_of_type(arg0, arg1, v14);
                    if (!0x1::vector::is_empty<u64>(&v15)) {
                        let v16 = select_random_item(&v15, 0x2::random::generate_u64(arg3));
                        if (0x1::option::is_some<u64>(&v16)) {
                            let v17 = 0x1::option::extract<u64>(&mut v16);
                            v10 = 0x1::option::some<u64>(v17);
                            if (0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::item_types::item_info_drop_rate(0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::game_data::get_item_by_id(arg1, v17)) < 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::item_types::item_info_drop_rate(0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::game_data::get_item_by_id(arg1, v6))) {
                                v7 = v17;
                                v8 = v14;
                            };
                        };
                    };
                };
            };
        };
        apply_type_penalty(arg0, v8);
        (0x1::option::some<0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::item_types::ItemSelectionResult>(0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::item_types::new_item_selection_result(v7, v8)), v9, 0x1::option::some<u64>(v6), v10)
    }

    fun select_item_type(arg0: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::Character, arg1: u64) : 0x1::option::Option<u64> {
        let v0 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::type_history(arg0);
        if (0x1::vector::is_empty<0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::traits::TypeWeight>(v0)) {
            return 0x1::option::none<u64>()
        };
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::traits::TypeWeight>(v0)) {
            v1 = v1 + 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::traits::type_weight_weight(0x1::vector::borrow<0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::traits::TypeWeight>(v0, v2));
            v2 = v2 + 1;
        };
        if (v1 == 0) {
            return 0x1::option::none<u64>()
        };
        let v3 = arg1 % v1;
        let v4 = 0;
        v2 = 0;
        while (v2 < 0x1::vector::length<0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::traits::TypeWeight>(v0)) {
            let v5 = 0x1::vector::borrow<0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::traits::TypeWeight>(v0, v2);
            let v6 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::traits::type_weight_weight(v5);
            if (v3 >= v4 && v3 < v4 + v6) {
                return 0x1::option::some<u64>(0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::traits::type_weight_type_id(v5))
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

    fun sync_type_history(arg0: &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::Character, arg1: &0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::game_data::GameData) {
        let v0 = 0;
        let v1 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::game_data::game_data_item_types(arg1);
        while (v0 < 0x1::vector::length<0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::item_types::ItemType>(v1)) {
            let v2 = 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::item_types::item_type_id(0x1::vector::borrow<0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::item_types::ItemType>(v1, v0));
            let v3 = find_type_weight_by_id(arg0, v2);
            if (0x1::option::is_none<u64>(&v3)) {
                0x1::vector::push_back<0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::traits::TypeWeight>(0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::type_history_mut(arg0), 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::traits::new_type_weight(v2, 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::constants::default_type_weight()));
            };
            v0 = v0 + 1;
        };
    }

    fun update_type_weight(arg0: &mut 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::Character, arg1: u64, arg2: u64) {
        let v0 = find_type_weight_by_id(arg0, arg1);
        if (0x1::option::is_some<u64>(&v0)) {
            0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::traits::set_type_weight_weight(0x1::vector::borrow_mut<0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::traits::TypeWeight>(0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::type_history_mut(arg0), 0x1::option::extract<u64>(&mut v0)), arg2);
        } else {
            0x1::vector::push_back<0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::traits::TypeWeight>(0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::character_data::type_history_mut(arg0), 0x518d135e593f5e68ef5a2b46378a8e838112fb542c9eb6fc01d6f9eab59a831c::traits::new_type_weight(arg1, arg2));
        };
    }

    // decompiled from Move bytecode v6
}

