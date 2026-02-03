module 0x4383728ab096875b13e356a1fb3bddce4bdd6d3bb5a2199055c5ffb4fc81ced8::spin_rush {
    struct SPIN_RUSH has drop {
        dummy_field: bool,
    }

    struct SpinAgain has key {
        id: 0x2::object::UID,
    }

    struct FHCap has drop {
        dummy_field: bool,
    }

    struct SpinEvent has copy, drop {
        player: address,
        stake_mist: u64,
        outcome: u8,
        multiplier: u64,
        payout_mist: u64,
        random_sample: u64,
        again_followup: bool,
        followup_id: address,
        ts_ms: u64,
    }

    struct SpingAgainEvent has copy, drop {
        player: address,
        outcome: u8,
        random_sample: u64,
        ts_ms: u64,
    }

    public fun burn_spin_again(arg0: SpinAgain) {
        let SpinAgain { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    fun get_param_or_default(arg0: &0x14df736178104ac1f04525d58192a82eb390bba2422a79a69ac47046619e9d1c::config::PlayerConfig, arg1: 0x1::string::String, arg2: u64) : u64 {
        let v0 = 0x14df736178104ac1f04525d58192a82eb390bba2422a79a69ac47046619e9d1c::config::get_game_param(arg0, arg1);
        if (v0 == 0) {
            arg2
        } else {
            v0
        }
    }

    public fun get_spin_again_id(arg0: &SpinAgain) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    fun handle_non_mult<T0>(arg0: u8, arg1: &mut 0x14df736178104ac1f04525d58192a82eb390bba2422a79a69ac47046619e9d1c::voultron_players::VoultronPlayer, arg2: &0x14df736178104ac1f04525d58192a82eb390bba2422a79a69ac47046619e9d1c::voultron_players::WhitelistedPlayerModules, arg3: &0xdec974fe362e058b64b8215886ec45c17560e4d67da7133e75bb49f094b055ac::award_points::AwardPointsWhitelistedModule, arg4: &mut 0x2::token::TokenPolicy<0xdec974fe362e058b64b8215886ec45c17560e4d67da7133e75bb49f094b055ac::voultron_points::VOULTRON_POINTS>, arg5: &mut 0xdec974fe362e058b64b8215886ec45c17560e4d67da7133e75bb49f094b055ac::voultron_points::PointsTreasuryCapOwner, arg6: &0x14df736178104ac1f04525d58192a82eb390bba2422a79a69ac47046619e9d1c::config::PlayerConfig, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        if (arg0 == 6) {
            let v0 = FHCap{dummy_field: false};
            0x14df736178104ac1f04525d58192a82eb390bba2422a79a69ac47046619e9d1c::voultron_players::award_points<FHCap, T0>(arg1, arg2, arg3, arg4, arg5, v0, get_param_or_default(arg6, 0x1::string::utf8(b"Spin Rush::PointsReward"), 25000000000), arg6, arg7, arg8);
        };
    }

    fun map_outcome(arg0: u64, arg1: &0x14df736178104ac1f04525d58192a82eb390bba2422a79a69ac47046619e9d1c::config::PlayerConfig) : (u8, u64) {
        let v0 = 0 + get_param_or_default(arg1, 0x1::string::utf8(b"Spin Rush::Weight::1X"), 1800);
        if (arg0 < v0) {
            return (1, 1)
        };
        let v1 = v0 + get_param_or_default(arg1, 0x1::string::utf8(b"Spin Rush::Weight::2X"), 2000);
        if (arg0 < v1) {
            return (2, 2)
        };
        let v2 = v1 + get_param_or_default(arg1, 0x1::string::utf8(b"Spin Rush::Weight::3X"), 300);
        if (arg0 < v2) {
            return (3, 3)
        };
        let v3 = v2 + get_param_or_default(arg1, 0x1::string::utf8(b"Spin Rush::Weight::4X"), 200);
        if (arg0 < v3) {
            return (4, 4)
        };
        let v4 = v3 + get_param_or_default(arg1, 0x1::string::utf8(b"Spin Rush::Weight::SpinAgain"), 1000);
        if (arg0 < v4) {
            return (8, 0)
        };
        if (arg0 < v4 + get_param_or_default(arg1, 0x1::string::utf8(b"Spin Rush::Weight::Points25"), 2250)) {
            return (6, 0)
        };
        (5, 0)
    }

    fun map_spin_again_followup(arg0: u64) : u8 {
        let v0 = 0 + 35;
        if (arg0 < v0) {
            return 5
        };
        if (arg0 < v0 + 20) {
            return 6
        };
        5
    }

    entry fun spin<T0>(arg0: &0x4383728ab096875b13e356a1fb3bddce4bdd6d3bb5a2199055c5ffb4fc81ced8::sr_config::SRConfig, arg1: &0x2::random::Random, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x930c7f9155da8239d928358abb8b40627f44bdc0be7b3a5a34b3b5e428fe3086::voultron_treasury::Treasury<T0>, arg4: &0x930c7f9155da8239d928358abb8b40627f44bdc0be7b3a5a34b3b5e428fe3086::voultron_treasury::TreasuryWhitelistedModules, arg5: &mut 0x14df736178104ac1f04525d58192a82eb390bba2422a79a69ac47046619e9d1c::referrals::Referrals, arg6: &0xe59e5e4471b3878b360f9ed7b5551aa67a03a4a6096732f3238aba19ed27725::creators::Creators, arg7: &0x14df736178104ac1f04525d58192a82eb390bba2422a79a69ac47046619e9d1c::config::PlayerConfig, arg8: &mut 0x14df736178104ac1f04525d58192a82eb390bba2422a79a69ac47046619e9d1c::voultron_players::VoultronPlayer, arg9: &0x14df736178104ac1f04525d58192a82eb390bba2422a79a69ac47046619e9d1c::voultron_players::WhitelistedPlayerModules, arg10: &0xdec974fe362e058b64b8215886ec45c17560e4d67da7133e75bb49f094b055ac::award_points::AwardPointsWhitelistedModule, arg11: &mut 0x2::token::TokenPolicy<0xdec974fe362e058b64b8215886ec45c17560e4d67da7133e75bb49f094b055ac::voultron_points::VOULTRON_POINTS>, arg12: &mut 0xdec974fe362e058b64b8215886ec45c17560e4d67da7133e75bb49f094b055ac::voultron_points::PointsTreasuryCapOwner, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = FHCap{dummy_field: false};
        0x14df736178104ac1f04525d58192a82eb390bba2422a79a69ac47046619e9d1c::referrals::accrue_referral_revenue<T0, FHCap>(arg5, arg6, arg7, arg9, arg3, arg4, v1, v0, 0x2::tx_context::sender(arg14), 0x2::tx_context::sender(arg14), 0x1::string::utf8(b"Spin Rush"), arg13, arg14);
        let v2 = 0x2::random::new_generator(arg1, arg14);
        let v3 = 0x2::random::generate_u64_in_range(&mut v2, 0, 10000);
        let (v4, v5) = map_outcome(v3, arg7);
        let v6 = v4;
        let v7 = 0x2::tx_context::sender(arg14);
        assert!(v0 >= 0x4383728ab096875b13e356a1fb3bddce4bdd6d3bb5a2199055c5ffb4fc81ced8::sr_config::get_min_stake(arg0), 2);
        assert!(v0 <= 0x4383728ab096875b13e356a1fb3bddce4bdd6d3bb5a2199055c5ffb4fc81ced8::sr_config::get_max_stake(arg0), 1);
        let v8 = FHCap{dummy_field: false};
        0x14df736178104ac1f04525d58192a82eb390bba2422a79a69ac47046619e9d1c::voultron_players::update_streak<FHCap>(arg8, arg9, arg10, arg11, arg12, v8, arg7, arg13, arg14);
        let v9 = FHCap{dummy_field: false};
        0x14df736178104ac1f04525d58192a82eb390bba2422a79a69ac47046619e9d1c::voultron_players::award_points<FHCap, T0>(arg8, arg9, arg10, arg11, arg12, v9, 0x2::coin::value<T0>(&arg2), arg7, arg13, arg14);
        let v10 = false;
        let v11 = 0;
        let v12 = 0x2::tx_context::sender(arg14);
        if (v5 > 0) {
            if (v5 == 1) {
                v11 = v0;
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, v7);
            } else {
                let v13 = FHCap{dummy_field: false};
                0x930c7f9155da8239d928358abb8b40627f44bdc0be7b3a5a34b3b5e428fe3086::voultron_treasury::add_to_treasury<FHCap, T0>(arg3, arg4, v13, arg2);
                let v14 = v0 * v5;
                let v15 = FHCap{dummy_field: false};
                v11 = v14;
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x930c7f9155da8239d928358abb8b40627f44bdc0be7b3a5a34b3b5e428fe3086::voultron_treasury::remove_from_treasury<FHCap, T0>(arg3, arg4, v15, v14, arg14), v7);
            };
        } else {
            let v16 = FHCap{dummy_field: false};
            0x930c7f9155da8239d928358abb8b40627f44bdc0be7b3a5a34b3b5e428fe3086::voultron_treasury::add_to_treasury<FHCap, T0>(arg3, arg4, v16, arg2);
            if (v4 == 8) {
                let v17 = SpinAgain{id: 0x2::object::new(arg14)};
                v12 = 0x2::object::id_address<SpinAgain>(&v17);
                0x2::transfer::transfer<SpinAgain>(v17, 0x2::tx_context::sender(arg14));
                v10 = true;
            } else {
                handle_non_mult<T0>(v4, arg8, arg9, arg10, arg11, arg12, arg7, arg13, arg14);
                if (v4 == 5) {
                    let v18 = 0x2::random::new_generator(arg1, arg14);
                    let v19 = if (0x2::random::generate_u64_in_range(&mut v18, 0, 1) == 0) {
                        5
                    } else {
                        7
                    };
                    v6 = v19;
                };
            };
        };
        let v20 = SpinEvent{
            player         : v7,
            stake_mist     : v0,
            outcome        : v6,
            multiplier     : v5,
            payout_mist    : v11,
            random_sample  : v3,
            again_followup : v10,
            followup_id    : v12,
            ts_ms          : 0x2::clock::timestamp_ms(arg13),
        };
        0x2::event::emit<SpinEvent>(v20);
    }

    entry fun spin_again<T0>(arg0: &0x2::random::Random, arg1: &mut 0x14df736178104ac1f04525d58192a82eb390bba2422a79a69ac47046619e9d1c::voultron_players::VoultronPlayer, arg2: &0x14df736178104ac1f04525d58192a82eb390bba2422a79a69ac47046619e9d1c::voultron_players::WhitelistedPlayerModules, arg3: &0xdec974fe362e058b64b8215886ec45c17560e4d67da7133e75bb49f094b055ac::award_points::AwardPointsWhitelistedModule, arg4: &mut 0x2::token::TokenPolicy<0xdec974fe362e058b64b8215886ec45c17560e4d67da7133e75bb49f094b055ac::voultron_points::VOULTRON_POINTS>, arg5: &mut 0xdec974fe362e058b64b8215886ec45c17560e4d67da7133e75bb49f094b055ac::voultron_points::PointsTreasuryCapOwner, arg6: &0x14df736178104ac1f04525d58192a82eb390bba2422a79a69ac47046619e9d1c::config::PlayerConfig, arg7: SpinAgain, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg0, arg9);
        let v1 = 0x2::random::generate_u64_in_range(&mut v0, 0, 65 - 1);
        let v2 = map_spin_again_followup(v1);
        let v3 = v2;
        handle_non_mult<T0>(v2, arg1, arg2, arg3, arg4, arg5, arg6, arg8, arg9);
        let SpinAgain { id: v4 } = arg7;
        0x2::object::delete(v4);
        if (v2 == 5) {
            let v5 = 0x2::random::new_generator(arg0, arg9);
            let v6 = if (0x2::random::generate_u64_in_range(&mut v5, 0, 1) == 0) {
                5
            } else {
                7
            };
            v3 = v6;
        };
        let v7 = SpingAgainEvent{
            player        : 0x2::tx_context::sender(arg9),
            outcome       : v3,
            random_sample : v1,
            ts_ms         : 0x2::clock::timestamp_ms(arg8),
        };
        0x2::event::emit<SpingAgainEvent>(v7);
    }

    entry fun spin_new<T0>(arg0: &0x4383728ab096875b13e356a1fb3bddce4bdd6d3bb5a2199055c5ffb4fc81ced8::sr_config::SRConfig, arg1: &0x2::random::Random, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x930c7f9155da8239d928358abb8b40627f44bdc0be7b3a5a34b3b5e428fe3086::voultron_treasury::Treasury<T0>, arg4: &0x930c7f9155da8239d928358abb8b40627f44bdc0be7b3a5a34b3b5e428fe3086::voultron_treasury::TreasuryWhitelistedModules, arg5: &mut 0x14df736178104ac1f04525d58192a82eb390bba2422a79a69ac47046619e9d1c::referrals::Referrals, arg6: &0xe59e5e4471b3878b360f9ed7b5551aa67a03a4a6096732f3238aba19ed27725::creators::Creators, arg7: &0x14df736178104ac1f04525d58192a82eb390bba2422a79a69ac47046619e9d1c::config::PlayerConfig, arg8: &0x14df736178104ac1f04525d58192a82eb390bba2422a79a69ac47046619e9d1c::voultron_players::WhitelistedPlayerModules, arg9: &0xdec974fe362e058b64b8215886ec45c17560e4d67da7133e75bb49f094b055ac::award_points::AwardPointsWhitelistedModule, arg10: &mut 0x2::token::TokenPolicy<0xdec974fe362e058b64b8215886ec45c17560e4d67da7133e75bb49f094b055ac::voultron_points::VOULTRON_POINTS>, arg11: &mut 0xdec974fe362e058b64b8215886ec45c17560e4d67da7133e75bb49f094b055ac::voultron_points::PointsTreasuryCapOwner, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = FHCap{dummy_field: false};
        let v1 = 0x14df736178104ac1f04525d58192a82eb390bba2422a79a69ac47046619e9d1c::voultron_players::create_player<FHCap>(arg8, v0, arg12, arg13);
        let v2 = &mut v1;
        spin<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, v2, arg8, arg9, arg10, arg11, arg12, arg13);
        0x2::transfer::public_transfer<0x14df736178104ac1f04525d58192a82eb390bba2422a79a69ac47046619e9d1c::voultron_players::VoultronPlayer>(v1, 0x2::tx_context::sender(arg13));
    }

    // decompiled from Move bytecode v6
}

