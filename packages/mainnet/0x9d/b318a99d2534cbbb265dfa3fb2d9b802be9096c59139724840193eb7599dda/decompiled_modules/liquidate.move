module 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::liquidate {
    struct LiquidateEvent has copy, drop {
        liquidator: address,
        obligation: 0x2::object::ID,
        debt_type: 0x1::type_name::TypeName,
        collateral_type: 0x1::type_name::TypeName,
        repay_on_behalf: u64,
        repay_revenue: u64,
        liq_amount: u64,
        collateral_price: 0x1::fixed_point32::FixedPoint32,
        debt_price: 0x1::fixed_point32::FixedPoint32,
        timestamp: u64,
    }

    public fun liquidate<T0>(arg0: &0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::version::Version, arg1: &mut 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::obligation::Obligation, arg2: &mut 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::market::Market, arg3: 0x2::coin::Coin<0x2fb9fbacf2090c8e0387f444b3c84ca2b30b2664d966ae82ed52cb74ada6eb9b::coin_gusd::COIN_GUSD>, arg4: &0x67af3fccd222594f518bcf53b48fc84d1e15b168d9e8329ff3540c03e41874ef::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x8a50c55c1208cc2ef7741b8dd7656bf6acc25ae6f2ce99a298f9a5c83e08e285::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2fb9fbacf2090c8e0387f444b3c84ca2b30b2664d966ae82ed52cb74ada6eb9b::coin_gusd::COIN_GUSD>, 0x2::coin::Coin<T0>) {
        0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::version::assert_current_version(arg0);
        assert!(0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::obligation::liquidate_locked(arg1) == false, 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::error::obligation_locked());
        assert!(0x2::coin::value<0x2fb9fbacf2090c8e0387f444b3c84ca2b30b2664d966ae82ed52cb74ada6eb9b::coin_gusd::COIN_GUSD>(&arg3) > 0, 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::error::zero_amount_error());
        let v0 = 0x2::coin::into_balance<0x2fb9fbacf2090c8e0387f444b3c84ca2b30b2664d966ae82ed52cb74ada6eb9b::coin_gusd::COIN_GUSD>(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg6) / 1000;
        0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::market::accrue_all_interests(arg2, v1);
        0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::obligation::accrue_interests_and_rewards(arg1, arg2);
        let (v2, v3, v4) = 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::liquidation_evaluator::liquidation_amounts<0x2fb9fbacf2090c8e0387f444b3c84ca2b30b2664d966ae82ed52cb74ada6eb9b::coin_gusd::COIN_GUSD, T0>(arg1, arg2, arg4, 0x2::balance::value<0x2fb9fbacf2090c8e0387f444b3c84ca2b30b2664d966ae82ed52cb74ada6eb9b::coin_gusd::COIN_GUSD>(&v0), arg5, arg6);
        assert!(v4 > 0, 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::error::unable_to_liquidate_error());
        0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::obligation::decrease_debt(arg1, 0x1::type_name::get<0x2fb9fbacf2090c8e0387f444b3c84ca2b30b2664d966ae82ed52cb74ada6eb9b::coin_gusd::COIN_GUSD>(), v2);
        0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::market::handle_liquidation<T0>(arg2, 0x2::balance::split<0x2fb9fbacf2090c8e0387f444b3c84ca2b30b2664d966ae82ed52cb74ada6eb9b::coin_gusd::COIN_GUSD>(&mut v0, v2), 0x2::balance::split<0x2fb9fbacf2090c8e0387f444b3c84ca2b30b2664d966ae82ed52cb74ada6eb9b::coin_gusd::COIN_GUSD>(&mut v0, v3), v4, arg7);
        let v5 = LiquidateEvent{
            liquidator       : 0x2::tx_context::sender(arg7),
            obligation       : 0x2::object::id<0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::obligation::Obligation>(arg1),
            debt_type        : 0x1::type_name::get<0x2fb9fbacf2090c8e0387f444b3c84ca2b30b2664d966ae82ed52cb74ada6eb9b::coin_gusd::COIN_GUSD>(),
            collateral_type  : 0x1::type_name::get<T0>(),
            repay_on_behalf  : v2,
            repay_revenue    : v3,
            liq_amount       : v4,
            collateral_price : 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::price::get_price(arg5, 0x1::type_name::get<T0>(), arg6),
            debt_price       : 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::price::get_price(arg5, 0x1::type_name::get<0x2fb9fbacf2090c8e0387f444b3c84ca2b30b2664d966ae82ed52cb74ada6eb9b::coin_gusd::COIN_GUSD>(), arg6),
            timestamp        : v1,
        };
        0x2::event::emit<LiquidateEvent>(v5);
        (0x2::coin::from_balance<0x2fb9fbacf2090c8e0387f444b3c84ca2b30b2664d966ae82ed52cb74ada6eb9b::coin_gusd::COIN_GUSD>(v0, arg7), 0x2::coin::from_balance<T0>(0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::obligation::withdraw_collateral<T0>(arg1, v4), arg7))
    }

    public fun liquidate_entry<T0>(arg0: &0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::version::Version, arg1: &mut 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::obligation::Obligation, arg2: &mut 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::market::Market, arg3: 0x2::coin::Coin<0x2fb9fbacf2090c8e0387f444b3c84ca2b30b2664d966ae82ed52cb74ada6eb9b::coin_gusd::COIN_GUSD>, arg4: &0x67af3fccd222594f518bcf53b48fc84d1e15b168d9e8329ff3540c03e41874ef::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x8a50c55c1208cc2ef7741b8dd7656bf6acc25ae6f2ce99a298f9a5c83e08e285::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = liquidate<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2fb9fbacf2090c8e0387f444b3c84ca2b30b2664d966ae82ed52cb74ada6eb9b::coin_gusd::COIN_GUSD>>(v0, 0x2::tx_context::sender(arg7));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg7));
    }

    // decompiled from Move bytecode v6
}

