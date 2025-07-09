module 0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::admin_controller {
    entry fun add_damage_multiplier(arg0: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::authority::GameOperatorCap, arg1: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::authority::OperatorCapsBag, arg2: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::version::Version, arg3: &mut 0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::ibattle::DamageMultiplier, arg4: 0x1::string::String, arg5: u128, arg6: u128) {
        0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::version::validate_version(arg2);
        0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::authority::is_operator(arg0, arg1);
        0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::battle::validate_multiplier_key(arg3, arg4);
        0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::ibattle::set_damage_multiplier(arg3, arg4, 0x1::uq64_64::to_raw(0x1::uq64_64::from_quotient(arg5, arg6)));
    }

    entry fun add_perk_metadata(arg0: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::authority::GameOperatorCap, arg1: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::authority::OperatorCapsBag, arg2: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::version::Version, arg3: &mut 0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::iperks::PerksMetadataHolder, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: 0x1::string::String, arg8: u64, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock) {
        0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::version::validate_version(arg2);
        0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::authority::is_operator(arg0, arg1);
        0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::perks::validate_perk_metadata(arg3, arg4);
        0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::iperks::add_perk_metadata(arg3, arg4, arg5, arg6, arg7, arg8, arg10, arg9, arg11);
    }

    entry fun create_new_reward_pack(arg0: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::authority::GameOperatorCap, arg1: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::authority::OperatorCapsBag, arg2: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::version::Version, arg3: &mut 0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::iaccolades::AccoladeRewardRegistry, arg4: u64, arg5: vector<0x1::string::String>, arg6: vector<vector<0x1::string::String>>, arg7: vector<vector<u64>>, arg8: &mut 0x2::tx_context::TxContext) {
        0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::version::validate_version(arg2);
        0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::authority::is_operator(arg0, arg1);
        0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::accolades::create_reward_pack(arg3, arg4, arg5, arg6, arg7, arg8);
    }

    entry fun create_reward_threshold_mappings(arg0: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::authority::GameOperatorCap, arg1: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::authority::OperatorCapsBag, arg2: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::version::Version, arg3: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::iaccolades::AccoladeRewardRegistry, arg4: &mut 0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::iaccolades::AccoladeThresholdMapRegistry, arg5: 0x1::string::String, arg6: u128, arg7: u64) {
        0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::version::validate_version(arg2);
        0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::authority::is_operator(arg0, arg1);
        0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::accolades::map_threshold_to_reward(arg3, arg4, arg5, arg6, arg7);
    }

    entry fun create_unit_base_stats(arg0: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::authority::GameOperatorCap, arg1: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::authority::OperatorCapsBag, arg2: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::version::Version, arg3: &mut 0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::igangsters::GangsterBaseStats, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: u128, arg8: u128, arg9: &mut 0x2::tx_context::TxContext) {
        0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::version::validate_version(arg2);
        0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::authority::is_operator(arg0, arg1);
        0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::igangsters::add_gangster_stats_df<0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::igangsters::GangsterStats>(arg3, arg4, 0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::igangsters::create_new_gangster_stats(arg4, arg5, arg6, arg7, arg8, arg9));
    }

    entry fun remove_reward_pack(arg0: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::authority::GameOperatorCap, arg1: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::authority::OperatorCapsBag, arg2: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::version::Version, arg3: &mut 0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::iaccolades::AccoladeRewardRegistry, arg4: u64) {
        0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::version::validate_version(arg2);
        0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::authority::is_operator(arg0, arg1);
        0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::accolades::delete_reward_pack(arg3, arg4);
    }

    entry fun set_7days_rewards_config(arg0: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::authority::GameOperatorCap, arg1: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::authority::OperatorCapsBag, arg2: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::version::Version, arg3: &mut 0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::idaily_checkin::SevenDaysCheckInRewardsRegistry, arg4: u64, arg5: vector<0x1::string::String>, arg6: vector<0x1::string::String>, arg7: vector<u64>) {
        0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::version::validate_version(arg2);
        0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::authority::is_operator(arg0, arg1);
        0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::daily_checkin::process_7days_rewards_config(arg3, arg5, arg6, arg7);
        0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::idaily_checkin::set_7days_start_time(arg3, arg4);
    }

    entry fun set_7days_rewards_cost_config(arg0: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::authority::GameOperatorCap, arg1: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::authority::OperatorCapsBag, arg2: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::version::Version, arg3: &mut 0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::idaily_checkin::SevenDaysCheckInRewardsRegistry, arg4: u64, arg5: 0x1::string::String, arg6: u64) {
        0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::version::validate_version(arg2);
        0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::authority::is_operator(arg0, arg1);
        0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::idaily_checkin::set_7days_late_signin_cost_config(arg3, arg4, arg5, arg6);
    }

    public fun set_action_type_config(arg0: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::authority::GameOperatorCap, arg1: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::authority::OperatorCapsBag, arg2: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::version::Version, arg3: &mut 0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::ilevel::LevelPointRegistry, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64) {
        0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::version::validate_version(arg2);
        0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::authority::is_operator(arg0, arg1);
        if (!0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::ilevel::has_action_type(arg3, arg4)) {
            0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::ilevel::insert_new_action_point(arg3, arg4, arg5, arg6);
        } else {
            0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::ilevel::update_new_action_point(arg3, arg4, arg5, arg6);
        };
    }

    public fun set_bonus_xp_config(arg0: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::authority::GameOperatorCap, arg1: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::authority::OperatorCapsBag, arg2: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::version::Version, arg3: &mut 0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::iexperience::XPBonusConfig, arg4: u64, arg5: vector<u64>, arg6: vector<u64>, arg7: vector<u64>, arg8: vector<u64>, arg9: vector<u64>, arg10: vector<u64>, arg11: u64, arg12: u64) {
        0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::version::validate_version(arg2);
        0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::authority::is_operator(arg0, arg1);
        0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::iexperience::set_bonus_xp_config(arg3, arg4, arg5, arg6, arg8, arg7, arg10, arg9, arg11, arg12);
    }

    entry fun set_building_values(arg0: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::authority::GameOperatorCap, arg1: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::authority::OperatorCapsBag, arg2: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::version::Version, arg3: &mut 0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::ibuildings::BuildingRegistry, arg4: 0x1::string::String, arg5: u64, arg6: 0x1::string::String, arg7: u128) {
        0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::version::validate_version(arg2);
        0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::authority::is_operator(arg0, arg1);
        0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::buildings::set_buildings_value(arg3, arg4, arg5, arg6, arg7);
    }

    entry fun set_feed_registry(arg0: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::authority::GameOperatorCap, arg1: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::authority::OperatorCapsBag, arg2: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::version::Version, arg3: &mut 0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::iplayer::FeedRegistry, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u128, arg10: u64, arg11: u64, arg12: u64, arg13: u64) {
        0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::version::validate_version(arg2);
        0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::authority::is_operator(arg0, arg1);
        0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::iplayer::set_feed_registry(arg3, arg4 * 60 * 60 * 1000, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13);
    }

    public fun set_level_curve(arg0: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::authority::GameOperatorCap, arg1: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::authority::OperatorCapsBag, arg2: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::version::Version, arg3: &mut 0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::ilevel::LevelPointRegistry, arg4: u64, arg5: u8) {
        0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::version::validate_version(arg2);
        0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::authority::is_operator(arg0, arg1);
        0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::ilevel::set_level_curve(arg3, arg4, arg5);
    }

    public fun set_level_modifier(arg0: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::authority::GameOperatorCap, arg1: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::authority::OperatorCapsBag, arg2: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::version::Version, arg3: &mut 0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::ilevel::LevelPointRegistry, arg4: u64, arg5: u8) {
        0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::version::validate_version(arg2);
        0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::authority::is_operator(arg0, arg1);
        0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::ilevel::set_level_modifier(arg3, arg4, arg5);
    }

    entry fun set_perk_supply(arg0: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::authority::GameOperatorCap, arg1: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::authority::OperatorCapsBag, arg2: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::version::Version, arg3: &mut 0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::iperks::PerksMetadataHolder, arg4: 0x1::string::String, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock) {
        0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::version::validate_version(arg2);
        0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::authority::is_operator(arg0, arg1);
        0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::perks::validate_perk_name(arg3, arg4);
        if (0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::iperks::has_perk_supply(arg3, arg4)) {
            0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::iperks::update_supply_config(0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::iperks::borrow_mut_perk_supply_info(arg3, arg4), arg5, arg6);
        } else {
            0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::iperks::add_perk_supply(arg3, arg4, arg5, arg6, arg7);
        };
    }

    entry fun set_player_registry(arg0: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::authority::GameOperatorCap, arg1: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::authority::OperatorCapsBag, arg2: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::version::Version, arg3: &mut 0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::iplayer::PlayersRegistry, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64) {
        0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::version::validate_version(arg2);
        0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::authority::is_operator(arg0, arg1);
        0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::iplayer::set_player_registry(arg3, arg4, arg5, arg6, arg7, arg8);
    }

    entry fun set_system_config(arg0: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::authority::GameOperatorCap, arg1: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::authority::OperatorCapsBag, arg2: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::version::Version, arg3: &mut 0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::isystem::SystemConfig, arg4: u8, arg5: u8, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: address, arg16: &0x2::clock::Clock) {
        0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::version::validate_version(arg2);
        0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::authority::is_operator(arg0, arg1);
        0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::isystem::set_system_config(arg3, arg7, arg8, arg4, arg6, arg5, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16);
    }

    entry fun set_unit_recruit_cost(arg0: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::authority::GameOperatorCap, arg1: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::authority::OperatorCapsBag, arg2: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::version::Version, arg3: &mut 0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::igangsters::GangsterBaseStats, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64) {
        0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::version::validate_version(arg2);
        0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::authority::is_operator(arg0, arg1);
        0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::igangsters::add_gangster_recruit_cost(0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::igangsters::borrow_mut_gangster_stats(arg3, arg4), 0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::igangsters::new_gangster_recruit_cost(arg5, arg6));
    }

    entry fun update_perk_description(arg0: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::authority::GameOperatorCap, arg1: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::authority::OperatorCapsBag, arg2: &0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::version::Version, arg3: &mut 0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::iperks::PerksMetadataHolder, arg4: 0x1::string::String, arg5: 0x1::string::String) {
        0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::version::validate_version(arg2);
        0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::authority::is_operator(arg0, arg1);
        0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::perks::validate_perk_name(arg3, arg4);
        0x17968b6403b4db37baaee38251a19cfec39c8e0db0ed88e7b074f5783310fb::perks::update_perk_description(arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

