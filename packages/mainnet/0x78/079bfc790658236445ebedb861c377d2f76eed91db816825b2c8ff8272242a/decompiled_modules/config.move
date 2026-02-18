module 0x14df736178104ac1f04525d58192a82eb390bba2422a79a69ac47046619e9d1c::config {
    struct CONFIG has drop {
        dummy_field: bool,
    }

    struct PlayerConfig has store, key {
        id: 0x2::object::UID,
        one_day_ms: u64,
        points_per_sui: u64,
        referral_reward_percent: u64,
        referral_claim_threshold: u64,
        referral_launch_timestamp_ms: 0x1::option::Option<u64>,
        referral_program_duration_ms: u64,
        referral_rates: 0x2::table::Table<0x1::string::String, u64>,
        creator_rates: 0x2::table::Table<0x1::string::String, u64>,
        game_params: 0x2::table::Table<0x1::string::String, u64>,
        token_point_rates: 0x2::table::Table<0x1::string::String, u64>,
        token_decimals: 0x2::table::Table<0x1::string::String, u8>,
        string_params: 0x2::table::Table<0x1::string::String, 0x1::string::String>,
    }

    public fun admin_change_one_day_ms(arg0: &0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::Admins, arg1: &mut PlayerConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::check_admin(arg0, arg3);
        arg1.one_day_ms = arg2;
    }

    public fun admin_change_points_per_sui(arg0: &0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::Admins, arg1: &mut PlayerConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::check_admin(arg0, arg3);
        arg1.points_per_sui = arg2;
    }

    public fun admin_change_referral_claim_threshold(arg0: &0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::Admins, arg1: &mut PlayerConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::check_admin(arg0, arg3);
        arg1.referral_claim_threshold = arg2;
    }

    public fun admin_change_referral_reward_percent(arg0: &0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::Admins, arg1: &mut PlayerConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::check_admin(arg0, arg3);
        arg1.referral_reward_percent = arg2;
    }

    public fun admin_end_season(arg0: &0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::Admins, arg1: &mut PlayerConfig, arg2: &mut 0x2::tx_context::TxContext) {
        0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::check_admin(arg0, arg2);
        arg1.referral_launch_timestamp_ms = 0x1::option::none<u64>();
    }

    public fun admin_set_creator_rate(arg0: &0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::Admins, arg1: &mut PlayerConfig, arg2: 0x1::string::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::check_admin(arg0, arg4);
        if (0x2::table::contains<0x1::string::String, u64>(&arg1.creator_rates, arg2)) {
            *0x2::table::borrow_mut<0x1::string::String, u64>(&mut arg1.creator_rates, arg2) = arg3;
        } else {
            0x2::table::add<0x1::string::String, u64>(&mut arg1.creator_rates, arg2, arg3);
        };
    }

    public fun admin_set_game_param(arg0: &0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::Admins, arg1: &mut PlayerConfig, arg2: 0x1::string::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::check_admin(arg0, arg4);
        if (0x2::table::contains<0x1::string::String, u64>(&arg1.game_params, arg2)) {
            *0x2::table::borrow_mut<0x1::string::String, u64>(&mut arg1.game_params, arg2) = arg3;
        } else {
            0x2::table::add<0x1::string::String, u64>(&mut arg1.game_params, arg2, arg3);
        };
    }

    public fun admin_set_game_param_for_token<T0>(arg0: &0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::Admins, arg1: &mut PlayerConfig, arg2: 0x1::string::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::check_admin(arg0, arg4);
        0x1::string::append(&mut arg2, 0x1::string::utf8(b"::<"));
        0x1::string::append(&mut arg2, 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>())));
        0x1::string::append(&mut arg2, 0x1::string::utf8(b">"));
        if (0x2::table::contains<0x1::string::String, u64>(&arg1.game_params, arg2)) {
            *0x2::table::borrow_mut<0x1::string::String, u64>(&mut arg1.game_params, arg2) = arg3;
        } else {
            0x2::table::add<0x1::string::String, u64>(&mut arg1.game_params, arg2, arg3);
        };
    }

    public fun admin_set_referral_launch_timestamp(arg0: &0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::Admins, arg1: &mut PlayerConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::check_admin(arg0, arg3);
        arg1.referral_launch_timestamp_ms = 0x1::option::some<u64>(arg2);
    }

    public fun admin_set_referral_program_duration(arg0: &0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::Admins, arg1: &mut PlayerConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::check_admin(arg0, arg3);
        arg1.referral_program_duration_ms = arg2;
    }

    public fun admin_set_referral_rate(arg0: &0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::Admins, arg1: &mut PlayerConfig, arg2: 0x1::string::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::check_admin(arg0, arg4);
        if (0x2::table::contains<0x1::string::String, u64>(&arg1.referral_rates, arg2)) {
            *0x2::table::borrow_mut<0x1::string::String, u64>(&mut arg1.referral_rates, arg2) = arg3;
        } else {
            0x2::table::add<0x1::string::String, u64>(&mut arg1.referral_rates, arg2, arg3);
        };
    }

    public fun admin_set_string_param(arg0: &0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::Admins, arg1: &mut PlayerConfig, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::check_admin(arg0, arg4);
        if (0x2::table::contains<0x1::string::String, 0x1::string::String>(&arg1.string_params, arg2)) {
            *0x2::table::borrow_mut<0x1::string::String, 0x1::string::String>(&mut arg1.string_params, arg2) = arg3;
        } else {
            0x2::table::add<0x1::string::String, 0x1::string::String>(&mut arg1.string_params, arg2, arg3);
        };
    }

    public fun admin_set_token_decimals(arg0: &0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::Admins, arg1: &mut PlayerConfig, arg2: 0x1::string::String, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::check_admin(arg0, arg4);
        if (0x2::table::contains<0x1::string::String, u8>(&arg1.token_decimals, arg2)) {
            *0x2::table::borrow_mut<0x1::string::String, u8>(&mut arg1.token_decimals, arg2) = arg3;
        } else {
            0x2::table::add<0x1::string::String, u8>(&mut arg1.token_decimals, arg2, arg3);
        };
    }

    public fun admin_set_token_rate(arg0: &0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::Admins, arg1: &mut PlayerConfig, arg2: 0x1::string::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::check_admin(arg0, arg4);
        assert!(arg3 > 0, 0);
        if (0x2::table::contains<0x1::string::String, u64>(&arg1.token_point_rates, arg2)) {
            *0x2::table::borrow_mut<0x1::string::String, u64>(&mut arg1.token_point_rates, arg2) = arg3;
        } else {
            0x2::table::add<0x1::string::String, u64>(&mut arg1.token_point_rates, arg2, arg3);
        };
    }

    public fun admin_start_new_season(arg0: &0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::Admins, arg1: &mut PlayerConfig, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::check_admin(arg0, arg4);
        arg1.referral_launch_timestamp_ms = 0x1::option::some<u64>(arg2);
        arg1.referral_program_duration_ms = arg3;
    }

    public fun get_config_id(arg0: &PlayerConfig) : 0x2::object::ID {
        *0x2::object::uid_as_inner(&arg0.id)
    }

    public fun get_creator_rate(arg0: &PlayerConfig, arg1: 0x1::string::String) : u64 {
        if (0x2::table::contains<0x1::string::String, u64>(&arg0.creator_rates, arg1)) {
            *0x2::table::borrow<0x1::string::String, u64>(&arg0.creator_rates, arg1)
        } else {
            0
        }
    }

    public fun get_game_param(arg0: &PlayerConfig, arg1: 0x1::string::String) : u64 {
        if (0x2::table::contains<0x1::string::String, u64>(&arg0.game_params, arg1)) {
            *0x2::table::borrow<0x1::string::String, u64>(&arg0.game_params, arg1)
        } else {
            0
        }
    }

    public fun get_game_param_for_token<T0>(arg0: &PlayerConfig, arg1: 0x1::string::String) : u64 {
        0x1::string::append(&mut arg1, 0x1::string::utf8(b"::<"));
        0x1::string::append(&mut arg1, 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>())));
        0x1::string::append(&mut arg1, 0x1::string::utf8(b">"));
        if (0x2::table::contains<0x1::string::String, u64>(&arg0.game_params, arg1)) {
            *0x2::table::borrow<0x1::string::String, u64>(&arg0.game_params, arg1)
        } else if (0x2::table::contains<0x1::string::String, u64>(&arg0.game_params, arg1)) {
            *0x2::table::borrow<0x1::string::String, u64>(&arg0.game_params, arg1)
        } else {
            0
        }
    }

    public fun get_one_day_ms(arg0: &PlayerConfig) : u64 {
        arg0.one_day_ms
    }

    public fun get_points_per_sui(arg0: &PlayerConfig) : u64 {
        arg0.points_per_sui
    }

    public fun get_referral_claim_threshold(arg0: &PlayerConfig) : u64 {
        arg0.referral_claim_threshold
    }

    public fun get_referral_launch_window(arg0: &PlayerConfig) : (0x1::option::Option<u64>, u64) {
        (arg0.referral_launch_timestamp_ms, arg0.referral_program_duration_ms)
    }

    public fun get_referral_rate(arg0: &PlayerConfig, arg1: 0x1::string::String) : u64 {
        if (0x2::table::contains<0x1::string::String, u64>(&arg0.referral_rates, arg1)) {
            *0x2::table::borrow<0x1::string::String, u64>(&arg0.referral_rates, arg1)
        } else {
            0
        }
    }

    public fun get_referral_reward_percent(arg0: &PlayerConfig) : u64 {
        arg0.referral_reward_percent
    }

    public fun get_string_param(arg0: &PlayerConfig, arg1: 0x1::string::String) : 0x1::string::String {
        if (0x2::table::contains<0x1::string::String, 0x1::string::String>(&arg0.string_params, arg1)) {
            *0x2::table::borrow<0x1::string::String, 0x1::string::String>(&arg0.string_params, arg1)
        } else {
            0x1::string::utf8(b"")
        }
    }

    public fun get_token_decimals(arg0: &PlayerConfig, arg1: 0x1::string::String) : u8 {
        if (0x2::table::contains<0x1::string::String, u8>(&arg0.token_decimals, arg1)) {
            *0x2::table::borrow<0x1::string::String, u8>(&arg0.token_decimals, arg1)
        } else {
            9
        }
    }

    public fun get_token_rate(arg0: &PlayerConfig, arg1: 0x1::string::String) : u64 {
        if (0x2::table::contains<0x1::string::String, u64>(&arg0.token_point_rates, arg1)) {
            *0x2::table::borrow<0x1::string::String, u64>(&arg0.token_point_rates, arg1)
        } else {
            0
        }
    }

    fun init(arg0: CONFIG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::new<0x1::string::String, u64>(arg1);
        0x2::table::add<0x1::string::String, u64>(&mut v0, 0x1::string::utf8(b"Panther Wheel"), 20);
        0x2::table::add<0x1::string::String, u64>(&mut v0, 0x1::string::utf8(b"Spin Rush"), 2);
        let v1 = 0x2::table::new<0x1::string::String, u64>(arg1);
        0x2::table::add<0x1::string::String, u64>(&mut v1, 0x1::string::utf8(b"Panther Wheel"), 30);
        0x2::table::add<0x1::string::String, u64>(&mut v1, 0x1::string::utf8(b"Spin Rush"), 5);
        let v2 = 0x2::table::new<0x1::string::String, u64>(arg1);
        0x2::table::add<0x1::string::String, u64>(&mut v2, 0x1::string::utf8(b"Panther Wheel::Rake"), 1000);
        0x2::table::add<0x1::string::String, u64>(&mut v2, 0x1::string::utf8(b"Panther Wheel::Price"), 2000000000);
        0x2::table::add<0x1::string::String, u64>(&mut v2, 0x1::string::utf8(b"Panther Wheel::MaxPots"), 3);
        0x2::table::add<0x1::string::String, u64>(&mut v2, 0x1::string::utf8(b"Panther Wheel::Alpha"), 1);
        0x2::table::add<0x1::string::String, u64>(&mut v2, 0x1::string::utf8(b"Referrals::WelcomeBonusPoints"), 500000000000);
        0x2::table::add<0x1::string::String, u64>(&mut v2, 0x1::string::utf8(b"Spin Rush::Weight::1X"), 1800);
        0x2::table::add<0x1::string::String, u64>(&mut v2, 0x1::string::utf8(b"Spin Rush::Weight::2X"), 2000);
        0x2::table::add<0x1::string::String, u64>(&mut v2, 0x1::string::utf8(b"Spin Rush::Weight::3X"), 300);
        0x2::table::add<0x1::string::String, u64>(&mut v2, 0x1::string::utf8(b"Spin Rush::Weight::4X"), 200);
        0x2::table::add<0x1::string::String, u64>(&mut v2, 0x1::string::utf8(b"Spin Rush::Weight::SpinAgain"), 1000);
        0x2::table::add<0x1::string::String, u64>(&mut v2, 0x1::string::utf8(b"Spin Rush::Weight::Points25"), 2250);
        0x2::table::add<0x1::string::String, u64>(&mut v2, 0x1::string::utf8(b"Spin Rush::PointsReward"), 25000000000);
        let v3 = 0x2::table::new<0x1::string::String, u64>(arg1);
        0x2::table::add<0x1::string::String, u64>(&mut v3, 0x1::string::utf8(b"0000000000000000000000000000000000000000000000000000000000000002::sui::SUI"), 1000000000);
        0x2::table::add<0x1::string::String, u64>(&mut v3, 0x1::string::utf8(b"0x2::sui::SUI"), 1000000000);
        let v4 = 0x2::table::new<0x1::string::String, u8>(arg1);
        0x2::table::add<0x1::string::String, u8>(&mut v4, 0x1::string::utf8(b"0000000000000000000000000000000000000000000000000000000000000002::sui::SUI"), 9);
        0x2::table::add<0x1::string::String, u8>(&mut v4, 0x1::string::utf8(b"0x2::sui::SUI"), 9);
        let v5 = 0x2::table::new<0x1::string::String, 0x1::string::String>(arg1);
        0x2::table::add<0x1::string::String, 0x1::string::String>(&mut v5, 0x1::string::utf8(b"walrus_base_url"), 0x1::string::utf8(b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/"));
        let v6 = PlayerConfig{
            id                           : 0x2::object::new(arg1),
            one_day_ms                   : 86400000,
            points_per_sui               : 1000,
            referral_reward_percent      : 5,
            referral_claim_threshold     : 1000000000,
            referral_launch_timestamp_ms : 0x1::option::none<u64>(),
            referral_program_duration_ms : 5184000000,
            referral_rates               : v0,
            creator_rates                : v1,
            game_params                  : v2,
            token_point_rates            : v3,
            token_decimals               : v4,
            string_params                : v5,
        };
        0x2::transfer::public_share_object<PlayerConfig>(v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<CONFIG>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

