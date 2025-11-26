module 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::borrow_withdraw_evaluator {
    public fun available_borrow_amount_in_usd(arg0: &0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::obligation::Obligation, arg1: &0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::market::Market, arg2: &0xf02732656b4dc135a20a52ff5495425541d4280c54aa93ef5f8bceecf49b9f9::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x901a0eda69c69f5ed9ccd6e94b01e2a4d3e36c88f0b5c0da90978a2a92979007::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::collateral_value::collaterals_value_usd_for_borrow(arg0, arg1, arg2, arg3, arg4);
        let v1 = 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::debt_value::debts_value_usd(arg0, arg2, arg3, arg4);
        if (0x724ff007e3cb5e2464e94283edecd0c610567d475a980beaa8f404d9c15d3ba7::fixed_point32_empower::gt(v0, v1)) {
            0x724ff007e3cb5e2464e94283edecd0c610567d475a980beaa8f404d9c15d3ba7::fixed_point32_empower::sub(v0, v1)
        } else {
            0x724ff007e3cb5e2464e94283edecd0c610567d475a980beaa8f404d9c15d3ba7::fixed_point32_empower::zero()
        }
    }

    public fun max_borrow_amount<T0>(arg0: &0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::obligation::Obligation, arg1: &0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::market::Market, arg2: &0xf02732656b4dc135a20a52ff5495425541d4280c54aa93ef5f8bceecf49b9f9::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x901a0eda69c69f5ed9ccd6e94b01e2a4d3e36c88f0b5c0da90978a2a92979007::x_oracle::XOracle, arg4: &0x2::clock::Clock) : u64 {
        let v0 = available_borrow_amount_in_usd(arg0, arg1, arg2, arg3, arg4);
        if (0x724ff007e3cb5e2464e94283edecd0c610567d475a980beaa8f404d9c15d3ba7::fixed_point32_empower::gt(v0, 0x724ff007e3cb5e2464e94283edecd0c610567d475a980beaa8f404d9c15d3ba7::fixed_point32_empower::zero())) {
            let v2 = 0x1::type_name::get<T0>();
            0x1::fixed_point32::multiply_u64(0x2::math::pow(10, 0xf02732656b4dc135a20a52ff5495425541d4280c54aa93ef5f8bceecf49b9f9::coin_decimals_registry::decimals(arg2, v2)), 0x724ff007e3cb5e2464e94283edecd0c610567d475a980beaa8f404d9c15d3ba7::fixed_point32_empower::div(v0, 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::price::get_price(arg3, v2, arg4)))
        } else {
            0
        }
    }

    public fun max_withdraw_amount<T0>(arg0: &0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::obligation::Obligation, arg1: &0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::market::Market, arg2: &0xf02732656b4dc135a20a52ff5495425541d4280c54aa93ef5f8bceecf49b9f9::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x901a0eda69c69f5ed9ccd6e94b01e2a4d3e36c88f0b5c0da90978a2a92979007::x_oracle::XOracle, arg4: &0x2::clock::Clock) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (0x1::fixed_point32::is_zero(0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::debt_value::debts_value_usd(arg0, arg2, arg3, arg4))) {
            return 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::obligation::collateral(arg0, v0)
        };
        let v1 = available_borrow_amount_in_usd(arg0, arg1, arg2, arg3, arg4);
        let v2 = 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::risk_model::collateral_factor(0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::market::risk_model(arg1, v0));
        if (0x1::fixed_point32::is_zero(v2)) {
            return if (!0x1::fixed_point32::is_zero(v1)) {
                0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::obligation::collateral(arg0, v0)
            } else {
                0
            }
        };
        0x2::math::min(0x1::fixed_point32::divide_u64(0x1::fixed_point32::multiply_u64(0x2::math::pow(10, 0xf02732656b4dc135a20a52ff5495425541d4280c54aa93ef5f8bceecf49b9f9::coin_decimals_registry::decimals(arg2, v0)), 0x724ff007e3cb5e2464e94283edecd0c610567d475a980beaa8f404d9c15d3ba7::fixed_point32_empower::div(v1, 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::price::get_price(arg3, v0, arg4))), v2), 0x814b1189ed8ce8c021803aa403e698b247cbc0accd295cd3652b982496af704e::obligation::collateral(arg0, v0))
    }

    // decompiled from Move bytecode v6
}

