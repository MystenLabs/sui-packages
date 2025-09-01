module 0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes {
    entry fun create_blackmail_type(arg0: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_authority::GameOperatorCap, arg1: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_authority::OperatorCapsBag, arg2: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_version::Version, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_authority::is_operator(arg0, arg1);
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_version::validate_version(arg2);
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::iblackmail::new_blackmail_type(arg3, arg4);
    }

    entry fun create_safe(arg0: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_authority::GameOperatorCap, arg1: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_authority::OperatorCapsBag, arg2: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_version::Version, arg3: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::icrack_safe::SafeRegistry, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_authority::is_operator(arg0, arg1);
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_version::validate_version(arg2);
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::icrack_safe::share_safe(0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::icrack_safe::new_safe(arg4, arg3, arg5));
    }

    entry fun initialize_and_transfer_luca_cap(arg0: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_authority::GameOperatorCap, arg1: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_authority::OperatorCapsBag, arg2: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_version::Version, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_version::validate_version(arg2);
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::ibounty::initialize_and_transfer_luca_cap(arg0, arg1, arg3, arg4);
    }

    entry fun initialize_bullet_store(arg0: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_authority::GameOperatorCap, arg1: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_authority::OperatorCapsBag, arg2: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_version::Version, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: vector<u8>, arg10: u64, arg11: u64, arg12: address, arg13: address, arg14: u128, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_authority::is_operator(arg0, arg1);
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_version::validate_version(arg2);
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_version::validate_version(arg2);
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::ibounty::initialize_bullet_store(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg11, arg10, arg12, arg13, arg14, arg15, arg16);
    }

    entry fun seal_approve_luca(arg0: vector<u8>, arg1: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::ibounty::BulletStore, arg2: &0x2::tx_context::TxContext) {
        assert!(0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::ibounty::is_owner(arg1, 0x2::tx_context::sender(arg2)), 887);
    }

    entry fun seal_approve_magazine_info(arg0: vector<u8>, arg1: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::ibounty::MagazineInfo, arg2: &0x2::tx_context::TxContext) {
        assert!(0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::ibounty::is_allowlisted(arg1, 0x2::object::id_from_address(0x2::tx_context::sender(arg2))), 778);
    }

    entry fun set_blackmail_config(arg0: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_authority::GameOperatorCap, arg1: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_authority::OperatorCapsBag, arg2: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_version::Version, arg3: &mut 0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::iblackmail::BlackmailRegistry, arg4: vector<u64>, arg5: vector<u64>, arg6: vector<u64>, arg7: vector<u64>) {
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_authority::is_operator(arg0, arg1);
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_version::validate_version(arg2);
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::iblackmail::set_blackmail_config(arg3, arg4, arg5, arg6, arg7);
    }

    entry fun set_hospitalization_time(arg0: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_authority::GameOperatorCap, arg1: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_authority::OperatorCapsBag, arg2: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_version::Version, arg3: &mut 0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::ibounty::BattleSessionRegistry, arg4: u64) {
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_authority::is_operator(arg0, arg1);
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_version::validate_version(arg2);
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::ibounty::set_hospitalization_time(arg3, arg4);
    }

    entry fun set_initial_mission_value(arg0: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_authority::GameOperatorCap, arg1: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_authority::OperatorCapsBag, arg2: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_version::Version, arg3: &mut 0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::imission::MissionRegistry, arg4: 0x1::string::String, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u128, arg12: u128, arg13: u64, arg14: u64, arg15: u64, arg16: u64) {
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_authority::is_operator(arg0, arg1);
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_version::validate_version(arg2);
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::mission::validate_level(arg3, &arg16);
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::imission::add_config(arg3, 0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::mission::initialize_player_mission(arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16), arg16);
    }

    entry fun set_max_idle_time(arg0: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_authority::GameOperatorCap, arg1: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_authority::OperatorCapsBag, arg2: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_version::Version, arg3: &mut 0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::ibounty::BattleSessionRegistry, arg4: u64) {
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_authority::is_operator(arg0, arg1);
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_version::validate_version(arg2);
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::ibounty::set_max_idle_time(arg3, arg4);
    }

    entry fun set_min_bounty(arg0: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_authority::GameOperatorCap, arg1: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_authority::OperatorCapsBag, arg2: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_version::Version, arg3: &mut 0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::ibounty::BattleSessionRegistry, arg4: u128) {
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_authority::is_operator(arg0, arg1);
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_version::validate_version(arg2);
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::ibounty::set_min_bounty(arg3, arg4);
    }

    entry fun set_min_bullet(arg0: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_authority::GameOperatorCap, arg1: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_authority::OperatorCapsBag, arg2: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_version::Version, arg3: &mut 0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::ibounty::BattleSessionRegistry, arg4: u64) {
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_authority::is_operator(arg0, arg1);
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_version::validate_version(arg2);
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::ibounty::set_min_bullet(arg3, arg4);
    }

    entry fun set_safe_config_value(arg0: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_authority::GameOperatorCap, arg1: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_authority::OperatorCapsBag, arg2: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_version::Version, arg3: &mut 0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::icrack_safe::SafeRegistry, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64) {
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_authority::is_operator(arg0, arg1);
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_version::validate_version(arg2);
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::icrack_safe::set_safe_configs(arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    entry fun set_store_owner(arg0: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_authority::GameOperatorCap, arg1: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_authority::OperatorCapsBag, arg2: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_version::Version, arg3: &mut 0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::ibounty::BulletStore, arg4: address) {
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_authority::is_operator(arg0, arg1);
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_version::validate_version(arg2);
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::ibounty::set_store_owner(arg3, arg4);
    }

    entry fun set_store_values(arg0: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_authority::GameOperatorCap, arg1: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_authority::OperatorCapsBag, arg2: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_version::Version, arg3: &mut 0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::ibounty::BulletStore, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: address, arg11: address) {
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_authority::is_operator(arg0, arg1);
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_version::validate_version(arg2);
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::ibounty::set_store_values(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    entry fun update_mission_value(arg0: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_authority::GameOperatorCap, arg1: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_authority::OperatorCapsBag, arg2: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_version::Version, arg3: &mut 0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::imission::MissionRegistry, arg4: 0x1::string::String, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u128, arg12: u128, arg13: u64, arg14: u64, arg15: u64, arg16: u64) {
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_authority::is_operator(arg0, arg1);
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_version::validate_version(arg2);
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::imission::update_mission_config(arg3, arg16, arg4, arg5, arg6, arg7, arg8, arg9, arg10, (arg11 as u128) * 0x1::u128::pow(2, 64), (arg12 as u128) * 0x1::u128::pow(2, 64), arg13, arg14, arg15);
    }

    entry fun update_store_id(arg0: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::ibounty::LucaCap, arg1: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_version::Version, arg2: &mut 0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::ibounty::BulletStore, arg3: vector<u8>, arg4: &0x2::clock::Clock) {
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_version::validate_version(arg1);
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::ibounty::set_store_id(arg2, arg3);
        if (0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::ibounty::can_reset(arg2, arg4)) {
            0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::ibounty::reset_store(arg2, arg4);
        };
    }

    // decompiled from Move bytecode v6
}

