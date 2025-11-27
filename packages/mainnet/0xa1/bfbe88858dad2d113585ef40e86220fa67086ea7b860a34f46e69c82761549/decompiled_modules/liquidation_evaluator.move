module 0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::liquidation_evaluator {
    fun calc_liq_exchange_rate<T0, T1>(arg0: &0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::market::Market, arg1: &0x85f92dbca022a519c6071cc358948a2e8c398fc9aed167cb1f0b0288bf9a1479::coin_decimals_registry::CoinDecimalsRegistry, arg2: &0x64d704ec79adb95f308732d510907b6673db75fb3edabb3f7dc1e527094d3143::x_oracle::XOracle, arg3: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x1::type_name::get<T1>();
        let v1 = 0x1::type_name::get<T0>();
        0xb7bf1daa413c2d5357f9d0323234a664a1bbf49c1565a72264035f98c37365cf::fixed_point32_empower::div(0xb7bf1daa413c2d5357f9d0323234a664a1bbf49c1565a72264035f98c37365cf::fixed_point32_empower::mul(0x1::fixed_point32::create_from_rational(0x2::math::pow(10, 0x85f92dbca022a519c6071cc358948a2e8c398fc9aed167cb1f0b0288bf9a1479::coin_decimals_registry::decimals(arg1, v0)), 0x2::math::pow(10, 0x85f92dbca022a519c6071cc358948a2e8c398fc9aed167cb1f0b0288bf9a1479::coin_decimals_registry::decimals(arg1, v1))), 0xb7bf1daa413c2d5357f9d0323234a664a1bbf49c1565a72264035f98c37365cf::fixed_point32_empower::div(0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::price::get_price(arg2, v1, arg3), 0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::price::get_price(arg2, v0, arg3))), 0xb7bf1daa413c2d5357f9d0323234a664a1bbf49c1565a72264035f98c37365cf::fixed_point32_empower::sub(0xb7bf1daa413c2d5357f9d0323234a664a1bbf49c1565a72264035f98c37365cf::fixed_point32_empower::from_u64(1), 0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::risk_model::liq_discount(0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::market::risk_model(arg0, v0))))
    }

    public fun liquidation_amounts<T0, T1>(arg0: &0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::obligation::Obligation, arg1: &0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::market::Market, arg2: &0x85f92dbca022a519c6071cc358948a2e8c398fc9aed167cb1f0b0288bf9a1479::coin_decimals_registry::CoinDecimalsRegistry, arg3: u64, arg4: &0x64d704ec79adb95f308732d510907b6673db75fb3edabb3f7dc1e527094d3143::x_oracle::XOracle, arg5: &0x2::clock::Clock) : (u64, u64, u64) {
        let (v0, v1) = max_liquidation_amounts<T0, T1>(arg0, arg1, arg2, arg4, arg5);
        if (v1 == 0) {
            return (0, 0, 0)
        };
        let (v2, v3) = if (arg3 >= v0) {
            (v0, v1)
        } else {
            (arg3, 0x1::fixed_point32::multiply_u64(arg3, calc_liq_exchange_rate<T0, T1>(arg1, arg2, arg4, arg5)))
        };
        let v4 = 0x1::fixed_point32::multiply_u64(v2, 0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::risk_model::liq_revenue_factor(0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::market::risk_model(arg1, 0x1::type_name::get<T1>())));
        (v2 - v4, v4, v3)
    }

    public fun max_liquidation_amounts<T0, T1>(arg0: &0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::obligation::Obligation, arg1: &0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::market::Market, arg2: &0x85f92dbca022a519c6071cc358948a2e8c398fc9aed167cb1f0b0288bf9a1479::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x64d704ec79adb95f308732d510907b6673db75fb3edabb3f7dc1e527094d3143::x_oracle::XOracle, arg4: &0x2::clock::Clock) : (u64, u64) {
        let v0 = 0x1::type_name::get<T1>();
        let v1 = 0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::market::risk_model(arg1, v0);
        let v2 = 0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::risk_model::liq_factor(v1);
        let v3 = 0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::collateral_value::collaterals_value_usd_for_liquidation(arg0, arg1, arg2, arg3, arg4);
        let v4 = 0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::debt_value::debts_value_usd(arg0, arg2, arg3, arg4);
        if (!0xb7bf1daa413c2d5357f9d0323234a664a1bbf49c1565a72264035f98c37365cf::fixed_point32_empower::gt(v4, v3)) {
            return (0, 0)
        };
        let v5 = 0x2::math::min(0x1::fixed_point32::multiply_u64(0x2::math::pow(10, 0x85f92dbca022a519c6071cc358948a2e8c398fc9aed167cb1f0b0288bf9a1479::coin_decimals_registry::decimals(arg2, v0)), 0xb7bf1daa413c2d5357f9d0323234a664a1bbf49c1565a72264035f98c37365cf::fixed_point32_empower::div(0xb7bf1daa413c2d5357f9d0323234a664a1bbf49c1565a72264035f98c37365cf::fixed_point32_empower::div(0xb7bf1daa413c2d5357f9d0323234a664a1bbf49c1565a72264035f98c37365cf::fixed_point32_empower::sub(v4, v3), 0xb7bf1daa413c2d5357f9d0323234a664a1bbf49c1565a72264035f98c37365cf::fixed_point32_empower::sub(0xb7bf1daa413c2d5357f9d0323234a664a1bbf49c1565a72264035f98c37365cf::fixed_point32_empower::sub(0xb7bf1daa413c2d5357f9d0323234a664a1bbf49c1565a72264035f98c37365cf::fixed_point32_empower::from_u64(1), 0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::risk_model::liq_penalty(v1)), v2)), 0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::price::get_price(arg3, v0, arg4))), 0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::obligation::collateral(arg0, v0));
        let v6 = calc_liq_exchange_rate<T0, T1>(arg1, arg2, arg3, arg4);
        let v7 = 0x1::fixed_point32::divide_u64(v5, v6);
        let (v8, _, _) = 0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::obligation::debt(arg0, 0x1::type_name::get<T0>());
        if (v7 <= v8) {
            (v7, v5)
        } else {
            (v8, 0x1::fixed_point32::multiply_u64(v8, v6))
        }
    }

    // decompiled from Move bytecode v6
}

