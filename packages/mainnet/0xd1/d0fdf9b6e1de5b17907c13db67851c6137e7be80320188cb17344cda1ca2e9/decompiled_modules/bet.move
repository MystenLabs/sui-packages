module 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::bet {
    struct ClaimEvent has copy, drop, store {
        sender: address,
        epoch: u64,
        pool_name: 0x1::string::String,
        claim_coin_type: 0x1::string::String,
        claim_coin_amount: u64,
    }

    public entry fun bet<T0, T1>(arg0: &0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::version::Version, arg1: &0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::configuration::Configuration<T0>, arg2: &0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::pool::Pool<T0>, arg3: &mut 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::state::State<T0>, arg4: 0x2::coin::Coin<T1>, arg5: &0x2::coin::CoinMetadata<T1>, arg6: u8, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::version::assert_current_version(arg0);
        validate_bet_data<T0, T1>(arg1, arg2, &arg4, arg5, arg6);
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::state::current_epoch<T0>(arg3);
        let v2 = 0x2::coin::value<T1>(&arg4);
        let v3 = 0x1::string::from_ascii(0x2::coin::get_symbol<T1>(arg5));
        let v4 = 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::bet_registry::new_user_bet_key<T0>(v1, v0);
        assert!(!0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::state::contains<T0, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::bet_registry::UserBetKey<T0>, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::bet_registry::UserBet<T0, T1>>(arg3, v4), 1);
        let v5 = 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::state::borrow_mut<T0, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::RoundKey<T0>, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::RoundInfo<T0>>(arg3, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::new_round_key<T0>(v1));
        assert!(0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::bettable<T0>(v5, 0x2::clock::timestamp_ms(arg7)), 5);
        0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::update_bet_amount<T0>(v5, v2, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::pool::bet_coin_type<T0>(arg2, v3), arg6, v0);
        0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::state::add<T0, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::bet_registry::UserBetKey<T0>, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::bet_registry::UserBet<T0, T1>>(arg3, v4, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::bet_registry::new<T0, T1>(v0, arg6, v2, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::pool::name<T0>(arg2), v3, v1, arg8));
        0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::custodian::add_round_balance<T0, T1>(0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::state::borrow_mut<T0, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::custodian::CustodianKey<T0>, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::custodian::Custodian<T0, T1>>(arg3, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::custodian::new_custodian_key<T0, T1>()), v1, 0x2::coin::into_balance<T1>(arg4));
    }

    public fun claim<T0, T1, T2>(arg0: &0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::version::Version, arg1: &0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::pool::Pool<T0>, arg2: &mut 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::state::State<T0>, arg3: u64, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::version::assert_current_version(arg0);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::new_round_key<T0>(arg3);
        assert!(0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::state::contains<T0, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::RoundKey<T0>, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::RoundInfo<T0>>(arg2, v1), 6);
        let v2 = 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::state::borrow<T0, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::RoundKey<T0>, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::RoundInfo<T0>>(arg2, v1);
        let v3 = 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::bet_registry::new_user_bet_key<T0>(arg3, v0);
        assert!(0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::state::contains<T0, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::bet_registry::UserBetKey<T0>, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::bet_registry::UserBet<T0, T1>>(arg2, v3), 7);
        let v4 = 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::state::borrow<T0, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::bet_registry::UserBetKey<T0>, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::bet_registry::UserBet<T0, T1>>(arg2, v3);
        let v5 = 0x2::coin::zero<T2>(arg5);
        let v6 = 0x1::option::none<u64>();
        let v7 = 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::pool::bet_coin_info<T0>(arg1, arg4);
        let v8 = 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::utils::get_type<T2>();
        if (is_claimable<T0, T1>(v2, v4, v8)) {
            0x1::option::fill<u64>(&mut v6, (((0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::price_info::calculate_amount_value(0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::pool_price<T0>(v2, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::utils::get_type<T1>()), v7, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::bet_registry::amount<T0, T1>(v4)) as u128) * (0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::reward_amount<T0>(v2, v8) as u128) / (0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::reward_base_cal_value<T0>(v2) as u128)) as u64));
        } else if (is_refundable<T0, T1>(v2, v4, v8)) {
            assert!(v8 == 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::utils::get_type<T1>(), 10);
            0x1::option::fill<u64>(&mut v6, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::bet_registry::amount<T0, T1>(v4));
        };
        assert!(0x1::option::is_some<u64>(&v6), 9);
        let v9 = 0x1::option::extract<u64>(&mut v6);
        0x2::coin::join<T2>(&mut v5, 0x2::coin::from_balance<T2>(0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::custodian::sub_round_balance<T0, T2>(0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::state::borrow_mut<T0, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::custodian::CustodianKey<T0>, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::custodian::Custodian<T0, T2>>(arg2, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::custodian::new_custodian_key<T0, T2>()), arg3, v9), arg5));
        let v10 = ClaimEvent{
            sender            : v0,
            epoch             : arg3,
            pool_name         : 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::pool::name<T0>(arg1),
            claim_coin_type   : v8,
            claim_coin_amount : v9,
        };
        0x2::event::emit<ClaimEvent>(v10);
        0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::bet_registry::set_claimed<T0, T1>(0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::state::borrow_mut<T0, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::bet_registry::UserBetKey<T0>, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::bet_registry::UserBet<T0, T1>>(arg2, v3), v8);
        v5
    }

    fun is_claimable<T0, T1>(arg0: &0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::RoundInfo<T0>, arg1: &0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::bet_registry::UserBet<T0, T1>, arg2: 0x1::string::String) : bool {
        0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::is_finished<T0>(arg0) && 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::error_code<T0>(arg0) == 0 && !0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::bet_registry::claimed<T0, T1>(arg1, arg2) && (0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::lock_price_value<T0>(arg0) < 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::close_price_value<T0>(arg0) && 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::utils::is_bull_position(0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::bet_registry::position<T0, T1>(arg1)) || 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::lock_price_value<T0>(arg0) > 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::close_price_value<T0>(arg0) && 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::utils::is_bear_position(0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::bet_registry::position<T0, T1>(arg1)))
    }

    fun is_refundable<T0, T1>(arg0: &0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::RoundInfo<T0>, arg1: &0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::bet_registry::UserBet<T0, T1>, arg2: 0x1::string::String) : bool {
        0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::is_finished<T0>(arg0) && 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::error_code<T0>(arg0) > 0 && !0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::bet_registry::claimed<T0, T1>(arg1, arg2)
    }

    fun validate_bet_data<T0, T1>(arg0: &0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::configuration::Configuration<T0>, arg1: &0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::pool::Pool<T0>, arg2: &0x2::coin::Coin<T1>, arg3: &0x2::coin::CoinMetadata<T1>, arg4: u8) {
        assert!(0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::pool::contains_bet_coin<T0, T1>(arg1, 0x1::string::from_ascii(0x2::coin::get_symbol<T1>(arg3))), 2);
        assert!(0x2::coin::value<T1>(arg2) >= 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::configuration::min_bet_amount<T0>(arg0, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::utils::get_type<T1>()), 3);
        assert!(0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::utils::is_valid_position(arg4), 4);
    }

    // decompiled from Move bytecode v6
}

