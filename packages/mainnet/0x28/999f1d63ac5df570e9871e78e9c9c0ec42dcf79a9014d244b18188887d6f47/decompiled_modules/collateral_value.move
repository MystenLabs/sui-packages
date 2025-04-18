module 0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::collateral_value {
    public fun collaterals_value_usd_for_borrow(arg0: &0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::obligation::Obligation, arg1: &0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::market::Market, arg2: &0xe6deefcaa0faa43c407eb03fe0031d579d760556ebff6bed9571a5398fb38212::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x4ab1501220d2b9af2a3bdbb0c170f09dc70cba0014c1c4e48fdf42d246c2b7b4::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::obligation::collateral_types(arg0);
        let v1 = 0xc9f1a5fbbc568db38446e25ef0cbf78db60a47def1d1e2ee771f63cbcfd7393d::fixed_point32_empower::zero();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v2);
            v1 = 0xc9f1a5fbbc568db38446e25ef0cbf78db60a47def1d1e2ee771f63cbcfd7393d::fixed_point32_empower::add(v1, 0xc9f1a5fbbc568db38446e25ef0cbf78db60a47def1d1e2ee771f63cbcfd7393d::fixed_point32_empower::mul(0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::value_calculator::usd_value(0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::price::get_price(arg3, v3, arg4), 0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::obligation::collateral(arg0, v3), 0xe6deefcaa0faa43c407eb03fe0031d579d760556ebff6bed9571a5398fb38212::coin_decimals_registry::decimals(arg2, v3)), 0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::risk_model::collateral_factor(0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::market::risk_model(arg1, v3))));
            v2 = v2 + 1;
        };
        v1
    }

    public fun collaterals_value_usd_for_liquidation(arg0: &0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::obligation::Obligation, arg1: &0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::market::Market, arg2: &0xe6deefcaa0faa43c407eb03fe0031d579d760556ebff6bed9571a5398fb38212::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x4ab1501220d2b9af2a3bdbb0c170f09dc70cba0014c1c4e48fdf42d246c2b7b4::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::obligation::collateral_types(arg0);
        let v1 = 0xc9f1a5fbbc568db38446e25ef0cbf78db60a47def1d1e2ee771f63cbcfd7393d::fixed_point32_empower::zero();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v2);
            v1 = 0xc9f1a5fbbc568db38446e25ef0cbf78db60a47def1d1e2ee771f63cbcfd7393d::fixed_point32_empower::add(v1, 0xc9f1a5fbbc568db38446e25ef0cbf78db60a47def1d1e2ee771f63cbcfd7393d::fixed_point32_empower::mul(0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::value_calculator::usd_value(0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::price::get_price(arg3, v3, arg4), 0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::obligation::collateral(arg0, v3), 0xe6deefcaa0faa43c407eb03fe0031d579d760556ebff6bed9571a5398fb38212::coin_decimals_registry::decimals(arg2, v3)), 0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::risk_model::liq_factor(0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::market::risk_model(arg1, v3))));
            v2 = v2 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

