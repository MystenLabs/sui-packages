module 0x14df736178104ac1f04525d58192a82eb390bba2422a79a69ac47046619e9d1c::referrals {
    struct REFERRALS has drop {
        dummy_field: bool,
    }

    struct Referrals has store, key {
        id: 0x2::object::UID,
        referrer_stats: 0x2::table::Table<address, Stats>,
        referee_to_referrer: 0x2::table::Table<address, address>,
        referee_first_stake_recorded: 0x2::table::Table<address, bool>,
        referee_is_creator_referral: 0x2::table::Table<address, bool>,
    }

    struct FHCap has drop {
        dummy_field: bool,
    }

    struct Stats has copy, drop, store {
        users_count: u64,
        total_earned: u64,
        total_paid: u64,
    }

    struct ReferrerSetEvent has copy, drop {
        referee: address,
        referrer: address,
        timestamp: u64,
    }

    struct ReferralAccruedEvent has copy, drop {
        referrer: address,
        referee: address,
        stake_amount: u64,
        amount_earned: u64,
        timestamp: u64,
        game: 0x1::string::String,
    }

    struct ReferralPaidEvent has copy, drop {
        referrer: address,
        referee: address,
        amount: u64,
        timestamp: u64,
        game: 0x1::string::String,
    }

    public fun accrue_referral_revenue<T0, T1: drop>(arg0: &mut Referrals, arg1: &0xe59e5e4471b3878b360f9ed7b5551aa67a03a4a6096732f3238aba19ed27725::creators::Creators, arg2: &0x14df736178104ac1f04525d58192a82eb390bba2422a79a69ac47046619e9d1c::config::PlayerConfig, arg3: &0x14df736178104ac1f04525d58192a82eb390bba2422a79a69ac47046619e9d1c::voultron_players::WhitelistedPlayerModules, arg4: &mut 0x930c7f9155da8239d928358abb8b40627f44bdc0be7b3a5a34b3b5e428fe3086::voultron_treasury::Treasury<T0>, arg5: &0x930c7f9155da8239d928358abb8b40627f44bdc0be7b3a5a34b3b5e428fe3086::voultron_treasury::TreasuryWhitelistedModules, arg6: T1, arg7: u64, arg8: address, arg9: address, arg10: 0x1::string::String, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        assert!(0x14df736178104ac1f04525d58192a82eb390bba2422a79a69ac47046619e9d1c::voultron_players::check_if_module_whitelisted(arg3, 0x1::string::from_ascii(0x1::type_name::address_string(&v0))), 1);
        if (0x2::table::contains<address, address>(&arg0.referee_to_referrer, arg8)) {
            let v1 = *0x2::table::borrow<address, address>(&arg0.referee_to_referrer, arg8);
            if (0x2::table::contains<address, bool>(&arg0.referee_is_creator_referral, arg8) && *0x2::table::borrow<address, bool>(&arg0.referee_is_creator_referral, arg8)) {
                let (v2, v3) = 0x14df736178104ac1f04525d58192a82eb390bba2422a79a69ac47046619e9d1c::config::get_referral_launch_window(arg2);
                let v4 = v2;
                if (0x1::option::is_some<u64>(&v4)) {
                    let v5 = *0x1::option::borrow<u64>(&v4);
                    let v6 = 0x2::clock::timestamp_ms(arg11);
                    if (v6 >= v5 && v6 < v5 + v3) {
                        if (0x2::table::contains<address, address>(&arg0.referee_to_referrer, arg9) && *0x2::table::borrow<address, address>(&arg0.referee_to_referrer, arg9) == v1) {
                            if (!0x2::table::contains<address, bool>(&arg0.referee_first_stake_recorded, arg8)) {
                                0x2::table::add<address, bool>(&mut arg0.referee_first_stake_recorded, arg8, true);
                            } else if (*0x2::table::borrow<address, bool>(&arg0.referee_first_stake_recorded, arg8) == false) {
                                *0x2::table::borrow_mut<address, bool>(&mut arg0.referee_first_stake_recorded, arg8) = true;
                            };
                            let v7 = (((arg7 as u128) * (0x14df736178104ac1f04525d58192a82eb390bba2422a79a69ac47046619e9d1c::config::get_creator_rate(arg2, arg10) as u128) / 100) as u64);
                            if (v7 > 0) {
                                let v8 = get_or_create_stats(arg0, v1);
                                if (0xe59e5e4471b3878b360f9ed7b5551aa67a03a4a6096732f3238aba19ed27725::creators::check_creator(arg1, v1)) {
                                    v8.total_earned = v8.total_earned + v7;
                                    v8.total_paid = v8.total_paid + v7;
                                    0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x930c7f9155da8239d928358abb8b40627f44bdc0be7b3a5a34b3b5e428fe3086::voultron_treasury::remove_from_treasury<T1, T0>(arg4, arg5, arg6, v7, arg12), v1);
                                };
                                let v9 = ReferralAccruedEvent{
                                    referrer      : v1,
                                    referee       : arg8,
                                    stake_amount  : 0,
                                    amount_earned : v7,
                                    timestamp     : v6,
                                    game          : arg10,
                                };
                                0x2::event::emit<ReferralAccruedEvent>(v9);
                                let v10 = ReferralPaidEvent{
                                    referrer  : v1,
                                    referee   : arg8,
                                    amount    : v7,
                                    timestamp : v6,
                                    game      : arg10,
                                };
                                0x2::event::emit<ReferralPaidEvent>(v10);
                            };
                        };
                    };
                };
            } else if (!0x2::table::contains<address, bool>(&arg0.referee_first_stake_recorded, arg8) || *0x2::table::borrow<address, bool>(&arg0.referee_first_stake_recorded, arg8) == false) {
                if (!0x2::table::contains<address, bool>(&arg0.referee_first_stake_recorded, arg8)) {
                    0x2::table::add<address, bool>(&mut arg0.referee_first_stake_recorded, arg8, true);
                } else {
                    *0x2::table::borrow_mut<address, bool>(&mut arg0.referee_first_stake_recorded, arg8) = true;
                };
                let v11 = (((arg7 as u128) * (0x14df736178104ac1f04525d58192a82eb390bba2422a79a69ac47046619e9d1c::config::get_referral_rate(arg2, arg10) as u128) / 100) as u64);
                if (v11 > 0) {
                    let v12 = get_or_create_stats(arg0, v1);
                    v12.total_earned = v12.total_earned + v11;
                    v12.total_paid = v12.total_paid + v11;
                    v12.users_count = v12.users_count + 1;
                    0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x930c7f9155da8239d928358abb8b40627f44bdc0be7b3a5a34b3b5e428fe3086::voultron_treasury::remove_from_treasury<T1, T0>(arg4, arg5, arg6, v11, arg12), v1);
                    let v13 = ReferralAccruedEvent{
                        referrer      : v1,
                        referee       : arg8,
                        stake_amount  : 0,
                        amount_earned : v11,
                        timestamp     : 0x2::clock::timestamp_ms(arg11),
                        game          : arg10,
                    };
                    0x2::event::emit<ReferralAccruedEvent>(v13);
                    let v14 = ReferralPaidEvent{
                        referrer  : v1,
                        referee   : arg8,
                        amount    : v11,
                        timestamp : 0x2::clock::timestamp_ms(arg11),
                        game      : arg10,
                    };
                    0x2::event::emit<ReferralPaidEvent>(v14);
                };
            };
        };
    }

    public fun bind_referral_code(arg0: &0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::Admins, arg1: &mut Referrals, arg2: &0xe59e5e4471b3878b360f9ed7b5551aa67a03a4a6096732f3238aba19ed27725::creators::Creators, arg3: &0x14df736178104ac1f04525d58192a82eb390bba2422a79a69ac47046619e9d1c::config::PlayerConfig, arg4: &mut 0x14df736178104ac1f04525d58192a82eb390bba2422a79a69ac47046619e9d1c::voultron_players::VoultronPlayer, arg5: &0x14df736178104ac1f04525d58192a82eb390bba2422a79a69ac47046619e9d1c::voultron_players::WhitelistedPlayerModules, arg6: &0xdec974fe362e058b64b8215886ec45c17560e4d67da7133e75bb49f094b055ac::award_points::AwardPointsWhitelistedModule, arg7: &mut 0x2::token::TokenPolicy<0xdec974fe362e058b64b8215886ec45c17560e4d67da7133e75bb49f094b055ac::voultron_points::VOULTRON_POINTS>, arg8: &mut 0xdec974fe362e058b64b8215886ec45c17560e4d67da7133e75bb49f094b055ac::voultron_points::PointsTreasuryCapOwner, arg9: 0x1::string::String, arg10: address, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::check_admin(arg0, arg12);
        if (0x2::table::contains<address, address>(&arg1.referee_to_referrer, arg10)) {
            return
        };
        let v0 = 0xe59e5e4471b3878b360f9ed7b5551aa67a03a4a6096732f3238aba19ed27725::creators::resolve_code(arg2, arg9);
        if (0x1::option::is_some<address>(&v0)) {
            let v1 = *0x1::option::borrow<address>(&v0);
            if (v1 != arg10) {
                set_referrer(arg1, v1, false, arg10, true, arg11);
                let v2 = 0x14df736178104ac1f04525d58192a82eb390bba2422a79a69ac47046619e9d1c::config::get_game_param(arg3, 0x1::string::utf8(b"Referrals::WelcomeBonusPoints"));
                let v3 = if (v2 > 0) {
                    v2
                } else {
                    500000000000
                };
                let v4 = FHCap{dummy_field: false};
                0x14df736178104ac1f04525d58192a82eb390bba2422a79a69ac47046619e9d1c::voultron_players::add_points_direct<FHCap>(arg4, arg5, arg6, arg7, arg8, v4, v3, arg11, arg12);
            };
        };
    }

    public fun bind_referrer_address(arg0: &mut Referrals, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        set_referrer(arg0, arg1, false, 0x2::tx_context::sender(arg3), false, arg2);
    }

    fun get_or_create_stats(arg0: &mut Referrals, arg1: address) : &mut Stats {
        if (!0x2::table::contains<address, Stats>(&arg0.referrer_stats, arg1)) {
            let v0 = Stats{
                users_count  : 0,
                total_earned : 0,
                total_paid   : 0,
            };
            0x2::table::add<address, Stats>(&mut arg0.referrer_stats, arg1, v0);
        };
        0x2::table::borrow_mut<address, Stats>(&mut arg0.referrer_stats, arg1)
    }

    public fun get_referrer_for_referee(arg0: &Referrals, arg1: address) : 0x1::option::Option<address> {
        if (0x2::table::contains<address, address>(&arg0.referee_to_referrer, arg1)) {
            0x1::option::some<address>(*0x2::table::borrow<address, address>(&arg0.referee_to_referrer, arg1))
        } else {
            0x1::option::none<address>()
        }
    }

    public fun get_referrer_stats(arg0: &Referrals, arg1: address) : 0x1::option::Option<Stats> {
        if (0x2::table::contains<address, Stats>(&arg0.referrer_stats, arg1)) {
            0x1::option::some<Stats>(*0x2::table::borrow<address, Stats>(&arg0.referrer_stats, arg1))
        } else {
            0x1::option::none<Stats>()
        }
    }

    fun init(arg0: REFERRALS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Referrals{
            id                           : 0x2::object::new(arg1),
            referrer_stats               : 0x2::table::new<address, Stats>(arg1),
            referee_to_referrer          : 0x2::table::new<address, address>(arg1),
            referee_first_stake_recorded : 0x2::table::new<address, bool>(arg1),
            referee_is_creator_referral  : 0x2::table::new<address, bool>(arg1),
        };
        0x2::transfer::public_share_object<Referrals>(v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<REFERRALS>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun set_referrer(arg0: &mut Referrals, arg1: address, arg2: bool, arg3: address, arg4: bool, arg5: &0x2::clock::Clock) {
        assert!(arg3 != arg1, 0);
        if (!0x2::table::contains<address, address>(&arg0.referee_to_referrer, arg3) && arg2 == false) {
            0x2::table::add<address, address>(&mut arg0.referee_to_referrer, arg3, arg1);
            0x2::table::add<address, bool>(&mut arg0.referee_first_stake_recorded, arg3, false);
            0x2::table::add<address, bool>(&mut arg0.referee_is_creator_referral, arg3, arg4);
            let v0 = ReferrerSetEvent{
                referee   : arg3,
                referrer  : arg1,
                timestamp : 0x2::clock::timestamp_ms(arg5),
            };
            0x2::event::emit<ReferrerSetEvent>(v0);
        };
    }

    // decompiled from Move bytecode v6
}

