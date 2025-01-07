module 0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::borrow_withdraw_evaluator {
    public fun available_borrow_amount_in_usd(arg0: &0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::obligation::Obligation, arg1: &0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::market::Market, arg2: &0xe6deefcaa0faa43c407eb03fe0031d579d760556ebff6bed9571a5398fb38212::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x4ab1501220d2b9af2a3bdbb0c170f09dc70cba0014c1c4e48fdf42d246c2b7b4::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::collateral_value::collaterals_value_usd_for_borrow(arg0, arg1, arg2, arg3, arg4);
        let v1 = 0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::debt_value::debts_value_usd_with_weight(arg0, arg2, arg1, arg3, arg4);
        if (0xc9f1a5fbbc568db38446e25ef0cbf78db60a47def1d1e2ee771f63cbcfd7393d::fixed_point32_empower::gt(v0, v1)) {
            0xc9f1a5fbbc568db38446e25ef0cbf78db60a47def1d1e2ee771f63cbcfd7393d::fixed_point32_empower::sub(v0, v1)
        } else {
            0xc9f1a5fbbc568db38446e25ef0cbf78db60a47def1d1e2ee771f63cbcfd7393d::fixed_point32_empower::zero()
        }
    }

    public fun max_borrow_amount<T0>(arg0: &0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::obligation::Obligation, arg1: &0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::market::Market, arg2: &0xe6deefcaa0faa43c407eb03fe0031d579d760556ebff6bed9571a5398fb38212::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x4ab1501220d2b9af2a3bdbb0c170f09dc70cba0014c1c4e48fdf42d246c2b7b4::x_oracle::XOracle, arg4: &0x2::clock::Clock) : u64 {
        let v0 = available_borrow_amount_in_usd(arg0, arg1, arg2, arg3, arg4);
        if (0xc9f1a5fbbc568db38446e25ef0cbf78db60a47def1d1e2ee771f63cbcfd7393d::fixed_point32_empower::gt(v0, 0xc9f1a5fbbc568db38446e25ef0cbf78db60a47def1d1e2ee771f63cbcfd7393d::fixed_point32_empower::zero())) {
            let v2 = 0x1::type_name::get<T0>();
            0x1::fixed_point32::multiply_u64(0x2::math::pow(10, 0xe6deefcaa0faa43c407eb03fe0031d579d760556ebff6bed9571a5398fb38212::coin_decimals_registry::decimals(arg2, v2)), 0xc9f1a5fbbc568db38446e25ef0cbf78db60a47def1d1e2ee771f63cbcfd7393d::fixed_point32_empower::div(v0, 0xc9f1a5fbbc568db38446e25ef0cbf78db60a47def1d1e2ee771f63cbcfd7393d::fixed_point32_empower::mul(0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::price::get_price(arg3, v2, arg4), 0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::interest_model::borrow_weight(0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::market::interest_model(arg1, v2)))))
        } else {
            0
        }
    }

    public fun max_withdraw_amount<T0>(arg0: &0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::obligation::Obligation, arg1: &0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::market::Market, arg2: &0xe6deefcaa0faa43c407eb03fe0031d579d760556ebff6bed9571a5398fb38212::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x4ab1501220d2b9af2a3bdbb0c170f09dc70cba0014c1c4e48fdf42d246c2b7b4::x_oracle::XOracle, arg4: &0x2::clock::Clock) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (0x1::fixed_point32::is_zero(0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::debt_value::debts_value_usd_with_weight(arg0, arg2, arg1, arg3, arg4))) {
            return 0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::obligation::collateral(arg0, v0)
        };
        0x2::math::min(0x1::fixed_point32::divide_u64(0x1::fixed_point32::multiply_u64(0x2::math::pow(10, 0xe6deefcaa0faa43c407eb03fe0031d579d760556ebff6bed9571a5398fb38212::coin_decimals_registry::decimals(arg2, v0)), 0xc9f1a5fbbc568db38446e25ef0cbf78db60a47def1d1e2ee771f63cbcfd7393d::fixed_point32_empower::div(available_borrow_amount_in_usd(arg0, arg1, arg2, arg3, arg4), 0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::price::get_price(arg3, v0, arg4))), 0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::risk_model::collateral_factor(0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::market::risk_model(arg1, v0))), 0x28999f1d63ac5df570e9871e78e9c9c0ec42dcf79a9014d244b18188887d6f47::obligation::collateral(arg0, v0))
    }

    // decompiled from Move bytecode v6
}

