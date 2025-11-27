module 0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::borrow_withdraw_evaluator {
    public fun available_borrow_amount_in_usd(arg0: &0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::obligation::Obligation, arg1: &0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::market::Market, arg2: &0x46f8c31ef54ad3678fae562c896eeb303dd4fd58509f2393c9e3bdc7b8987925::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x8e8dd2cd5338ffdd6a1c2315162aae1d3685fbf0c164e13bb59edfdcbf47f0ef::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::collateral_value::collaterals_value_usd_for_borrow(arg0, arg1, arg2, arg3, arg4);
        let v1 = 0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::debt_value::debts_value_usd(arg0, arg2, arg3, arg4);
        if (0xf8dff55846654f62d2e2f2e08a28367bb80c6f91902ed58aacc100ba54279c3c::fixed_point32_empower::gt(v0, v1)) {
            0xf8dff55846654f62d2e2f2e08a28367bb80c6f91902ed58aacc100ba54279c3c::fixed_point32_empower::sub(v0, v1)
        } else {
            0xf8dff55846654f62d2e2f2e08a28367bb80c6f91902ed58aacc100ba54279c3c::fixed_point32_empower::zero()
        }
    }

    public fun max_borrow_amount<T0>(arg0: &0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::obligation::Obligation, arg1: &0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::market::Market, arg2: &0x46f8c31ef54ad3678fae562c896eeb303dd4fd58509f2393c9e3bdc7b8987925::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x8e8dd2cd5338ffdd6a1c2315162aae1d3685fbf0c164e13bb59edfdcbf47f0ef::x_oracle::XOracle, arg4: &0x2::clock::Clock) : u64 {
        let v0 = available_borrow_amount_in_usd(arg0, arg1, arg2, arg3, arg4);
        if (0xf8dff55846654f62d2e2f2e08a28367bb80c6f91902ed58aacc100ba54279c3c::fixed_point32_empower::gt(v0, 0xf8dff55846654f62d2e2f2e08a28367bb80c6f91902ed58aacc100ba54279c3c::fixed_point32_empower::zero())) {
            let v2 = 0x1::type_name::get<T0>();
            0x1::fixed_point32::multiply_u64(0x2::math::pow(10, 0x46f8c31ef54ad3678fae562c896eeb303dd4fd58509f2393c9e3bdc7b8987925::coin_decimals_registry::decimals(arg2, v2)), 0xf8dff55846654f62d2e2f2e08a28367bb80c6f91902ed58aacc100ba54279c3c::fixed_point32_empower::div(v0, 0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::price::get_price(arg3, v2, arg4)))
        } else {
            0
        }
    }

    public fun max_withdraw_amount<T0>(arg0: &0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::obligation::Obligation, arg1: &0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::market::Market, arg2: &0x46f8c31ef54ad3678fae562c896eeb303dd4fd58509f2393c9e3bdc7b8987925::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x8e8dd2cd5338ffdd6a1c2315162aae1d3685fbf0c164e13bb59edfdcbf47f0ef::x_oracle::XOracle, arg4: &0x2::clock::Clock) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (0x1::fixed_point32::is_zero(0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::debt_value::debts_value_usd(arg0, arg2, arg3, arg4))) {
            return 0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::obligation::collateral(arg0, v0)
        };
        let v1 = available_borrow_amount_in_usd(arg0, arg1, arg2, arg3, arg4);
        let v2 = 0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::risk_model::collateral_factor(0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::market::risk_model(arg1, v0));
        if (0x1::fixed_point32::is_zero(v2)) {
            return if (!0x1::fixed_point32::is_zero(v1)) {
                0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::obligation::collateral(arg0, v0)
            } else {
                0
            }
        };
        0x2::math::min(0x1::fixed_point32::divide_u64(0x1::fixed_point32::multiply_u64(0x2::math::pow(10, 0x46f8c31ef54ad3678fae562c896eeb303dd4fd58509f2393c9e3bdc7b8987925::coin_decimals_registry::decimals(arg2, v0)), 0xf8dff55846654f62d2e2f2e08a28367bb80c6f91902ed58aacc100ba54279c3c::fixed_point32_empower::div(v1, 0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::price::get_price(arg3, v0, arg4))), v2), 0xcc01e581051ac41eeec00612b9ee3ac3c317f34c06cccee54a00956e6c0d96c4::obligation::collateral(arg0, v0))
    }

    // decompiled from Move bytecode v6
}

