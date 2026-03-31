module 0x85b169ee9c0f2c70130dda52ed62aa2b368895bafa8ca93fb2e1f655060b3018::borrow_withdraw_evaluator {
    public fun available_borrow_amount_in_usd(arg0: &0x85b169ee9c0f2c70130dda52ed62aa2b368895bafa8ca93fb2e1f655060b3018::obligation::Obligation, arg1: &0x85b169ee9c0f2c70130dda52ed62aa2b368895bafa8ca93fb2e1f655060b3018::market::Market, arg2: &0x8a9d1a0a19089903ef423a2ee816d1cb386326a949dc23ddc99707094dd38ba7::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x6790ab53e30ff851d7199bc50243b229718daa0443b41bd663253bdc6624811a::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x85b169ee9c0f2c70130dda52ed62aa2b368895bafa8ca93fb2e1f655060b3018::collateral_value::collaterals_value_usd_for_borrow(arg0, arg1, arg2, arg3, arg4);
        let v1 = 0x85b169ee9c0f2c70130dda52ed62aa2b368895bafa8ca93fb2e1f655060b3018::debt_value::debts_value_usd(arg0, arg2, arg3, arg4);
        if (0xe427ee0ffc74da7fc4f24e3cf1c2f087207226c1538c9badfa502b1d44a6351e::fixed_point32_empower::gt(v0, v1)) {
            0xe427ee0ffc74da7fc4f24e3cf1c2f087207226c1538c9badfa502b1d44a6351e::fixed_point32_empower::sub(v0, v1)
        } else {
            0xe427ee0ffc74da7fc4f24e3cf1c2f087207226c1538c9badfa502b1d44a6351e::fixed_point32_empower::zero()
        }
    }

    public fun max_borrow_amount<T0>(arg0: &0x85b169ee9c0f2c70130dda52ed62aa2b368895bafa8ca93fb2e1f655060b3018::obligation::Obligation, arg1: &0x85b169ee9c0f2c70130dda52ed62aa2b368895bafa8ca93fb2e1f655060b3018::market::Market, arg2: &0x8a9d1a0a19089903ef423a2ee816d1cb386326a949dc23ddc99707094dd38ba7::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x6790ab53e30ff851d7199bc50243b229718daa0443b41bd663253bdc6624811a::x_oracle::XOracle, arg4: &0x2::clock::Clock) : u64 {
        let v0 = available_borrow_amount_in_usd(arg0, arg1, arg2, arg3, arg4);
        if (0xe427ee0ffc74da7fc4f24e3cf1c2f087207226c1538c9badfa502b1d44a6351e::fixed_point32_empower::gt(v0, 0xe427ee0ffc74da7fc4f24e3cf1c2f087207226c1538c9badfa502b1d44a6351e::fixed_point32_empower::zero())) {
            let v2 = 0x1::type_name::get<T0>();
            0x1::fixed_point32::multiply_u64(0x2::math::pow(10, 0x8a9d1a0a19089903ef423a2ee816d1cb386326a949dc23ddc99707094dd38ba7::coin_decimals_registry::decimals(arg2, v2)), 0xe427ee0ffc74da7fc4f24e3cf1c2f087207226c1538c9badfa502b1d44a6351e::fixed_point32_empower::div(v0, 0x85b169ee9c0f2c70130dda52ed62aa2b368895bafa8ca93fb2e1f655060b3018::price::get_price(arg3, v2, arg4)))
        } else {
            0
        }
    }

    public fun max_withdraw_amount<T0>(arg0: &0x85b169ee9c0f2c70130dda52ed62aa2b368895bafa8ca93fb2e1f655060b3018::obligation::Obligation, arg1: &0x85b169ee9c0f2c70130dda52ed62aa2b368895bafa8ca93fb2e1f655060b3018::market::Market, arg2: &0x8a9d1a0a19089903ef423a2ee816d1cb386326a949dc23ddc99707094dd38ba7::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x6790ab53e30ff851d7199bc50243b229718daa0443b41bd663253bdc6624811a::x_oracle::XOracle, arg4: &0x2::clock::Clock) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (0x1::fixed_point32::is_zero(0x85b169ee9c0f2c70130dda52ed62aa2b368895bafa8ca93fb2e1f655060b3018::debt_value::debts_value_usd(arg0, arg2, arg3, arg4))) {
            return 0x85b169ee9c0f2c70130dda52ed62aa2b368895bafa8ca93fb2e1f655060b3018::obligation::collateral(arg0, v0)
        };
        let v1 = available_borrow_amount_in_usd(arg0, arg1, arg2, arg3, arg4);
        let v2 = 0x85b169ee9c0f2c70130dda52ed62aa2b368895bafa8ca93fb2e1f655060b3018::risk_model::collateral_factor(0x85b169ee9c0f2c70130dda52ed62aa2b368895bafa8ca93fb2e1f655060b3018::market::risk_model(arg1, v0));
        if (0x1::fixed_point32::is_zero(v2)) {
            return if (!0x1::fixed_point32::is_zero(v1)) {
                0x85b169ee9c0f2c70130dda52ed62aa2b368895bafa8ca93fb2e1f655060b3018::obligation::collateral(arg0, v0)
            } else {
                0
            }
        };
        0x2::math::min(0x1::fixed_point32::divide_u64(0x1::fixed_point32::multiply_u64(0x2::math::pow(10, 0x8a9d1a0a19089903ef423a2ee816d1cb386326a949dc23ddc99707094dd38ba7::coin_decimals_registry::decimals(arg2, v0)), 0xe427ee0ffc74da7fc4f24e3cf1c2f087207226c1538c9badfa502b1d44a6351e::fixed_point32_empower::div(v1, 0x85b169ee9c0f2c70130dda52ed62aa2b368895bafa8ca93fb2e1f655060b3018::price::get_price(arg3, v0, arg4))), v2), 0x85b169ee9c0f2c70130dda52ed62aa2b368895bafa8ca93fb2e1f655060b3018::obligation::collateral(arg0, v0))
    }

    // decompiled from Move bytecode v6
}

