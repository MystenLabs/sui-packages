module 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::borrow_withdraw_evaluator {
    public fun available_borrow_amount_in_usd(arg0: &0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::obligation::Obligation, arg1: &0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::market::Market, arg2: &0x550df640624390b2f1c6d012321a9857acfce2da82a04e41454358b9acfc4a60::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::collateral_value::collaterals_value_usd_for_borrow(arg0, arg1, arg2, arg3, arg4);
        let v1 = 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::debt_value::debts_value_usd(arg0, arg2, arg3, arg4);
        if (0xea7eb073880686001519321fa66299ef645d1414c3d7c4fb7c1c55a10d84ab6::fixed_point32_empower::gt(v0, v1)) {
            0xea7eb073880686001519321fa66299ef645d1414c3d7c4fb7c1c55a10d84ab6::fixed_point32_empower::sub(v0, v1)
        } else {
            0xea7eb073880686001519321fa66299ef645d1414c3d7c4fb7c1c55a10d84ab6::fixed_point32_empower::zero()
        }
    }

    public fun max_borrow_amount<T0>(arg0: &0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::obligation::Obligation, arg1: &0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::market::Market, arg2: &0x550df640624390b2f1c6d012321a9857acfce2da82a04e41454358b9acfc4a60::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::x_oracle::XOracle, arg4: &0x2::clock::Clock) : u64 {
        let v0 = available_borrow_amount_in_usd(arg0, arg1, arg2, arg3, arg4);
        if (0xea7eb073880686001519321fa66299ef645d1414c3d7c4fb7c1c55a10d84ab6::fixed_point32_empower::gt(v0, 0xea7eb073880686001519321fa66299ef645d1414c3d7c4fb7c1c55a10d84ab6::fixed_point32_empower::zero())) {
            let v2 = 0x1::type_name::get<T0>();
            0x1::fixed_point32::multiply_u64(0x2::math::pow(10, 0x550df640624390b2f1c6d012321a9857acfce2da82a04e41454358b9acfc4a60::coin_decimals_registry::decimals(arg2, v2)), 0xea7eb073880686001519321fa66299ef645d1414c3d7c4fb7c1c55a10d84ab6::fixed_point32_empower::div(v0, 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::price::get_price(arg3, v2, arg4)))
        } else {
            0
        }
    }

    public fun max_withdraw_amount<T0>(arg0: &0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::obligation::Obligation, arg1: &0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::market::Market, arg2: &0x550df640624390b2f1c6d012321a9857acfce2da82a04e41454358b9acfc4a60::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x98641441456a58f8fe4c8736d801c3dae308e9de5d98126664ab899ad53157af::x_oracle::XOracle, arg4: &0x2::clock::Clock) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (0x1::fixed_point32::is_zero(0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::debt_value::debts_value_usd(arg0, arg2, arg3, arg4))) {
            return 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::obligation::collateral(arg0, v0)
        };
        let v1 = available_borrow_amount_in_usd(arg0, arg1, arg2, arg3, arg4);
        let v2 = 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::risk_model::collateral_factor(0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::market::risk_model(arg1, v0));
        if (0x1::fixed_point32::is_zero(v2)) {
            return if (!0x1::fixed_point32::is_zero(v1)) {
                0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::obligation::collateral(arg0, v0)
            } else {
                0
            }
        };
        0x2::math::min(0x1::fixed_point32::divide_u64(0x1::fixed_point32::multiply_u64(0x2::math::pow(10, 0x550df640624390b2f1c6d012321a9857acfce2da82a04e41454358b9acfc4a60::coin_decimals_registry::decimals(arg2, v0)), 0xea7eb073880686001519321fa66299ef645d1414c3d7c4fb7c1c55a10d84ab6::fixed_point32_empower::div(v1, 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::price::get_price(arg3, v0, arg4))), v2), 0xeb5cc177da3bc98de3d0ede68bef128dab0bb0c5e83912b5137457bab7d60a17::obligation::collateral(arg0, v0))
    }

    // decompiled from Move bytecode v6
}

