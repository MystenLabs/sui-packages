module 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::collateral_value {
    public fun collaterals_value_usd_for_borrow(arg0: &0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::obligation::Obligation, arg1: &0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::market::Market, arg2: &0x67af3fccd222594f518bcf53b48fc84d1e15b168d9e8329ff3540c03e41874ef::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x8a50c55c1208cc2ef7741b8dd7656bf6acc25ae6f2ce99a298f9a5c83e08e285::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::obligation::collateral_types(arg0);
        let v1 = 0x5e16d2db1a6a1b4df6dd48441e407ca1700ff237f142ec6c126e566cca133499::fixed_point32_empower::zero();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v2);
            v1 = 0x5e16d2db1a6a1b4df6dd48441e407ca1700ff237f142ec6c126e566cca133499::fixed_point32_empower::add(v1, 0x5e16d2db1a6a1b4df6dd48441e407ca1700ff237f142ec6c126e566cca133499::fixed_point32_empower::mul(0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::value_calculator::usd_value(0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::price::get_price(arg3, v3, arg4), 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::obligation::collateral(arg0, v3), 0x67af3fccd222594f518bcf53b48fc84d1e15b168d9e8329ff3540c03e41874ef::coin_decimals_registry::decimals(arg2, v3)), 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::risk_model::collateral_factor(0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::market::risk_model(arg1, v3))));
            v2 = v2 + 1;
        };
        v1
    }

    public fun collaterals_value_usd_for_liquidation(arg0: &0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::obligation::Obligation, arg1: &0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::market::Market, arg2: &0x67af3fccd222594f518bcf53b48fc84d1e15b168d9e8329ff3540c03e41874ef::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x8a50c55c1208cc2ef7741b8dd7656bf6acc25ae6f2ce99a298f9a5c83e08e285::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::obligation::collateral_types(arg0);
        let v1 = 0x5e16d2db1a6a1b4df6dd48441e407ca1700ff237f142ec6c126e566cca133499::fixed_point32_empower::zero();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v2);
            v1 = 0x5e16d2db1a6a1b4df6dd48441e407ca1700ff237f142ec6c126e566cca133499::fixed_point32_empower::add(v1, 0x5e16d2db1a6a1b4df6dd48441e407ca1700ff237f142ec6c126e566cca133499::fixed_point32_empower::mul(0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::value_calculator::usd_value(0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::price::get_price(arg3, v3, arg4), 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::obligation::collateral(arg0, v3), 0x67af3fccd222594f518bcf53b48fc84d1e15b168d9e8329ff3540c03e41874ef::coin_decimals_registry::decimals(arg2, v3)), 0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::risk_model::liq_factor(0x9db318a99d2534cbbb265dfa3fb2d9b802be9096c59139724840193eb7599dda::market::risk_model(arg1, v3))));
            v2 = v2 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

