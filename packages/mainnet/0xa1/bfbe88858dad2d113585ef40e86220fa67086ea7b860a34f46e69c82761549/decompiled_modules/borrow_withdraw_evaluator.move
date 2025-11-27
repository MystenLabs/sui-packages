module 0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::borrow_withdraw_evaluator {
    public fun available_borrow_amount_in_usd(arg0: &0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::obligation::Obligation, arg1: &0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::market::Market, arg2: &0x85f92dbca022a519c6071cc358948a2e8c398fc9aed167cb1f0b0288bf9a1479::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x64d704ec79adb95f308732d510907b6673db75fb3edabb3f7dc1e527094d3143::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::collateral_value::collaterals_value_usd_for_borrow(arg0, arg1, arg2, arg3, arg4);
        let v1 = 0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::debt_value::debts_value_usd(arg0, arg2, arg3, arg4);
        if (0xb7bf1daa413c2d5357f9d0323234a664a1bbf49c1565a72264035f98c37365cf::fixed_point32_empower::gt(v0, v1)) {
            0xb7bf1daa413c2d5357f9d0323234a664a1bbf49c1565a72264035f98c37365cf::fixed_point32_empower::sub(v0, v1)
        } else {
            0xb7bf1daa413c2d5357f9d0323234a664a1bbf49c1565a72264035f98c37365cf::fixed_point32_empower::zero()
        }
    }

    public fun max_borrow_amount<T0>(arg0: &0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::obligation::Obligation, arg1: &0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::market::Market, arg2: &0x85f92dbca022a519c6071cc358948a2e8c398fc9aed167cb1f0b0288bf9a1479::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x64d704ec79adb95f308732d510907b6673db75fb3edabb3f7dc1e527094d3143::x_oracle::XOracle, arg4: &0x2::clock::Clock) : u64 {
        let v0 = available_borrow_amount_in_usd(arg0, arg1, arg2, arg3, arg4);
        if (0xb7bf1daa413c2d5357f9d0323234a664a1bbf49c1565a72264035f98c37365cf::fixed_point32_empower::gt(v0, 0xb7bf1daa413c2d5357f9d0323234a664a1bbf49c1565a72264035f98c37365cf::fixed_point32_empower::zero())) {
            let v2 = 0x1::type_name::get<T0>();
            0x1::fixed_point32::multiply_u64(0x2::math::pow(10, 0x85f92dbca022a519c6071cc358948a2e8c398fc9aed167cb1f0b0288bf9a1479::coin_decimals_registry::decimals(arg2, v2)), 0xb7bf1daa413c2d5357f9d0323234a664a1bbf49c1565a72264035f98c37365cf::fixed_point32_empower::div(v0, 0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::price::get_price(arg3, v2, arg4)))
        } else {
            0
        }
    }

    public fun max_withdraw_amount<T0>(arg0: &0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::obligation::Obligation, arg1: &0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::market::Market, arg2: &0x85f92dbca022a519c6071cc358948a2e8c398fc9aed167cb1f0b0288bf9a1479::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x64d704ec79adb95f308732d510907b6673db75fb3edabb3f7dc1e527094d3143::x_oracle::XOracle, arg4: &0x2::clock::Clock) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (0x1::fixed_point32::is_zero(0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::debt_value::debts_value_usd(arg0, arg2, arg3, arg4))) {
            return 0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::obligation::collateral(arg0, v0)
        };
        let v1 = available_borrow_amount_in_usd(arg0, arg1, arg2, arg3, arg4);
        let v2 = 0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::risk_model::collateral_factor(0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::market::risk_model(arg1, v0));
        if (0x1::fixed_point32::is_zero(v2)) {
            return if (!0x1::fixed_point32::is_zero(v1)) {
                0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::obligation::collateral(arg0, v0)
            } else {
                0
            }
        };
        0x2::math::min(0x1::fixed_point32::divide_u64(0x1::fixed_point32::multiply_u64(0x2::math::pow(10, 0x85f92dbca022a519c6071cc358948a2e8c398fc9aed167cb1f0b0288bf9a1479::coin_decimals_registry::decimals(arg2, v0)), 0xb7bf1daa413c2d5357f9d0323234a664a1bbf49c1565a72264035f98c37365cf::fixed_point32_empower::div(v1, 0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::price::get_price(arg3, v0, arg4))), v2), 0xa1bfbe88858dad2d113585ef40e86220fa67086ea7b860a34f46e69c82761549::obligation::collateral(arg0, v0))
    }

    // decompiled from Move bytecode v6
}

