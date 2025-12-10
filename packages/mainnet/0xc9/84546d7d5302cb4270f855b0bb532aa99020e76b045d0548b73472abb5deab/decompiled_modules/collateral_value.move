module 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::collateral_value {
    public fun collaterals_value_usd_for_borrow(arg0: &0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::obligation::Obligation, arg1: &0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::market::Market, arg2: &0x550df640624390b2f1c6d012321a9857acfce2da82a04e41454358b9acfc4a60::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::obligation::collateral_types(arg0);
        let v1 = 0xea7eb073880686001519321fa66299ef645d1414c3d7c4fb7c1c55a10d84ab6::fixed_point32_empower::zero();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v2);
            v1 = 0xea7eb073880686001519321fa66299ef645d1414c3d7c4fb7c1c55a10d84ab6::fixed_point32_empower::add(v1, 0xea7eb073880686001519321fa66299ef645d1414c3d7c4fb7c1c55a10d84ab6::fixed_point32_empower::mul(0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::value_calculator::usd_value(0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::price::get_price(arg3, v3, arg4), 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::obligation::collateral(arg0, v3), 0x550df640624390b2f1c6d012321a9857acfce2da82a04e41454358b9acfc4a60::coin_decimals_registry::decimals(arg2, v3)), 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::risk_model::collateral_factor(0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::market::risk_model(arg1, v3))));
            v2 = v2 + 1;
        };
        v1
    }

    public fun collaterals_value_usd_for_liquidation(arg0: &0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::obligation::Obligation, arg1: &0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::market::Market, arg2: &0x550df640624390b2f1c6d012321a9857acfce2da82a04e41454358b9acfc4a60::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::obligation::collateral_types(arg0);
        let v1 = 0xea7eb073880686001519321fa66299ef645d1414c3d7c4fb7c1c55a10d84ab6::fixed_point32_empower::zero();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v2);
            v1 = 0xea7eb073880686001519321fa66299ef645d1414c3d7c4fb7c1c55a10d84ab6::fixed_point32_empower::add(v1, 0xea7eb073880686001519321fa66299ef645d1414c3d7c4fb7c1c55a10d84ab6::fixed_point32_empower::mul(0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::value_calculator::usd_value(0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::price::get_price(arg3, v3, arg4), 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::obligation::collateral(arg0, v3), 0x550df640624390b2f1c6d012321a9857acfce2da82a04e41454358b9acfc4a60::coin_decimals_registry::decimals(arg2, v3)), 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::risk_model::liq_factor(0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::market::risk_model(arg1, v3))));
            v2 = v2 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

