module 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::debt_value {
    public fun debts_value_usd(arg0: &0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::obligation::Obligation, arg1: &0x550df640624390b2f1c6d012321a9857acfce2da82a04e41454358b9acfc4a60::coin_decimals_registry::CoinDecimalsRegistry, arg2: &0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::x_oracle::XOracle, arg3: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::obligation::debt_types(arg0);
        let v1 = 0xea7eb073880686001519321fa66299ef645d1414c3d7c4fb7c1c55a10d84ab6::fixed_point32_empower::zero();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v2);
            let (v4, _, _) = 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::obligation::debt(arg0, v3);
            v1 = 0xea7eb073880686001519321fa66299ef645d1414c3d7c4fb7c1c55a10d84ab6::fixed_point32_empower::add(v1, 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::value_calculator::usd_value(0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::price::get_price(arg2, v3, arg3), v4, 0x550df640624390b2f1c6d012321a9857acfce2da82a04e41454358b9acfc4a60::coin_decimals_registry::decimals(arg1, v3)));
            v2 = v2 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

