module 0x4cb6a6f8c9d61f3a849f7033a78086076296842fd0ca3c0dce10f6d39172dc00::borrow_withdraw_evaluator {
    public fun available_borrow_amount_in_usd(arg0: &0x4cb6a6f8c9d61f3a849f7033a78086076296842fd0ca3c0dce10f6d39172dc00::obligation::Obligation, arg1: &0x4cb6a6f8c9d61f3a849f7033a78086076296842fd0ca3c0dce10f6d39172dc00::market::Market, arg2: &0xd68eb3aafa85228a532500ca1ca45af097cb3b941dbdf297e68b1f01e0cdd95e::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x50be75ec6be925b2422c57182e6ef40eadec69eb9b55130b9c4af7fbb039f460::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x4cb6a6f8c9d61f3a849f7033a78086076296842fd0ca3c0dce10f6d39172dc00::collateral_value::collaterals_value_usd_for_borrow(arg0, arg1, arg2, arg3, arg4);
        let v1 = 0x4cb6a6f8c9d61f3a849f7033a78086076296842fd0ca3c0dce10f6d39172dc00::debt_value::debts_value_usd_with_weight(arg0, arg2, arg1, arg3, arg4);
        if (0x2483a99369bbbcfe0dd45bb0b2725310d171dbbc0deda421115bbb84c31fd12d::fixed_point32_empower::gt(v0, v1)) {
            0x2483a99369bbbcfe0dd45bb0b2725310d171dbbc0deda421115bbb84c31fd12d::fixed_point32_empower::sub(v0, v1)
        } else {
            0x2483a99369bbbcfe0dd45bb0b2725310d171dbbc0deda421115bbb84c31fd12d::fixed_point32_empower::zero()
        }
    }

    public fun max_borrow_amount<T0>(arg0: &0x4cb6a6f8c9d61f3a849f7033a78086076296842fd0ca3c0dce10f6d39172dc00::obligation::Obligation, arg1: &0x4cb6a6f8c9d61f3a849f7033a78086076296842fd0ca3c0dce10f6d39172dc00::market::Market, arg2: &0xd68eb3aafa85228a532500ca1ca45af097cb3b941dbdf297e68b1f01e0cdd95e::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x50be75ec6be925b2422c57182e6ef40eadec69eb9b55130b9c4af7fbb039f460::x_oracle::XOracle, arg4: &0x2::clock::Clock) : u64 {
        let v0 = available_borrow_amount_in_usd(arg0, arg1, arg2, arg3, arg4);
        if (0x2483a99369bbbcfe0dd45bb0b2725310d171dbbc0deda421115bbb84c31fd12d::fixed_point32_empower::gt(v0, 0x2483a99369bbbcfe0dd45bb0b2725310d171dbbc0deda421115bbb84c31fd12d::fixed_point32_empower::zero())) {
            let v2 = 0x1::type_name::get<T0>();
            0x1::fixed_point32::multiply_u64(0x2::math::pow(10, 0xd68eb3aafa85228a532500ca1ca45af097cb3b941dbdf297e68b1f01e0cdd95e::coin_decimals_registry::decimals(arg2, v2)), 0x2483a99369bbbcfe0dd45bb0b2725310d171dbbc0deda421115bbb84c31fd12d::fixed_point32_empower::div(v0, 0x2483a99369bbbcfe0dd45bb0b2725310d171dbbc0deda421115bbb84c31fd12d::fixed_point32_empower::mul(0x4cb6a6f8c9d61f3a849f7033a78086076296842fd0ca3c0dce10f6d39172dc00::price::get_price(arg3, v2, arg4), 0x4cb6a6f8c9d61f3a849f7033a78086076296842fd0ca3c0dce10f6d39172dc00::interest_model::borrow_weight(0x4cb6a6f8c9d61f3a849f7033a78086076296842fd0ca3c0dce10f6d39172dc00::market::interest_model(arg1, v2)))))
        } else {
            0
        }
    }

    public fun max_withdraw_amount<T0>(arg0: &0x4cb6a6f8c9d61f3a849f7033a78086076296842fd0ca3c0dce10f6d39172dc00::obligation::Obligation, arg1: &0x4cb6a6f8c9d61f3a849f7033a78086076296842fd0ca3c0dce10f6d39172dc00::market::Market, arg2: &0xd68eb3aafa85228a532500ca1ca45af097cb3b941dbdf297e68b1f01e0cdd95e::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x50be75ec6be925b2422c57182e6ef40eadec69eb9b55130b9c4af7fbb039f460::x_oracle::XOracle, arg4: &0x2::clock::Clock) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (0x1::fixed_point32::is_zero(0x4cb6a6f8c9d61f3a849f7033a78086076296842fd0ca3c0dce10f6d39172dc00::debt_value::debts_value_usd_with_weight(arg0, arg2, arg1, arg3, arg4))) {
            return 0x4cb6a6f8c9d61f3a849f7033a78086076296842fd0ca3c0dce10f6d39172dc00::obligation::collateral(arg0, v0)
        };
        0x2::math::min(0x1::fixed_point32::divide_u64(0x1::fixed_point32::multiply_u64(0x2::math::pow(10, 0xd68eb3aafa85228a532500ca1ca45af097cb3b941dbdf297e68b1f01e0cdd95e::coin_decimals_registry::decimals(arg2, v0)), 0x2483a99369bbbcfe0dd45bb0b2725310d171dbbc0deda421115bbb84c31fd12d::fixed_point32_empower::div(available_borrow_amount_in_usd(arg0, arg1, arg2, arg3, arg4), 0x4cb6a6f8c9d61f3a849f7033a78086076296842fd0ca3c0dce10f6d39172dc00::price::get_price(arg3, v0, arg4))), 0x4cb6a6f8c9d61f3a849f7033a78086076296842fd0ca3c0dce10f6d39172dc00::risk_model::collateral_factor(0x4cb6a6f8c9d61f3a849f7033a78086076296842fd0ca3c0dce10f6d39172dc00::market::risk_model(arg1, v0))), 0x4cb6a6f8c9d61f3a849f7033a78086076296842fd0ca3c0dce10f6d39172dc00::obligation::collateral(arg0, v0))
    }

    // decompiled from Move bytecode v6
}

