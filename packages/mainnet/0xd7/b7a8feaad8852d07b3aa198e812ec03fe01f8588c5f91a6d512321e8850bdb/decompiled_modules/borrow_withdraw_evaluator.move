module 0xd7b7a8feaad8852d07b3aa198e812ec03fe01f8588c5f91a6d512321e8850bdb::borrow_withdraw_evaluator {
    public fun available_borrow_amount_in_usd(arg0: &0xd7b7a8feaad8852d07b3aa198e812ec03fe01f8588c5f91a6d512321e8850bdb::obligation::Obligation, arg1: &0xd7b7a8feaad8852d07b3aa198e812ec03fe01f8588c5f91a6d512321e8850bdb::market::Market, arg2: &0xd7b7a8feaad8852d07b3aa198e812ec03fe01f8588c5f91a6d512321e8850bdb::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0xd7b7a8feaad8852d07b3aa198e812ec03fe01f8588c5f91a6d512321e8850bdb::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0xd7b7a8feaad8852d07b3aa198e812ec03fe01f8588c5f91a6d512321e8850bdb::collateral_value::collaterals_value_usd_for_borrow(arg0, arg1, arg2, arg3, arg4);
        let v1 = 0xd7b7a8feaad8852d07b3aa198e812ec03fe01f8588c5f91a6d512321e8850bdb::debt_value::debts_value_usd_with_weight(arg0, arg2, arg1, arg3, arg4);
        if (0xd7b7a8feaad8852d07b3aa198e812ec03fe01f8588c5f91a6d512321e8850bdb::fixed_point32_empower::gt(v0, v1)) {
            0xd7b7a8feaad8852d07b3aa198e812ec03fe01f8588c5f91a6d512321e8850bdb::fixed_point32_empower::sub(v0, v1)
        } else {
            0xd7b7a8feaad8852d07b3aa198e812ec03fe01f8588c5f91a6d512321e8850bdb::fixed_point32_empower::zero()
        }
    }

    public fun max_borrow_amount<T0>(arg0: &0xd7b7a8feaad8852d07b3aa198e812ec03fe01f8588c5f91a6d512321e8850bdb::obligation::Obligation, arg1: &0xd7b7a8feaad8852d07b3aa198e812ec03fe01f8588c5f91a6d512321e8850bdb::market::Market, arg2: &0xd7b7a8feaad8852d07b3aa198e812ec03fe01f8588c5f91a6d512321e8850bdb::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0xd7b7a8feaad8852d07b3aa198e812ec03fe01f8588c5f91a6d512321e8850bdb::x_oracle::XOracle, arg4: &0x2::clock::Clock) : u64 {
        let v0 = available_borrow_amount_in_usd(arg0, arg1, arg2, arg3, arg4);
        if (0xd7b7a8feaad8852d07b3aa198e812ec03fe01f8588c5f91a6d512321e8850bdb::fixed_point32_empower::gt(v0, 0xd7b7a8feaad8852d07b3aa198e812ec03fe01f8588c5f91a6d512321e8850bdb::fixed_point32_empower::zero())) {
            let v2 = 0x1::type_name::get<T0>();
            0x1::fixed_point32::multiply_u64(0x2::math::pow(10, 0xd7b7a8feaad8852d07b3aa198e812ec03fe01f8588c5f91a6d512321e8850bdb::coin_decimals_registry::decimals(arg2, v2)), 0xd7b7a8feaad8852d07b3aa198e812ec03fe01f8588c5f91a6d512321e8850bdb::fixed_point32_empower::div(v0, 0xd7b7a8feaad8852d07b3aa198e812ec03fe01f8588c5f91a6d512321e8850bdb::fixed_point32_empower::mul(0xd7b7a8feaad8852d07b3aa198e812ec03fe01f8588c5f91a6d512321e8850bdb::price::get_price(arg3, v2, arg4), 0xd7b7a8feaad8852d07b3aa198e812ec03fe01f8588c5f91a6d512321e8850bdb::interest_model::borrow_weight(0xd7b7a8feaad8852d07b3aa198e812ec03fe01f8588c5f91a6d512321e8850bdb::market::interest_model(arg1, v2)))))
        } else {
            0
        }
    }

    public fun max_withdraw_amount<T0>(arg0: &0xd7b7a8feaad8852d07b3aa198e812ec03fe01f8588c5f91a6d512321e8850bdb::obligation::Obligation, arg1: &0xd7b7a8feaad8852d07b3aa198e812ec03fe01f8588c5f91a6d512321e8850bdb::market::Market, arg2: &0xd7b7a8feaad8852d07b3aa198e812ec03fe01f8588c5f91a6d512321e8850bdb::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0xd7b7a8feaad8852d07b3aa198e812ec03fe01f8588c5f91a6d512321e8850bdb::x_oracle::XOracle, arg4: &0x2::clock::Clock) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (0x1::fixed_point32::is_zero(0xd7b7a8feaad8852d07b3aa198e812ec03fe01f8588c5f91a6d512321e8850bdb::debt_value::debts_value_usd_with_weight(arg0, arg2, arg1, arg3, arg4))) {
            return 0xd7b7a8feaad8852d07b3aa198e812ec03fe01f8588c5f91a6d512321e8850bdb::obligation::collateral(arg0, v0)
        };
        let v1 = available_borrow_amount_in_usd(arg0, arg1, arg2, arg3, arg4);
        let v2 = 0xd7b7a8feaad8852d07b3aa198e812ec03fe01f8588c5f91a6d512321e8850bdb::risk_model::collateral_factor(0xd7b7a8feaad8852d07b3aa198e812ec03fe01f8588c5f91a6d512321e8850bdb::market::risk_model(arg1, v0));
        if (0x1::fixed_point32::is_zero(v2)) {
            return if (!0x1::fixed_point32::is_zero(v1)) {
                0xd7b7a8feaad8852d07b3aa198e812ec03fe01f8588c5f91a6d512321e8850bdb::obligation::collateral(arg0, v0)
            } else {
                0
            }
        };
        0x2::math::min(0x1::fixed_point32::divide_u64(0x1::fixed_point32::multiply_u64(0x2::math::pow(10, 0xd7b7a8feaad8852d07b3aa198e812ec03fe01f8588c5f91a6d512321e8850bdb::coin_decimals_registry::decimals(arg2, v0)), 0xd7b7a8feaad8852d07b3aa198e812ec03fe01f8588c5f91a6d512321e8850bdb::fixed_point32_empower::div(v1, 0xd7b7a8feaad8852d07b3aa198e812ec03fe01f8588c5f91a6d512321e8850bdb::price::get_price(arg3, v0, arg4))), v2), 0xd7b7a8feaad8852d07b3aa198e812ec03fe01f8588c5f91a6d512321e8850bdb::obligation::collateral(arg0, v0))
    }

    // decompiled from Move bytecode v6
}

