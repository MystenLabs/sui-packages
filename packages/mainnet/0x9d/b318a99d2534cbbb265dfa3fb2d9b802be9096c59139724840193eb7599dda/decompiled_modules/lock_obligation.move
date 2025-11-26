module 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::lock_obligation {
    struct ObligationUnhealthyUnlocked has copy, drop {
        obligation: 0x2::object::ID,
        witness: 0x1::type_name::TypeName,
    }

    public fun force_unlock_unhealthy<T0: drop>(arg0: &mut 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::obligation::Obligation, arg1: &mut 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::market::Market, arg2: &0x67af3fccd222594f518bcf53b48fc84d1e15b168d9e8329ff3540c03e41874ef::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x8a50c55c1208cc2ef7741b8dd7656bf6acc25ae6f2ce99a298f9a5c83e08e285::x_oracle::XOracle, arg4: &0x2::clock::Clock, arg5: T0) {
        0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::obligation::set_unlock<T0>(arg0, arg5);
        0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::market::accrue_all_interests(arg1, 0x2::clock::timestamp_ms(arg4) / 1000);
        0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::obligation::accrue_interests_and_rewards(arg0, arg1);
        assert!(0x5e16d2db1a6a1b4df6dd48441e407ca1700ff237f142ec6c126e566cca133499::fixed_point32_empower::gt(0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::debt_value::debts_value_usd(arg0, arg2, arg3, arg4), 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::collateral_value::collaterals_value_usd_for_liquidation(arg0, arg1, arg2, arg3, arg4)), 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::error::obligation_cant_forcely_unlocked());
        let v0 = ObligationUnhealthyUnlocked{
            obligation : 0x2::object::id<0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::obligation::Obligation>(arg0),
            witness    : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<ObligationUnhealthyUnlocked>(v0);
    }

    // decompiled from Move bytecode v6
}

