module 0x4ed3c9413856c3f13df3098543b48b788cac9c8961d6997fd1c69e6230e8d995::crimes {
    entry fun create_blackmail_type(arg0: &0x4ed3c9413856c3f13df3098543b48b788cac9c8961d6997fd1c69e6230e8d995::crimes_authority::AdminCap, arg1: &0x4ed3c9413856c3f13df3098543b48b788cac9c8961d6997fd1c69e6230e8d995::crimes_version::Version, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        0x4ed3c9413856c3f13df3098543b48b788cac9c8961d6997fd1c69e6230e8d995::crimes_version::validate_version(arg1);
        0x4ed3c9413856c3f13df3098543b48b788cac9c8961d6997fd1c69e6230e8d995::iblackmail::new_blackmail_type(arg2, arg3);
    }

    entry fun create_safe(arg0: &0x4ed3c9413856c3f13df3098543b48b788cac9c8961d6997fd1c69e6230e8d995::crimes_authority::AdminCap, arg1: &0x4ed3c9413856c3f13df3098543b48b788cac9c8961d6997fd1c69e6230e8d995::crimes_version::Version, arg2: &0x4ed3c9413856c3f13df3098543b48b788cac9c8961d6997fd1c69e6230e8d995::icrack_safe::SafeRegistry, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x4ed3c9413856c3f13df3098543b48b788cac9c8961d6997fd1c69e6230e8d995::crimes_version::validate_version(arg1);
        0x4ed3c9413856c3f13df3098543b48b788cac9c8961d6997fd1c69e6230e8d995::icrack_safe::share_safe(0x4ed3c9413856c3f13df3098543b48b788cac9c8961d6997fd1c69e6230e8d995::icrack_safe::new_safe(arg3, arg2, arg4));
    }

    entry fun set_blackmail_config(arg0: &0x4ed3c9413856c3f13df3098543b48b788cac9c8961d6997fd1c69e6230e8d995::crimes_authority::AdminCap, arg1: &0x4ed3c9413856c3f13df3098543b48b788cac9c8961d6997fd1c69e6230e8d995::crimes_version::Version, arg2: &mut 0x4ed3c9413856c3f13df3098543b48b788cac9c8961d6997fd1c69e6230e8d995::iblackmail::BlackmailRegistry, arg3: vector<u64>, arg4: vector<u64>, arg5: vector<u64>, arg6: vector<u64>) {
        0x4ed3c9413856c3f13df3098543b48b788cac9c8961d6997fd1c69e6230e8d995::crimes_version::validate_version(arg1);
        0x4ed3c9413856c3f13df3098543b48b788cac9c8961d6997fd1c69e6230e8d995::iblackmail::set_blackmail_config(arg2, arg3, arg4, arg5, arg6);
    }

    entry fun set_initial_mission_value(arg0: &0x4ed3c9413856c3f13df3098543b48b788cac9c8961d6997fd1c69e6230e8d995::crimes_authority::AdminCap, arg1: &0x4ed3c9413856c3f13df3098543b48b788cac9c8961d6997fd1c69e6230e8d995::crimes_version::Version, arg2: &mut 0x4ed3c9413856c3f13df3098543b48b788cac9c8961d6997fd1c69e6230e8d995::imission::MissionRegistry, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u128, arg11: u128, arg12: u64, arg13: u64, arg14: u64, arg15: u64) {
        0x4ed3c9413856c3f13df3098543b48b788cac9c8961d6997fd1c69e6230e8d995::crimes_version::validate_version(arg1);
        0x4ed3c9413856c3f13df3098543b48b788cac9c8961d6997fd1c69e6230e8d995::mission::validate_level(arg2, &arg15);
        0x4ed3c9413856c3f13df3098543b48b788cac9c8961d6997fd1c69e6230e8d995::imission::add_config(arg2, 0x4ed3c9413856c3f13df3098543b48b788cac9c8961d6997fd1c69e6230e8d995::mission::initialize_player_mission(arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15), arg15);
    }

    entry fun set_safe_config_value(arg0: &0x4ed3c9413856c3f13df3098543b48b788cac9c8961d6997fd1c69e6230e8d995::crimes_authority::AdminCap, arg1: &0x4ed3c9413856c3f13df3098543b48b788cac9c8961d6997fd1c69e6230e8d995::crimes_version::Version, arg2: &mut 0x4ed3c9413856c3f13df3098543b48b788cac9c8961d6997fd1c69e6230e8d995::icrack_safe::SafeRegistry, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64) {
        0x4ed3c9413856c3f13df3098543b48b788cac9c8961d6997fd1c69e6230e8d995::crimes_version::validate_version(arg1);
        0x4ed3c9413856c3f13df3098543b48b788cac9c8961d6997fd1c69e6230e8d995::icrack_safe::set_safe_configs(arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    // decompiled from Move bytecode v6
}

