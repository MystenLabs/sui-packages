module 0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::liquidation_evaluator {
    fun calc_liq_exchange_rate<T0, T1>(arg0: &0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::market::Market, arg1: &0x169b9acc361b079b9f58d87ea3c51546a1564ed374d1f4d25dba4e3684481695::coin_decimals_registry::CoinDecimalsRegistry, arg2: &0x66f4d8dce7fe98d445fd832e864756fc7666d540f1558176eb1434ecd0c52a11::x_oracle::XOracle, arg3: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x1::type_name::get<T1>();
        let v1 = 0x1::type_name::get<T0>();
        0x8238e878d724f642ba188226404489058e2546e92d52496d2a5bc74c9d67ef26::fixed_point32_empower::div(0x8238e878d724f642ba188226404489058e2546e92d52496d2a5bc74c9d67ef26::fixed_point32_empower::mul(0x1::fixed_point32::create_from_rational(0x2::math::pow(10, 0x169b9acc361b079b9f58d87ea3c51546a1564ed374d1f4d25dba4e3684481695::coin_decimals_registry::decimals(arg1, v0)), 0x2::math::pow(10, 0x169b9acc361b079b9f58d87ea3c51546a1564ed374d1f4d25dba4e3684481695::coin_decimals_registry::decimals(arg1, v1))), 0x8238e878d724f642ba188226404489058e2546e92d52496d2a5bc74c9d67ef26::fixed_point32_empower::div(0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::price::get_price(arg2, v1, arg3), 0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::price::get_price(arg2, v0, arg3))), 0x8238e878d724f642ba188226404489058e2546e92d52496d2a5bc74c9d67ef26::fixed_point32_empower::sub(0x8238e878d724f642ba188226404489058e2546e92d52496d2a5bc74c9d67ef26::fixed_point32_empower::from_u64(1), 0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::risk_model::liq_discount(0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::market::risk_model(arg0, v0))))
    }

    public fun liquidation_amounts<T0, T1>(arg0: &0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::obligation::Obligation, arg1: &0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::market::Market, arg2: &0x169b9acc361b079b9f58d87ea3c51546a1564ed374d1f4d25dba4e3684481695::coin_decimals_registry::CoinDecimalsRegistry, arg3: u64, arg4: &0x66f4d8dce7fe98d445fd832e864756fc7666d540f1558176eb1434ecd0c52a11::x_oracle::XOracle, arg5: &0x2::clock::Clock) : (u64, u64, u64) {
        let (v0, v1) = max_liquidation_amounts<T0, T1>(arg0, arg1, arg2, arg4, arg5);
        let (v2, v3) = if (arg3 >= v0) {
            (v0, v1)
        } else {
            (arg3, 0x1::fixed_point32::multiply_u64(arg3, calc_liq_exchange_rate<T0, T1>(arg1, arg2, arg4, arg5)))
        };
        let v4 = 0x1::fixed_point32::multiply_u64(v2, 0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::risk_model::liq_revenue_factor(0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::market::risk_model(arg1, 0x1::type_name::get<T1>())));
        (v2 - v4, v4, v3)
    }

    public fun max_liquidation_amounts<T0, T1>(arg0: &0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::obligation::Obligation, arg1: &0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::market::Market, arg2: &0x169b9acc361b079b9f58d87ea3c51546a1564ed374d1f4d25dba4e3684481695::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x66f4d8dce7fe98d445fd832e864756fc7666d540f1558176eb1434ecd0c52a11::x_oracle::XOracle, arg4: &0x2::clock::Clock) : (u64, u64) {
        let v0 = 0x1::type_name::get<T0>();
        let (_, _) = 0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::obligation::debt(arg0, v0);
        let v3 = 0x1::type_name::get<T1>();
        let v4 = 0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::market::risk_model(arg1, v3);
        let v5 = 0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::risk_model::liq_factor(v4);
        let v6 = 0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::collateral_value::collaterals_value_usd_for_liquidation(arg0, arg1, arg2, arg3, arg4);
        let v7 = 0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::debt_value::debts_value_usd_with_weight(arg0, arg2, arg1, arg3, arg4);
        assert!(0x8238e878d724f642ba188226404489058e2546e92d52496d2a5bc74c9d67ef26::fixed_point32_empower::gt(v7, v6), 0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::error::unable_to_liquidate_error());
        let v8 = 0x2::math::min(0x1::fixed_point32::multiply_u64(0x2::math::pow(10, 0x169b9acc361b079b9f58d87ea3c51546a1564ed374d1f4d25dba4e3684481695::coin_decimals_registry::decimals(arg2, v3)), 0x8238e878d724f642ba188226404489058e2546e92d52496d2a5bc74c9d67ef26::fixed_point32_empower::div(0x8238e878d724f642ba188226404489058e2546e92d52496d2a5bc74c9d67ef26::fixed_point32_empower::div(0x8238e878d724f642ba188226404489058e2546e92d52496d2a5bc74c9d67ef26::fixed_point32_empower::sub(v7, v6), 0x8238e878d724f642ba188226404489058e2546e92d52496d2a5bc74c9d67ef26::fixed_point32_empower::sub(0x8238e878d724f642ba188226404489058e2546e92d52496d2a5bc74c9d67ef26::fixed_point32_empower::mul(0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::interest_model::borrow_weight(0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::market::interest_model(arg1, v0)), 0x8238e878d724f642ba188226404489058e2546e92d52496d2a5bc74c9d67ef26::fixed_point32_empower::sub(0x8238e878d724f642ba188226404489058e2546e92d52496d2a5bc74c9d67ef26::fixed_point32_empower::from_u64(1), 0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::risk_model::liq_penalty(v4))), v5)), 0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::price::get_price(arg3, v3, arg4))), 0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::obligation::collateral(arg0, v3));
        let v9 = calc_liq_exchange_rate<T0, T1>(arg1, arg2, arg3, arg4);
        let v10 = 0x1::fixed_point32::divide_u64(v8, v9);
        let (v11, _) = 0xe43c9165051f207c76d4607a86394cc952d55099c91d4d818052c8f5c52070f3::obligation::debt(arg0, v0);
        if (v10 <= v11) {
            (v10, v8)
        } else {
            (v11, 0x1::fixed_point32::multiply_u64(v11, v9))
        }
    }

    // decompiled from Move bytecode v6
}

