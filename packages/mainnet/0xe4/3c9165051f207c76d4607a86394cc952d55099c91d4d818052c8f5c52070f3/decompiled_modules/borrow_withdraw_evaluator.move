module 0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::borrow_withdraw_evaluator {
    public fun available_borrow_amount_in_usd(arg0: &0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::obligation::Obligation, arg1: &0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::market::Market, arg2: &0x169b9acc361b079b9f58d87ea3c51546a1564ed374d1f4d25dba4e3684481695::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x66f4d8dce7fe98d445fd832e864756fc7666d540f1558176eb1434ecd0c52a11::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::collateral_value::collaterals_value_usd_for_borrow(arg0, arg1, arg2, arg3, arg4);
        let v1 = 0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::debt_value::debts_value_usd_with_weight(arg0, arg2, arg1, arg3, arg4);
        if (0x8238e878d724f642ba188226404489058e2546e92d52496d2a5bc74c9d67ef26::fixed_point32_empower::gt(v0, v1)) {
            0x8238e878d724f642ba188226404489058e2546e92d52496d2a5bc74c9d67ef26::fixed_point32_empower::sub(v0, v1)
        } else {
            0x8238e878d724f642ba188226404489058e2546e92d52496d2a5bc74c9d67ef26::fixed_point32_empower::zero()
        }
    }

    public fun max_borrow_amount<T0>(arg0: &0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::obligation::Obligation, arg1: &0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::market::Market, arg2: &0x169b9acc361b079b9f58d87ea3c51546a1564ed374d1f4d25dba4e3684481695::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x66f4d8dce7fe98d445fd832e864756fc7666d540f1558176eb1434ecd0c52a11::x_oracle::XOracle, arg4: &0x2::clock::Clock) : u64 {
        let v0 = available_borrow_amount_in_usd(arg0, arg1, arg2, arg3, arg4);
        if (0x8238e878d724f642ba188226404489058e2546e92d52496d2a5bc74c9d67ef26::fixed_point32_empower::gt(v0, 0x8238e878d724f642ba188226404489058e2546e92d52496d2a5bc74c9d67ef26::fixed_point32_empower::zero())) {
            let v2 = 0x1::type_name::get<T0>();
            0x1::fixed_point32::multiply_u64(0x2::math::pow(10, 0x169b9acc361b079b9f58d87ea3c51546a1564ed374d1f4d25dba4e3684481695::coin_decimals_registry::decimals(arg2, v2)), 0x8238e878d724f642ba188226404489058e2546e92d52496d2a5bc74c9d67ef26::fixed_point32_empower::div(v0, 0x8238e878d724f642ba188226404489058e2546e92d52496d2a5bc74c9d67ef26::fixed_point32_empower::mul(0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::price::get_price(arg3, v2, arg4), 0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::interest_model::borrow_weight(0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::market::interest_model(arg1, v2)))))
        } else {
            0
        }
    }

    public fun max_withdraw_amount<T0>(arg0: &0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::obligation::Obligation, arg1: &0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::market::Market, arg2: &0x169b9acc361b079b9f58d87ea3c51546a1564ed374d1f4d25dba4e3684481695::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x66f4d8dce7fe98d445fd832e864756fc7666d540f1558176eb1434ecd0c52a11::x_oracle::XOracle, arg4: &0x2::clock::Clock) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (0x1::fixed_point32::is_zero(0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::debt_value::debts_value_usd_with_weight(arg0, arg2, arg1, arg3, arg4))) {
            return 0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::obligation::collateral(arg0, v0)
        };
        0x2::math::min(0x1::fixed_point32::divide_u64(0x1::fixed_point32::multiply_u64(0x2::math::pow(10, 0x169b9acc361b079b9f58d87ea3c51546a1564ed374d1f4d25dba4e3684481695::coin_decimals_registry::decimals(arg2, v0)), 0x8238e878d724f642ba188226404489058e2546e92d52496d2a5bc74c9d67ef26::fixed_point32_empower::div(available_borrow_amount_in_usd(arg0, arg1, arg2, arg3, arg4), 0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::price::get_price(arg3, v0, arg4))), 0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::risk_model::collateral_factor(0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::market::risk_model(arg1, v0))), 0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::obligation::collateral(arg0, v0))
    }

    // decompiled from Move bytecode v6
}

