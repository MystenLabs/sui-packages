module 0xeffccecb0063c0b6d78c021ca7ea32e582f30ced9749d64167d7c55c5974f99f::steamm_graduation {
    struct SteammGraduationCompletedEvent has copy, drop {
        coin_address: address,
        graduation_time: u64,
        target_price: u64,
        actual_initial_price: u64,
        price_difference_bps: u64,
        token_utilization_bps: u64,
        steamm_pool_sui_liquidity: u64,
        steamm_pool_token_liquidity: u64,
        total_supply_in_circulation: u64,
        pool_id: address,
        market_cap: u64,
    }

    fun calculate_steamm_actual_amm_price(arg0: u64, arg1: u64, arg2: u8) : u64 {
        if (arg1 == 0) {
            return 0
        };
        0xeffccecb0063c0b6d78c021ca7ea32e582f30ced9749d64167d7c55c5974f99f::utils::as_u64(0xeffccecb0063c0b6d78c021ca7ea32e582f30ced9749d64167d7c55c5974f99f::utils::div(0xeffccecb0063c0b6d78c021ca7ea32e582f30ced9749d64167d7c55c5974f99f::utils::mul(0xeffccecb0063c0b6d78c021ca7ea32e582f30ced9749d64167d7c55c5974f99f::utils::from_u64(arg0), 0xeffccecb0063c0b6d78c021ca7ea32e582f30ced9749d64167d7c55c5974f99f::utils::from_u64(0xeffccecb0063c0b6d78c021ca7ea32e582f30ced9749d64167d7c55c5974f99f::utils::as_u64(0xeffccecb0063c0b6d78c021ca7ea32e582f30ced9749d64167d7c55c5974f99f::utils::pow(0xeffccecb0063c0b6d78c021ca7ea32e582f30ced9749d64167d7c55c5974f99f::utils::from_u64(10), (arg2 as u64))))), 0xeffccecb0063c0b6d78c021ca7ea32e582f30ced9749d64167d7c55c5974f99f::utils::from_u64(arg1)))
    }

    fun calculate_steamm_price_difference_bps(arg0: u64, arg1: u64) : u64 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = if (arg1 > arg0) {
            arg1 - arg0
        } else {
            arg0 - arg1
        };
        0xeffccecb0063c0b6d78c021ca7ea32e582f30ced9749d64167d7c55c5974f99f::utils::as_u64(0xeffccecb0063c0b6d78c021ca7ea32e582f30ced9749d64167d7c55c5974f99f::utils::div(0xeffccecb0063c0b6d78c021ca7ea32e582f30ced9749d64167d7c55c5974f99f::utils::mul(0xeffccecb0063c0b6d78c021ca7ea32e582f30ced9749d64167d7c55c5974f99f::utils::from_u64(v0), 0xeffccecb0063c0b6d78c021ca7ea32e582f30ced9749d64167d7c55c5974f99f::utils::from_u64(10000)), 0xeffccecb0063c0b6d78c021ca7ea32e582f30ced9749d64167d7c55c5974f99f::utils::from_u64(arg0)))
    }

    public fun execute_graduation<T0, T1: drop>(arg0: &mut 0xeffccecb0063c0b6d78c021ca7ea32e582f30ced9749d64167d7c55c5974f99f::token_launcher::Launchpad, arg1: &mut 0x2::coin::TreasuryCap<T0>, arg2: 0x2::balance::Balance<0x2::sui::SUI>, arg3: 0x2::balance::Balance<T0>, arg4: u64, arg5: address, arg6: 0x1::string::String, arg7: u64, arg8: u64, arg9: bool, arg10: u64, arg11: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::registry::Registry, arg12: &0x2::coin::CoinMetadata<0x2::sui::SUI>, arg13: &0x2::coin::CoinMetadata<T0>, arg14: 0x2::coin::TreasuryCap<T1>, arg15: 0x2::coin::CoinMetadata<T1>, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) : (u64, u64, address) {
        assert!(!arg9, 0);
        assert!(0xeffccecb0063c0b6d78c021ca7ea32e582f30ced9749d64167d7c55c5974f99f::graduation::check_graduation_eligibility(arg0, arg10, arg9), 1);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg2);
        let v1 = 0xeffccecb0063c0b6d78c021ca7ea32e582f30ced9749d64167d7c55c5974f99f::token_launcher::get_token_decimals(arg0);
        let v2 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::new<0x2::sui::SUI, T0, T1>(arg11, 30, 0, arg12, arg13, &mut arg15, arg14, arg17);
        let v3 = 0x2::object::id<0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<0x2::sui::SUI, T0, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T1>>(&v2);
        let v4 = 0x2::object::id_to_address(&v3);
        let v5 = 0x2::coin::from_balance<0x2::sui::SUI>(arg2, arg17);
        let v6 = 0x2::coin::from_balance<T0>(arg3, arg17);
        let (v7, _) = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::deposit_liquidity<0x2::sui::SUI, T0, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T1>(&mut v2, &mut v5, &mut v6, v0, arg4, arg17);
        0x2::transfer::public_share_object<0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<0x2::sui::SUI, T0, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T1>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v7, @0x0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T1>>(arg15);
        if (0x2::coin::value<0x2::sui::SUI>(&v5) > 0) {
            0xeffccecb0063c0b6d78c021ca7ea32e582f30ced9749d64167d7c55c5974f99f::token_launcher::add_to_treasury(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(v5));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v5);
        };
        if (0x2::coin::value<T0>(&v6) > 0) {
            0x2::coin::burn<T0>(arg1, v6);
        } else {
            0x2::coin::destroy_zero<T0>(v6);
        };
        let v9 = calculate_steamm_actual_amm_price(v0, arg4, v1);
        let v10 = SteammGraduationCompletedEvent{
            coin_address                : arg5,
            graduation_time             : 0x2::clock::timestamp_ms(arg16),
            target_price                : arg7,
            actual_initial_price        : v9,
            price_difference_bps        : calculate_steamm_price_difference_bps(arg7, v9),
            token_utilization_bps       : 10000,
            steamm_pool_sui_liquidity   : v0,
            steamm_pool_token_liquidity : arg4,
            total_supply_in_circulation : arg8,
            pool_id                     : v4,
            market_cap                  : 0xeffccecb0063c0b6d78c021ca7ea32e582f30ced9749d64167d7c55c5974f99f::utils::as_u64(0xeffccecb0063c0b6d78c021ca7ea32e582f30ced9749d64167d7c55c5974f99f::utils::mul(0xeffccecb0063c0b6d78c021ca7ea32e582f30ced9749d64167d7c55c5974f99f::utils::from_u64(arg7), 0xeffccecb0063c0b6d78c021ca7ea32e582f30ced9749d64167d7c55c5974f99f::utils::from_u64(0x2::coin::total_supply<T0>(arg1) / 0xeffccecb0063c0b6d78c021ca7ea32e582f30ced9749d64167d7c55c5974f99f::utils::as_u64(0xeffccecb0063c0b6d78c021ca7ea32e582f30ced9749d64167d7c55c5974f99f::utils::pow(0xeffccecb0063c0b6d78c021ca7ea32e582f30ced9749d64167d7c55c5974f99f::utils::from_u64(10), (v1 as u64)))))),
        };
        0x2::event::emit<SteammGraduationCompletedEvent>(v10);
        (v0, arg4, v4)
    }

    public fun execute_graduation_v2<T0, T1, T2: drop, T3: drop, T4: drop>(arg0: &mut 0xeffccecb0063c0b6d78c021ca7ea32e582f30ced9749d64167d7c55c5974f99f::token_launcher::Launchpad, arg1: &mut 0x2::coin::TreasuryCap<T1>, arg2: 0x2::balance::Balance<0x2::sui::SUI>, arg3: 0x2::balance::Balance<T1>, arg4: u64, arg5: address, arg6: 0x1::string::String, arg7: u64, arg8: u64, arg9: bool, arg10: u64, arg11: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::registry::Registry, arg12: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, 0x2::sui::SUI, T3>, arg13: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T4>, arg14: &0x2::coin::CoinMetadata<T3>, arg15: &0x2::coin::CoinMetadata<T4>, arg16: 0x2::coin::TreasuryCap<T2>, arg17: 0x2::coin::CoinMetadata<T2>, arg18: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg19: &0x2::clock::Clock, arg20: &mut 0x2::tx_context::TxContext) : (u64, u64, address, 0x2::object::ID) {
        assert!(!arg9, 0);
        assert!(0xeffccecb0063c0b6d78c021ca7ea32e582f30ced9749d64167d7c55c5974f99f::graduation::check_graduation_eligibility(arg0, arg10, arg9), 1);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg2);
        let v1 = 0xeffccecb0063c0b6d78c021ca7ea32e582f30ced9749d64167d7c55c5974f99f::token_launcher::get_token_decimals(arg0);
        let v2 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::new<T3, T4, T2>(arg11, 30, 0, arg14, arg15, &mut arg17, arg16, arg20);
        let v3 = 0x2::object::id<0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T2>>(&v2);
        let v4 = 0x2::object::id_to_address(&v3);
        let v5 = 0x2::coin::from_balance<0x2::sui::SUI>(arg2, arg20);
        let v6 = 0x2::coin::from_balance<T1>(arg3, arg20);
        let v7 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::mint_btoken<T0, 0x2::sui::SUI, T3>(arg12, arg18, &mut v5, v0, arg19, arg20);
        let v8 = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::mint_btoken<T0, T1, T4>(arg13, arg18, &mut v6, arg4, arg19, arg20);
        let (v9, _) = 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::deposit_liquidity<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T2>(&mut v2, &mut v7, &mut v8, 0x2::coin::value<T3>(&v7), 0x2::coin::value<T4>(&v8), arg20);
        let v11 = 0x2::coin::value<T3>(&v7);
        if (v11 > 0) {
            0x2::coin::join<0x2::sui::SUI>(&mut v5, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::burn_btoken<T0, 0x2::sui::SUI, T3>(arg12, arg18, &mut v7, v11, arg19, arg20));
        };
        let v12 = 0x2::coin::value<T4>(&v8);
        if (v12 > 0) {
            0x2::coin::join<T1>(&mut v6, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::burn_btoken<T0, T1, T4>(arg13, arg18, &mut v8, v12, arg19, arg20));
        };
        0x2::coin::destroy_zero<T3>(v7);
        0x2::coin::destroy_zero<T4>(v8);
        0x2::transfer::public_share_object<0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T2>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v9, @0x0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T2>>(arg17);
        if (0x2::coin::value<0x2::sui::SUI>(&v5) > 0) {
            0xeffccecb0063c0b6d78c021ca7ea32e582f30ced9749d64167d7c55c5974f99f::token_launcher::add_to_treasury(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(v5));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v5);
        };
        if (0x2::coin::value<T1>(&v6) > 0) {
            0x2::coin::burn<T1>(arg1, v6);
        } else {
            0x2::coin::destroy_zero<T1>(v6);
        };
        let v13 = calculate_steamm_actual_amm_price(v0, arg4, v1);
        let v14 = SteammGraduationCompletedEvent{
            coin_address                : arg5,
            graduation_time             : 0x2::clock::timestamp_ms(arg19),
            target_price                : arg7,
            actual_initial_price        : v13,
            price_difference_bps        : calculate_steamm_price_difference_bps(arg7, v13),
            token_utilization_bps       : 10000,
            steamm_pool_sui_liquidity   : v0,
            steamm_pool_token_liquidity : arg4,
            total_supply_in_circulation : arg8,
            pool_id                     : v4,
            market_cap                  : 0xeffccecb0063c0b6d78c021ca7ea32e582f30ced9749d64167d7c55c5974f99f::utils::as_u64(0xeffccecb0063c0b6d78c021ca7ea32e582f30ced9749d64167d7c55c5974f99f::utils::mul(0xeffccecb0063c0b6d78c021ca7ea32e582f30ced9749d64167d7c55c5974f99f::utils::from_u64(arg7), 0xeffccecb0063c0b6d78c021ca7ea32e582f30ced9749d64167d7c55c5974f99f::utils::from_u64(0x2::coin::total_supply<T1>(arg1) / 0xeffccecb0063c0b6d78c021ca7ea32e582f30ced9749d64167d7c55c5974f99f::utils::as_u64(0xeffccecb0063c0b6d78c021ca7ea32e582f30ced9749d64167d7c55c5974f99f::utils::pow(0xeffccecb0063c0b6d78c021ca7ea32e582f30ced9749d64167d7c55c5974f99f::utils::from_u64(10), (v1 as u64)))))),
        };
        0x2::event::emit<SteammGraduationCompletedEvent>(v14);
        (v0, arg4, v4, 0x2::object::id<0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T4>>(arg13))
    }

    // decompiled from Move bytecode v6
}

