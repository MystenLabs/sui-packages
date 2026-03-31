module 0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::borrow_withdraw_evaluator {
    public fun available_borrow_amount_in_usd(arg0: &0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::obligation::Obligation, arg1: &0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::market::Market, arg2: &0x61f02204c9c3f56662b27ce7a29e935c2bce1917f51188f2a8aed5552505647b::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x39a8c5852036a052d196973795d48537f71bbb280616c878d7953cc1f98a79f2::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::collateral_value::collaterals_value_usd_for_borrow(arg0, arg1, arg2, arg3, arg4);
        let v1 = 0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::debt_value::debts_value_usd(arg0, arg2, arg3, arg4);
        if (0x826f5bc822e65e0cd12528ea725e16c9752b5fa94c66e20c6732d7a866c1781a::fixed_point32_empower::gt(v0, v1)) {
            0x826f5bc822e65e0cd12528ea725e16c9752b5fa94c66e20c6732d7a866c1781a::fixed_point32_empower::sub(v0, v1)
        } else {
            0x826f5bc822e65e0cd12528ea725e16c9752b5fa94c66e20c6732d7a866c1781a::fixed_point32_empower::zero()
        }
    }

    public fun max_borrow_amount<T0>(arg0: &0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::obligation::Obligation, arg1: &0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::market::Market, arg2: &0x61f02204c9c3f56662b27ce7a29e935c2bce1917f51188f2a8aed5552505647b::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x39a8c5852036a052d196973795d48537f71bbb280616c878d7953cc1f98a79f2::x_oracle::XOracle, arg4: &0x2::clock::Clock) : u64 {
        let v0 = available_borrow_amount_in_usd(arg0, arg1, arg2, arg3, arg4);
        if (0x826f5bc822e65e0cd12528ea725e16c9752b5fa94c66e20c6732d7a866c1781a::fixed_point32_empower::gt(v0, 0x826f5bc822e65e0cd12528ea725e16c9752b5fa94c66e20c6732d7a866c1781a::fixed_point32_empower::zero())) {
            let v2 = 0x1::type_name::get<T0>();
            0x1::fixed_point32::multiply_u64(0x2::math::pow(10, 0x61f02204c9c3f56662b27ce7a29e935c2bce1917f51188f2a8aed5552505647b::coin_decimals_registry::decimals(arg2, v2)), 0x826f5bc822e65e0cd12528ea725e16c9752b5fa94c66e20c6732d7a866c1781a::fixed_point32_empower::div(v0, 0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::price::get_price(arg3, v2, arg4)))
        } else {
            0
        }
    }

    public fun max_withdraw_amount<T0>(arg0: &0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::obligation::Obligation, arg1: &0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::market::Market, arg2: &0x61f02204c9c3f56662b27ce7a29e935c2bce1917f51188f2a8aed5552505647b::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x39a8c5852036a052d196973795d48537f71bbb280616c878d7953cc1f98a79f2::x_oracle::XOracle, arg4: &0x2::clock::Clock) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (0x1::fixed_point32::is_zero(0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::debt_value::debts_value_usd(arg0, arg2, arg3, arg4))) {
            return 0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::obligation::collateral(arg0, v0)
        };
        let v1 = available_borrow_amount_in_usd(arg0, arg1, arg2, arg3, arg4);
        let v2 = 0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::risk_model::collateral_factor(0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::market::risk_model(arg1, v0));
        if (0x1::fixed_point32::is_zero(v2)) {
            return if (!0x1::fixed_point32::is_zero(v1)) {
                0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::obligation::collateral(arg0, v0)
            } else {
                0
            }
        };
        0x2::math::min(0x1::fixed_point32::divide_u64(0x1::fixed_point32::multiply_u64(0x2::math::pow(10, 0x61f02204c9c3f56662b27ce7a29e935c2bce1917f51188f2a8aed5552505647b::coin_decimals_registry::decimals(arg2, v0)), 0x826f5bc822e65e0cd12528ea725e16c9752b5fa94c66e20c6732d7a866c1781a::fixed_point32_empower::div(v1, 0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::price::get_price(arg3, v0, arg4))), v2), 0xb8adce96346c5c9c7c3a3ac02ca35712d36a58952d4a727a225c6ef5cc159f2::obligation::collateral(arg0, v0))
    }

    // decompiled from Move bytecode v6
}

