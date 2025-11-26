module 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::withdraw_collateral {
    struct CollateralWithdrawEvent has copy, drop {
        taker: address,
        obligation: 0x2::object::ID,
        withdraw_asset: 0x1::type_name::TypeName,
        withdraw_amount: u64,
    }

    public fun withdraw_collateral<T0>(arg0: &0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::version::Version, arg1: &mut 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::obligation::Obligation, arg2: &0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::obligation::ObligationKey, arg3: &mut 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::market::Market, arg4: &0x67af3fccd222594f518bcf53b48fc84d1e15b168d9e8329ff3540c03e41874ef::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0x8a50c55c1208cc2ef7741b8dd7656bf6acc25ae6f2ce99a298f9a5c83e08e285::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(!0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::market::is_paused(arg3), 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::error::market_paused_error());
        0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::version::assert_current_version(arg0);
        assert!(arg5 > 0, 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::error::zero_amount_error());
        assert!(0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::obligation::withdraw_collateral_locked(arg1) == false, 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::error::obligation_locked());
        0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::obligation::assert_key_match(arg1, arg2);
        0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::market::handle_withdraw_collateral<T0>(arg3, arg5, 0x2::clock::timestamp_ms(arg7) / 1000);
        0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::obligation::accrue_interests_and_rewards(arg1, arg3);
        assert!(arg5 <= 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::borrow_withdraw_evaluator::max_withdraw_amount<T0>(arg1, arg3, arg4, arg6, arg7), 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::error::withdraw_collateral_too_much_error());
        let v0 = 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::obligation::withdraw_collateral<T0>(arg1, arg5);
        let v1 = CollateralWithdrawEvent{
            taker           : 0x2::tx_context::sender(arg8),
            obligation      : 0x2::object::id<0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::obligation::Obligation>(arg1),
            withdraw_asset  : 0x1::type_name::get<T0>(),
            withdraw_amount : 0x2::balance::value<T0>(&v0),
        };
        0x2::event::emit<CollateralWithdrawEvent>(v1);
        0x2::coin::from_balance<T0>(v0, arg8)
    }

    public fun withdraw_collateral_entry<T0>(arg0: &0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::version::Version, arg1: &mut 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::obligation::Obligation, arg2: &0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::obligation::ObligationKey, arg3: &mut 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::market::Market, arg4: &0x67af3fccd222594f518bcf53b48fc84d1e15b168d9e8329ff3540c03e41874ef::coin_decimals_registry::CoinDecimalsRegistry, arg5: u64, arg6: &0x8a50c55c1208cc2ef7741b8dd7656bf6acc25ae6f2ce99a298f9a5c83e08e285::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(!0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::market::is_paused(arg3), 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::error::market_paused_error());
        let v0 = withdraw_collateral<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg8));
    }

    // decompiled from Move bytecode v6
}

