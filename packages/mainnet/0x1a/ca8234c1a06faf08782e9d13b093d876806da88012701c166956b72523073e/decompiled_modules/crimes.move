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

    entry fun set_blackmail_config(arg0: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_authority::GameOperatorCap, arg1: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_authority::OperatorCapsBag, arg2: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_version::Version, arg3: &mut 0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::iblackmail::BlackmailRegistry, arg4: vector<u64>, arg5: vector<u64>, arg6: vector<u64>, arg7: vector<u64>) {
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_authority::is_operator(arg0, arg1);
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_version::validate_version(arg2);
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::iblackmail::set_blackmail_config(arg3, arg4, arg5, arg6, arg7);
    }

    entry fun set_initial_mission_value(arg0: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_authority::GameOperatorCap, arg1: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_authority::OperatorCapsBag, arg2: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_version::Version, arg3: &mut 0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::imission::MissionRegistry, arg4: 0x1::string::String, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u128, arg12: u128, arg13: u64, arg14: u64, arg15: u64, arg16: u64) {
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_authority::is_operator(arg0, arg1);
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_version::validate_version(arg2);
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::mission::validate_level(arg3, &arg16);
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::imission::add_config(arg3, 0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::mission::initialize_player_mission(arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16), arg16);
    }

    entry fun set_safe_config_value(arg0: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_authority::GameOperatorCap, arg1: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_authority::OperatorCapsBag, arg2: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_version::Version, arg3: &mut 0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::icrack_safe::SafeRegistry, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64) {
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_authority::is_operator(arg0, arg1);
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_version::validate_version(arg2);
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::icrack_safe::set_safe_configs(arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    entry fun update_mission_value(arg0: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_authority::GameOperatorCap, arg1: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_authority::OperatorCapsBag, arg2: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_version::Version, arg3: &mut 0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::imission::MissionRegistry, arg4: 0x1::string::String, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u128, arg12: u128, arg13: u64, arg14: u64, arg15: u64, arg16: u64) {
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_authority::is_operator(arg0, arg1);
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_version::validate_version(arg2);
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::imission::update_mission_config(arg3, arg16, arg4, arg5, arg6, arg7, arg8, arg9, arg10, (arg11 as u128) * 0x1::u128::pow(2, 64), (arg12 as u128) * 0x1::u128::pow(2, 64), arg13, arg14, arg15);
    }

    // decompiled from Move bytecode v6
}

