module 0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::liquidation_evaluator {
    fun calc_liq_exchange_rate<T0, T1>(arg0: &0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::market::Market, arg1: &0x61f02204c9c3f56662b27ce7a29e935c2bce1917f51188f2a8aed5552505647b::coin_decimals_registry::CoinDecimalsRegistry, arg2: &0x39a8c5852036a052d196973795d48537f71bbb280616c878d7953cc1f98a79f2::x_oracle::XOracle, arg3: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x1::type_name::get<T1>();
        let v1 = 0x1::type_name::get<T0>();
        0x826f5bc822e65e0cd12528ea725e16c9752b5fa94c66e20c6732d7a866c1781a::fixed_point32_empower::div(0x826f5bc822e65e0cd12528ea725e16c9752b5fa94c66e20c6732d7a866c1781a::fixed_point32_empower::mul(0x1::fixed_point32::create_from_rational(0x2::math::pow(10, 0x61f02204c9c3f56662b27ce7a29e935c2bce1917f51188f2a8aed5552505647b::coin_decimals_registry::decimals(arg1, v0)), 0x2::math::pow(10, 0x61f02204c9c3f56662b27ce7a29e935c2bce1917f51188f2a8aed5552505647b::coin_decimals_registry::decimals(arg1, v1))), 0x826f5bc822e65e0cd12528ea725e16c9752b5fa94c66e20c6732d7a866c1781a::fixed_point32_empower::div(0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::price::get_price(arg2, v1, arg3), 0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::price::get_price(arg2, v0, arg3))), 0x826f5bc822e65e0cd12528ea725e16c9752b5fa94c66e20c6732d7a866c1781a::fixed_point32_empower::sub(0x826f5bc822e65e0cd12528ea725e16c9752b5fa94c66e20c6732d7a866c1781a::fixed_point32_empower::from_u64(1), 0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::risk_model::liq_discount(0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::market::risk_model(arg0, v0))))
    }

    public fun liquidation_amounts<T0, T1>(arg0: &0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::obligation::Obligation, arg1: &0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::market::Market, arg2: &0x61f02204c9c3f56662b27ce7a29e935c2bce1917f51188f2a8aed5552505647b::coin_decimals_registry::CoinDecimalsRegistry, arg3: u64, arg4: &0x39a8c5852036a052d196973795d48537f71bbb280616c878d7953cc1f98a79f2::x_oracle::XOracle, arg5: &0x2::clock::Clock) : (u64, u64, u64) {
        let (v0, v1) = max_liquidation_amounts<T0, T1>(arg0, arg1, arg2, arg4, arg5);
        if (v1 == 0) {
            return (0, 0, 0)
        };
        let (v2, v3) = if (arg3 >= v0) {
            (v0, v1)
        } else {
            (arg3, 0x1::fixed_point32::multiply_u64(arg3, calc_liq_exchange_rate<T0, T1>(arg1, arg2, arg4, arg5)))
        };
        let v4 = 0x1::fixed_point32::multiply_u64(v2, 0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::risk_model::liq_revenue_factor(0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::market::risk_model(arg1, 0x1::type_name::get<T1>())));
        (v2 - v4, v4, v3)
    }

    public fun max_liquidation_amounts<T0, T1>(arg0: &0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::obligation::Obligation, arg1: &0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::market::Market, arg2: &0x61f02204c9c3f56662b27ce7a29e935c2bce1917f51188f2a8aed5552505647b::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x39a8c5852036a052d196973795d48537f71bbb280616c878d7953cc1f98a79f2::x_oracle::XOracle, arg4: &0x2::clock::Clock) : (u64, u64) {
        let v0 = 0x1::type_name::get<T1>();
        let v1 = 0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::market::risk_model(arg1, v0);
        let v2 = 0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::risk_model::liq_factor(v1);
        let v3 = 0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::collateral_value::collaterals_value_usd_for_liquidation(arg0, arg1, arg2, arg3, arg4);
        let v4 = 0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::debt_value::debts_value_usd(arg0, arg2, arg3, arg4);
        if (!0x826f5bc822e65e0cd12528ea725e16c9752b5fa94c66e20c6732d7a866c1781a::fixed_point32_empower::gt(v4, v3)) {
            return (0, 0)
        };
        let v5 = 0x2::math::min(0x1::fixed_point32::multiply_u64(0x2::math::pow(10, 0x61f02204c9c3f56662b27ce7a29e935c2bce1917f51188f2a8aed5552505647b::coin_decimals_registry::decimals(arg2, v0)), 0x826f5bc822e65e0cd12528ea725e16c9752b5fa94c66e20c6732d7a866c1781a::fixed_point32_empower::div(0x826f5bc822e65e0cd12528ea725e16c9752b5fa94c66e20c6732d7a866c1781a::fixed_point32_empower::div(0x826f5bc822e65e0cd12528ea725e16c9752b5fa94c66e20c6732d7a866c1781a::fixed_point32_empower::sub(v4, v3), 0x826f5bc822e65e0cd12528ea725e16c9752b5fa94c66e20c6732d7a866c1781a::fixed_point32_empower::sub(0x826f5bc822e65e0cd12528ea725e16c9752b5fa94c66e20c6732d7a866c1781a::fixed_point32_empower::sub(0x826f5bc822e65e0cd12528ea725e16c9752b5fa94c66e20c6732d7a866c1781a::fixed_point32_empower::from_u64(1), 0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::risk_model::liq_penalty(v1)), v2)), 0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::price::get_price(arg3, v0, arg4))), 0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::obligation::collateral(arg0, v0));
        let v6 = calc_liq_exchange_rate<T0, T1>(arg1, arg2, arg3, arg4);
        let v7 = 0x1::fixed_point32::divide_u64(v5, v6);
        let (v8, _, _) = 0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::obligation::debt(arg0, 0x1::type_name::get<T0>());
        if (v7 <= v8) {
            (v7, v5)
        } else {
            (v8, 0x1::fixed_point32::multiply_u64(v8, v6))
        }
    }

    // decompiled from Move bytecode v6
}

