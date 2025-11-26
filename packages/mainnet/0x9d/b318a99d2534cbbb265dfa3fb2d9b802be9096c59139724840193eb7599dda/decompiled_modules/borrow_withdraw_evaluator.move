module 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::borrow_withdraw_evaluator {
    public fun available_borrow_amount_in_usd(arg0: &0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::obligation::Obligation, arg1: &0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::market::Market, arg2: &0x67af3fccd222594f518bcf53b48fc84d1e15b168d9e8329ff3540c03e41874ef::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x8a50c55c1208cc2ef7741b8dd7656bf6acc25ae6f2ce99a298f9a5c83e08e285::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::collateral_value::collaterals_value_usd_for_borrow(arg0, arg1, arg2, arg3, arg4);
        let v1 = 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::debt_value::debts_value_usd(arg0, arg2, arg3, arg4);
        if (0x5e16d2db1a6a1b4df6dd48441e407ca1700ff237f142ec6c126e566cca133499::fixed_point32_empower::gt(v0, v1)) {
            0x5e16d2db1a6a1b4df6dd48441e407ca1700ff237f142ec6c126e566cca133499::fixed_point32_empower::sub(v0, v1)
        } else {
            0x5e16d2db1a6a1b4df6dd48441e407ca1700ff237f142ec6c126e566cca133499::fixed_point32_empower::zero()
        }
    }

    public fun max_borrow_amount<T0>(arg0: &0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::obligation::Obligation, arg1: &0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::market::Market, arg2: &0x67af3fccd222594f518bcf53b48fc84d1e15b168d9e8329ff3540c03e41874ef::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x8a50c55c1208cc2ef7741b8dd7656bf6acc25ae6f2ce99a298f9a5c83e08e285::x_oracle::XOracle, arg4: &0x2::clock::Clock) : u64 {
        let v0 = available_borrow_amount_in_usd(arg0, arg1, arg2, arg3, arg4);
        if (0x5e16d2db1a6a1b4df6dd48441e407ca1700ff237f142ec6c126e566cca133499::fixed_point32_empower::gt(v0, 0x5e16d2db1a6a1b4df6dd48441e407ca1700ff237f142ec6c126e566cca133499::fixed_point32_empower::zero())) {
            let v2 = 0x1::type_name::get<T0>();
            0x1::fixed_point32::multiply_u64(0x2::math::pow(10, 0x67af3fccd222594f518bcf53b48fc84d1e15b168d9e8329ff3540c03e41874ef::coin_decimals_registry::decimals(arg2, v2)), 0x5e16d2db1a6a1b4df6dd48441e407ca1700ff237f142ec6c126e566cca133499::fixed_point32_empower::div(v0, 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::price::get_price(arg3, v2, arg4)))
        } else {
            0
        }
    }

    public fun max_withdraw_amount<T0>(arg0: &0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::obligation::Obligation, arg1: &0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::market::Market, arg2: &0x67af3fccd222594f518bcf53b48fc84d1e15b168d9e8329ff3540c03e41874ef::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x8a50c55c1208cc2ef7741b8dd7656bf6acc25ae6f2ce99a298f9a5c83e08e285::x_oracle::XOracle, arg4: &0x2::clock::Clock) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (0x1::fixed_point32::is_zero(0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::debt_value::debts_value_usd(arg0, arg2, arg3, arg4))) {
            return 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::obligation::collateral(arg0, v0)
        };
        let v1 = available_borrow_amount_in_usd(arg0, arg1, arg2, arg3, arg4);
        let v2 = 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::risk_model::collateral_factor(0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::market::risk_model(arg1, v0));
        if (0x1::fixed_point32::is_zero(v2)) {
            return if (!0x1::fixed_point32::is_zero(v1)) {
                0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::obligation::collateral(arg0, v0)
            } else {
                0
            }
        };
        0x2::math::min(0x1::fixed_point32::divide_u64(0x1::fixed_point32::multiply_u64(0x2::math::pow(10, 0x67af3fccd222594f518bcf53b48fc84d1e15b168d9e8329ff3540c03e41874ef::coin_decimals_registry::decimals(arg2, v0)), 0x5e16d2db1a6a1b4df6dd48441e407ca1700ff237f142ec6c126e566cca133499::fixed_point32_empower::div(v1, 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::price::get_price(arg3, v0, arg4))), v2), 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::obligation::collateral(arg0, v0))
    }

    // decompiled from Move bytecode v6
}

