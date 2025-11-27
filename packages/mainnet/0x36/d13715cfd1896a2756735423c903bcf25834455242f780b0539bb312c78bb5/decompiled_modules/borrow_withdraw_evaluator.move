module 0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::borrow_withdraw_evaluator {
    public fun available_borrow_amount_in_usd(arg0: &0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::obligation::Obligation, arg1: &0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::market::Market, arg2: &0x5eca23353c3cd5e3a57d5d9e7c90358a770d14c2e1ce831731eb8934bb9c571d::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x8e226848f7984ca4eb396f3bbcf361ba761e82e50e0b42efeff842d6ed4ac013::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::collateral_value::collaterals_value_usd_for_borrow(arg0, arg1, arg2, arg3, arg4);
        let v1 = 0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::debt_value::debts_value_usd(arg0, arg2, arg3, arg4);
        if (0x77431d018d2682972dc7e198b08643848774a7007df97aa227704f87f127d74c::fixed_point32_empower::gt(v0, v1)) {
            0x77431d018d2682972dc7e198b08643848774a7007df97aa227704f87f127d74c::fixed_point32_empower::sub(v0, v1)
        } else {
            0x77431d018d2682972dc7e198b08643848774a7007df97aa227704f87f127d74c::fixed_point32_empower::zero()
        }
    }

    public fun max_borrow_amount<T0>(arg0: &0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::obligation::Obligation, arg1: &0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::market::Market, arg2: &0x5eca23353c3cd5e3a57d5d9e7c90358a770d14c2e1ce831731eb8934bb9c571d::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x8e226848f7984ca4eb396f3bbcf361ba761e82e50e0b42efeff842d6ed4ac013::x_oracle::XOracle, arg4: &0x2::clock::Clock) : u64 {
        let v0 = available_borrow_amount_in_usd(arg0, arg1, arg2, arg3, arg4);
        if (0x77431d018d2682972dc7e198b08643848774a7007df97aa227704f87f127d74c::fixed_point32_empower::gt(v0, 0x77431d018d2682972dc7e198b08643848774a7007df97aa227704f87f127d74c::fixed_point32_empower::zero())) {
            let v2 = 0x1::type_name::get<T0>();
            0x1::fixed_point32::multiply_u64(0x2::math::pow(10, 0x5eca23353c3cd5e3a57d5d9e7c90358a770d14c2e1ce831731eb8934bb9c571d::coin_decimals_registry::decimals(arg2, v2)), 0x77431d018d2682972dc7e198b08643848774a7007df97aa227704f87f127d74c::fixed_point32_empower::div(v0, 0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::price::get_price(arg3, v2, arg4)))
        } else {
            0
        }
    }

    public fun max_withdraw_amount<T0>(arg0: &0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::obligation::Obligation, arg1: &0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::market::Market, arg2: &0x5eca23353c3cd5e3a57d5d9e7c90358a770d14c2e1ce831731eb8934bb9c571d::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x8e226848f7984ca4eb396f3bbcf361ba761e82e50e0b42efeff842d6ed4ac013::x_oracle::XOracle, arg4: &0x2::clock::Clock) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (0x1::fixed_point32::is_zero(0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::debt_value::debts_value_usd(arg0, arg2, arg3, arg4))) {
            return 0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::obligation::collateral(arg0, v0)
        };
        let v1 = available_borrow_amount_in_usd(arg0, arg1, arg2, arg3, arg4);
        let v2 = 0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::risk_model::collateral_factor(0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::market::risk_model(arg1, v0));
        if (0x1::fixed_point32::is_zero(v2)) {
            return if (!0x1::fixed_point32::is_zero(v1)) {
                0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::obligation::collateral(arg0, v0)
            } else {
                0
            }
        };
        0x2::math::min(0x1::fixed_point32::divide_u64(0x1::fixed_point32::multiply_u64(0x2::math::pow(10, 0x5eca23353c3cd5e3a57d5d9e7c90358a770d14c2e1ce831731eb8934bb9c571d::coin_decimals_registry::decimals(arg2, v0)), 0x77431d018d2682972dc7e198b08643848774a7007df97aa227704f87f127d74c::fixed_point32_empower::div(v1, 0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::price::get_price(arg3, v0, arg4))), v2), 0x36d13715cfd1896a2756735423c903bcf25834455242f780b0539bb312c78bb5::obligation::collateral(arg0, v0))
    }

    // decompiled from Move bytecode v6
}

