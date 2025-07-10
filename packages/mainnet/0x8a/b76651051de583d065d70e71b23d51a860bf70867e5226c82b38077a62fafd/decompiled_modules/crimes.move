module 0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes {
    entry fun create_blackmail_type(arg0: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_authority::AdminCap, arg1: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_version::Version, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_version::validate_version(arg1);
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::iblackmail::new_blackmail_type(arg2, arg3);
    }

    entry fun create_safe(arg0: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_authority::AdminCap, arg1: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_version::Version, arg2: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::icrack_safe::SafeRegistry, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_version::validate_version(arg1);
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::icrack_safe::share_safe(0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::icrack_safe::new_safe(arg3, arg2, arg4));
    }

    entry fun set_blackmail_config(arg0: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_authority::AdminCap, arg1: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_version::Version, arg2: &mut 0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::iblackmail::BlackmailRegistry, arg3: vector<u64>, arg4: vector<u64>, arg5: vector<u64>, arg6: vector<u64>) {
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_version::validate_version(arg1);
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::iblackmail::set_blackmail_config(arg2, arg3, arg4, arg5, arg6);
    }

    entry fun set_initial_mission_value(arg0: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_authority::AdminCap, arg1: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_version::Version, arg2: &mut 0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::imission::MissionRegistry, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u128, arg11: u128, arg12: u64, arg13: u64, arg14: u64, arg15: u64) {
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_version::validate_version(arg1);
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::mission::validate_level(arg2, &arg15);
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::imission::add_config(arg2, 0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::mission::initialize_player_mission(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15), arg15);
    }

    entry fun set_safe_config_value(arg0: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_authority::AdminCap, arg1: &0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_version::Version, arg2: &mut 0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::icrack_safe::SafeRegistry, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64) {
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::crimes_version::validate_version(arg1);
        0x8ab76651051de583d065d70e71b23d51a860bf70867e5226c82b38077a62fafd::icrack_safe::set_safe_configs(arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    // decompiled from Move bytecode v6
}

