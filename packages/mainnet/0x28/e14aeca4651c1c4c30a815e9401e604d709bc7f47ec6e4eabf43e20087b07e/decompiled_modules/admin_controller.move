module 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::admin_controller {
    entry fun add_perk_metadata(arg0: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::GameOperatorCap, arg1: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::OperatorCapsBag, arg2: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::version::Version, arg3: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iperks::PerksMetadataHolder, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: 0x1::string::String, arg8: u64, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock) {
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::version::validate_version(arg2);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::is_operator(arg0, arg1);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::perks::validate_perk_metadata(arg3, arg4);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iperks::add_perk_metadata(arg3, arg4, arg5, arg6, arg7, arg8, arg10, arg9, arg11);
    }

    entry fun add_player_pause(arg0: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::GameOperatorCap, arg1: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::OperatorCapsBag, arg2: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player) {
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::is_operator(arg0, arg1);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::add_player_df<bool>(arg2, 0x1::string::utf8(b"pause_attack"), true);
    }

    entry fun create_bounty_session_admin(arg0: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::CapWrapper, arg1: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::GameOperatorCap, arg2: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::OperatorCapsBag, arg3: 0x2::object::ID, arg4: &mut 0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::ibounty::BattleSessionRegistry, arg5: 0x2::object::ID, arg6: u128, arg7: &0x2::clock::Clock) {
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::is_operator(arg1, arg2);
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::bounty::create_bounty_session(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::borrow_crimes_cap(arg0), arg4, arg3, arg5, arg6, arg7);
    }

    entry fun mint_perk(arg0: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::GameOperatorCap, arg1: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::OperatorCapsBag, arg2: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::version::Version, arg3: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iperks::PerksMetadataHolder, arg4: 0x1::string::String, arg5: address, arg6: 0x2::object::ID, arg7: &mut 0x2::tx_context::TxContext) {
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::version::validate_version(arg2);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::is_operator(arg0, arg1);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iperks::transfer_perk(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iperks::new(arg3, arg4, arg6, arg7), arg5);
    }

    entry fun remove_player_pause(arg0: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::GameOperatorCap, arg1: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::OperatorCapsBag, arg2: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::Player, arg3: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::FeedRegistry, arg4: &0x2::clock::Clock, arg5: bool) {
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::is_operator(arg0, arg1);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::remove_player_df<bool>(arg2, 0x1::string::utf8(b"pause_attack"));
        if (arg5 == true) {
            let v0 = 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iplayer::borrow_feed_registry_values(arg3);
            0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::players::update_timer(arg2, 0x1::string::utf8(b"feed_people"), *0x1::vector::borrow<u64>(&v0, 2) + 0x2::clock::timestamp_ms(arg4));
        };
    }

    public fun set_action_type_config(arg0: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::GameOperatorCap, arg1: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::OperatorCapsBag, arg2: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::version::Version, arg3: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ilevel::LevelPointRegistry, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64) {
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::version::validate_version(arg2);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::is_operator(arg0, arg1);
    }

    public fun set_bonus_xp_config(arg0: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::GameOperatorCap, arg1: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::OperatorCapsBag, arg2: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::version::Version, arg3: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iexperience::XPBonusConfig, arg4: u64, arg5: vector<u64>, arg6: vector<u64>, arg7: vector<u64>, arg8: vector<u64>, arg9: vector<u64>, arg10: vector<u64>, arg11: u64, arg12: u64) {
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::version::validate_version(arg2);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::is_operator(arg0, arg1);
    }

    public fun set_level_curve(arg0: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::GameOperatorCap, arg1: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::OperatorCapsBag, arg2: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::version::Version, arg3: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ilevel::LevelPointRegistry, arg4: u64, arg5: u8) {
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::version::validate_version(arg2);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::is_operator(arg0, arg1);
    }

    public fun set_level_modifier(arg0: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::GameOperatorCap, arg1: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::OperatorCapsBag, arg2: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::version::Version, arg3: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::ilevel::LevelPointRegistry, arg4: u64, arg5: u8) {
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::version::validate_version(arg2);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::is_operator(arg0, arg1);
    }

    entry fun set_perk_supply(arg0: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::GameOperatorCap, arg1: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::OperatorCapsBag, arg2: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::version::Version, arg3: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iperks::PerksMetadataHolder, arg4: 0x1::string::String, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock) {
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::version::validate_version(arg2);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::is_operator(arg0, arg1);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::perks::validate_perk_name(arg3, arg4);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iperks::set_perk_price(arg3, arg4, arg7);
        if (0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iperks::has_perk_supply(arg3, arg4)) {
            0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iperks::update_supply_config(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iperks::borrow_mut_perk_supply_info(arg3, arg4), arg5, arg6);
        } else {
            0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iperks::add_perk_supply(arg3, arg4, arg5, arg6, arg8);
        };
    }

    entry fun set_perks_category(arg0: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::GameOperatorCap, arg1: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::OperatorCapsBag, arg2: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::version::Version, arg3: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iperks::PerksMetadataHolder, arg4: 0x1::string::String, arg5: 0x1::string::String) {
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::version::validate_version(arg2);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::is_operator(arg0, arg1);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::iperks::set_perks_category(arg3, arg4, arg5);
    }

    entry fun set_unit_recruit_cost(arg0: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::GameOperatorCap, arg1: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::OperatorCapsBag, arg2: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::version::Version, arg3: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::igangsters::GangsterBaseStats, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64) {
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::version::validate_version(arg2);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::is_operator(arg0, arg1);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::igangsters::add_gangster_recruit_cost(0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::igangsters::borrow_mut_gangster_stats(arg3, arg4), 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::igangsters::new_gangster_recruit_cost(arg5, arg6));
    }

    entry fun update_unit_base_stats(arg0: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::GameOperatorCap, arg1: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::OperatorCapsBag, arg2: &0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::version::Version, arg3: &mut 0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::igangsters::GangsterBaseStats, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: u128, arg8: u128, arg9: 0x1::string::String, arg10: u64) {
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::version::validate_version(arg2);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::authority::is_operator(arg0, arg1);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::gangsters::validate_available_gangster(arg3, arg4);
        0x63081c5dd824a49289b6557d9f9bcf8613fe801e89dbad728616348a58b4b40a::igangsters::update_gangster_stats_df(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    // decompiled from Move bytecode v6
}

