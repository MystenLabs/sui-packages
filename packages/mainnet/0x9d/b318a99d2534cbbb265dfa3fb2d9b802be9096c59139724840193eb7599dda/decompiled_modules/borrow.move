module 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::borrow {
    struct BorrowEvent has copy, drop {
        borrower: address,
        obligation: 0x2::object::ID,
        amount: u64,
        borrow_fee: u64,
        time: u64,
    }

    public fun borrow(arg0: &0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::version::Version, arg1: &mut 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::obligation::Obligation, arg2: &0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::obligation::ObligationKey, arg3: &mut 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::market::Market, arg4: &0x67af3fccd222594f518bcf53b48fc84d1e15b168d9e8329ff3540c03e41874ef::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0x8a50c55c1208cc2ef7741b8dd7656bf6acc25ae6f2ce99a298f9a5c83e08e285::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2fb9fbacf2090c8e0387f444b3c84ca2b30b2664d966ae82ed52cb74ada6eb9b::coin_gusd::COIN_GUSD> {
        0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::version::assert_current_version(arg0);
        assert!(!0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::market::is_paused(arg3), 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::error::market_paused_error());
        borrow_internal(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public entry fun borrow_entry(arg0: &0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::version::Version, arg1: &mut 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::obligation::Obligation, arg2: &0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::obligation::ObligationKey, arg3: &mut 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::market::Market, arg4: &0x67af3fccd222594f518bcf53b48fc84d1e15b168d9e8329ff3540c03e41874ef::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0x8a50c55c1208cc2ef7741b8dd7656bf6acc25ae6f2ce99a298f9a5c83e08e285::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::market::is_paused(arg3), 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::error::market_paused_error());
        let v0 = borrow(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2fb9fbacf2090c8e0387f444b3c84ca2b30b2664d966ae82ed52cb74ada6eb9b::coin_gusd::COIN_GUSD>>(v0, 0x2::tx_context::sender(arg8));
    }

    fun borrow_internal(arg0: &mut 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::obligation::Obligation, arg1: &0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::obligation::ObligationKey, arg2: &mut 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::market::Market, arg3: &0x67af3fccd222594f518bcf53b48fc84d1e15b168d9e8329ff3540c03e41874ef::coin_decimals_registry::CoinDecimalsRegistry, arg4: u64, arg5: &0x8a50c55c1208cc2ef7741b8dd7656bf6acc25ae6f2ce99a298f9a5c83e08e285::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2fb9fbacf2090c8e0387f444b3c84ca2b30b2664d966ae82ed52cb74ada6eb9b::coin_gusd::COIN_GUSD> {
        assert!(0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::obligation::borrow_locked(arg0) == false, 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::error::obligation_locked());
        let v0 = 0x1::type_name::get<0x2fb9fbacf2090c8e0387f444b3c84ca2b30b2664d966ae82ed52cb74ada6eb9b::coin_gusd::COIN_GUSD>();
        let v1 = 0x2::clock::timestamp_ms(arg6) / 1000;
        0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::obligation::assert_key_match(arg0, arg1);
        let v2 = 0x1::fixed_point32::multiply_u64(arg4, *0x2::dynamic_field::borrow<0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::market_dynamic_keys::BorrowFeeKey, 0x1::fixed_point32::FixedPoint32>(0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::market::uid(arg2), 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::market_dynamic_keys::borrow_fee_key(v0)));
        assert!(arg4 >= 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::interest_model::min_borrow_amount(0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::market::interest_model(arg2, v0)) + v2, 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::error::borrow_too_small_error());
        assert!((0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::market::total_global_debt(arg2, v0) as u128) + (arg4 as u128) <= *0x2::dynamic_field::borrow<0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::market_dynamic_keys::BorrowLimitKey, u128>(0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::market::uid(arg2), 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::market_dynamic_keys::borrow_limit_key(v0)), 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::error::borrow_limit_reached_error());
        0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::market::handle_outflow<0x2fb9fbacf2090c8e0387f444b3c84ca2b30b2664d966ae82ed52cb74ada6eb9b::coin_gusd::COIN_GUSD>(arg2, arg4, v1);
        let v3 = 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::market::handle_borrow(arg2, arg4, v1, arg7);
        0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::obligation::init_debt(arg0, arg2, v0);
        0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::obligation::accrue_interests_and_rewards(arg0, arg2);
        assert!(arg4 <= 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::borrow_withdraw_evaluator::max_borrow_amount<0x2fb9fbacf2090c8e0387f444b3c84ca2b30b2664d966ae82ed52cb74ada6eb9b::coin_gusd::COIN_GUSD>(arg0, arg2, arg3, arg5, arg6), 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::error::borrow_too_much_error());
        0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::obligation::increase_debt(arg0, v0, arg4);
        assert!(0x5e16d2db1a6a1b4df6dd48441e407ca1700ff237f142ec6c126e566cca133499::fixed_point32_empower::gt(0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::collateral_value::collaterals_value_usd_for_borrow(arg0, arg2, arg3, arg5, arg6), 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::debt_value::debts_value_usd(arg0, arg3, arg5, arg6)), 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::error::borrow_too_much_error());
        0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::market::add_borrow_fee<0x2fb9fbacf2090c8e0387f444b3c84ca2b30b2664d966ae82ed52cb74ada6eb9b::coin_gusd::COIN_GUSD>(arg2, 0x2::coin::into_balance<0x2fb9fbacf2090c8e0387f444b3c84ca2b30b2664d966ae82ed52cb74ada6eb9b::coin_gusd::COIN_GUSD>(0x2::coin::split<0x2fb9fbacf2090c8e0387f444b3c84ca2b30b2664d966ae82ed52cb74ada6eb9b::coin_gusd::COIN_GUSD>(&mut v3, v2, arg7)), arg7);
        let v4 = BorrowEvent{
            borrower   : 0x2::tx_context::sender(arg7),
            obligation : 0x2::object::id<0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::obligation::Obligation>(arg0),
            amount     : arg4,
            borrow_fee : v2,
            time       : v1,
        };
        0x2::event::emit<BorrowEvent>(v4);
        v3
    }

    // decompiled from Move bytecode v6
}

