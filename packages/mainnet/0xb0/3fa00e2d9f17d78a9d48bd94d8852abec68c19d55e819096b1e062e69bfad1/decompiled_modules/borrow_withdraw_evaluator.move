module 0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::borrow_withdraw_evaluator {
    public fun available_borrow_amount_in_usd(arg0: &0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::obligation::Obligation, arg1: &0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::market::Market, arg2: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0xe7511600c924f1d0ac4b3fa5de3ae26b8845545902b015dc5fc7894307365d7b::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::collateral_value::collaterals_value_usd_for_borrow(arg0, arg1, arg2, arg3, arg4);
        let v1 = 0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::debt_value::debts_value_usd_with_weight(arg0, arg2, arg1, arg3, arg4);
        if (0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::gt(v0, v1)) {
            0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::sub(v0, v1)
        } else {
            0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::zero()
        }
    }

    public fun max_borrow_amount<T0>(arg0: &0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::obligation::Obligation, arg1: &0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::market::Market, arg2: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0xe7511600c924f1d0ac4b3fa5de3ae26b8845545902b015dc5fc7894307365d7b::x_oracle::XOracle, arg4: &0x2::clock::Clock) : u64 {
        let v0 = available_borrow_amount_in_usd(arg0, arg1, arg2, arg3, arg4);
        if (0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::gt(v0, 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::zero())) {
            let v2 = 0x1::type_name::get<T0>();
            0x1::fixed_point32::multiply_u64(0x2::math::pow(10, 0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::decimals(arg2, v2)), 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::div(v0, 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::mul(0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::price::get_price(arg3, v2, arg4), 0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::interest_model::borrow_weight(0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::market::interest_model(arg1, v2)))))
        } else {
            0
        }
    }

    public fun max_withdraw_amount<T0>(arg0: &0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::obligation::Obligation, arg1: &0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::market::Market, arg2: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0xe7511600c924f1d0ac4b3fa5de3ae26b8845545902b015dc5fc7894307365d7b::x_oracle::XOracle, arg4: &0x2::clock::Clock) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (0x1::fixed_point32::is_zero(0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::debt_value::debts_value_usd_with_weight(arg0, arg2, arg1, arg3, arg4))) {
            return 0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::obligation::collateral(arg0, v0)
        };
        let v1 = available_borrow_amount_in_usd(arg0, arg1, arg2, arg3, arg4);
        let v2 = 0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::risk_model::collateral_factor(0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::market::risk_model(arg1, v0));
        if (0x1::fixed_point32::is_zero(v2)) {
            return if (!0x1::fixed_point32::is_zero(v1)) {
                0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::obligation::collateral(arg0, v0)
            } else {
                0
            }
        };
        0x2::math::min(0x1::fixed_point32::divide_u64(0x1::fixed_point32::multiply_u64(0x2::math::pow(10, 0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::decimals(arg2, v0)), 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::fixed_point32_empower::div(v1, 0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::price::get_price(arg3, v0, arg4))), v2), 0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::obligation::collateral(arg0, v0))
    }

    // decompiled from Move bytecode v6
}

