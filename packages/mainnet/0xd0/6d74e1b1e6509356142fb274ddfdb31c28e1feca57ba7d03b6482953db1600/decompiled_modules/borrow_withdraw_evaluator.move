module 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::borrow_withdraw_evaluator {
    public fun available_borrow_amount_in_usd(arg0: &0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::obligation::Obligation, arg1: &0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market::Market, arg2: &0xe6ddf4097f892306408ddbc8da0e84a86cc64f6fd09c3b4130a5591a32b2aec8::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x6215446965938eaf3596a420047ed0da61a17c8c683b0941f9e54511ecad2b4b::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::collateral_value::collaterals_value_usd_for_borrow(arg0, arg1, arg2, arg3, arg4);
        let v1 = 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::debt_value::debts_value_usd(arg0, arg2, arg3, arg4);
        if (0x7eaac45a28873a47c2de190f87f59e40e140017c6c4cc5e82b3a1baaaf7d20e::fixed_point32_empower::gt(v0, v1)) {
            0x7eaac45a28873a47c2de190f87f59e40e140017c6c4cc5e82b3a1baaaf7d20e::fixed_point32_empower::sub(v0, v1)
        } else {
            0x7eaac45a28873a47c2de190f87f59e40e140017c6c4cc5e82b3a1baaaf7d20e::fixed_point32_empower::zero()
        }
    }

    public fun max_borrow_amount<T0>(arg0: &0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::obligation::Obligation, arg1: &0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market::Market, arg2: &0xe6ddf4097f892306408ddbc8da0e84a86cc64f6fd09c3b4130a5591a32b2aec8::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x6215446965938eaf3596a420047ed0da61a17c8c683b0941f9e54511ecad2b4b::x_oracle::XOracle, arg4: &0x2::clock::Clock) : u64 {
        let v0 = available_borrow_amount_in_usd(arg0, arg1, arg2, arg3, arg4);
        if (0x7eaac45a28873a47c2de190f87f59e40e140017c6c4cc5e82b3a1baaaf7d20e::fixed_point32_empower::gt(v0, 0x7eaac45a28873a47c2de190f87f59e40e140017c6c4cc5e82b3a1baaaf7d20e::fixed_point32_empower::zero())) {
            let v2 = 0x1::type_name::get<T0>();
            0x1::fixed_point32::multiply_u64(0x2::math::pow(10, 0xe6ddf4097f892306408ddbc8da0e84a86cc64f6fd09c3b4130a5591a32b2aec8::coin_decimals_registry::decimals(arg2, v2)), 0x7eaac45a28873a47c2de190f87f59e40e140017c6c4cc5e82b3a1baaaf7d20e::fixed_point32_empower::div(v0, 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::price::get_price(arg3, v2, arg4)))
        } else {
            0
        }
    }

    public fun max_withdraw_amount<T0>(arg0: &0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::obligation::Obligation, arg1: &0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market::Market, arg2: &0xe6ddf4097f892306408ddbc8da0e84a86cc64f6fd09c3b4130a5591a32b2aec8::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x6215446965938eaf3596a420047ed0da61a17c8c683b0941f9e54511ecad2b4b::x_oracle::XOracle, arg4: &0x2::clock::Clock) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (0x1::fixed_point32::is_zero(0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::debt_value::debts_value_usd(arg0, arg2, arg3, arg4))) {
            return 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::obligation::collateral(arg0, v0)
        };
        let v1 = available_borrow_amount_in_usd(arg0, arg1, arg2, arg3, arg4);
        let v2 = 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::risk_model::collateral_factor(0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market::risk_model(arg1, v0));
        if (0x1::fixed_point32::is_zero(v2)) {
            return if (!0x1::fixed_point32::is_zero(v1)) {
                0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::obligation::collateral(arg0, v0)
            } else {
                0
            }
        };
        0x2::math::min(0x1::fixed_point32::divide_u64(0x1::fixed_point32::multiply_u64(0x2::math::pow(10, 0xe6ddf4097f892306408ddbc8da0e84a86cc64f6fd09c3b4130a5591a32b2aec8::coin_decimals_registry::decimals(arg2, v0)), 0x7eaac45a28873a47c2de190f87f59e40e140017c6c4cc5e82b3a1baaaf7d20e::fixed_point32_empower::div(v1, 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::price::get_price(arg3, v0, arg4))), v2), 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::obligation::collateral(arg0, v0))
    }

    // decompiled from Move bytecode v6
}

