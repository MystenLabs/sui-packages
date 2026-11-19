module 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::forced_deleverage_evaluator {
    public fun calculate_forced_deleverage_amounts<T0, T1>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg1: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg2: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg3: &0x2::clock::Clock, arg4: u64) : (u64, u64) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        assert!(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::has_coin_x_as_debt(arg0, v0), 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::error::forced_deleverage_no_debt_error());
        assert!(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::has_coin_x_as_collateral(arg0, v1), 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::error::forced_deleverage_no_collateral_error());
        let (v2, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::debt(arg0, v0);
        let v4 = 0x2::math::min(arg4, v2);
        let v5 = (v4 as u256) * (0x1::fixed_point32::get_raw_value(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::price::get_price(arg2, v0, arg3)) as u256) * (0x2::math::pow(10, 0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::decimals(arg1, v1)) as u256) / (0x1::fixed_point32::get_raw_value(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::price::get_price(arg2, v1, arg3)) as u256) * (0x2::math::pow(10, 0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::decimals(arg1, v0)) as u256);
        let v6 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::collateral(arg0, v1);
        let (v7, v8) = if (v5 > (v6 as u256)) {
            ((((v4 as u256) * (v6 as u256) / v5) as u64), v6)
        } else {
            (v4, (v5 as u64))
        };
        assert!(v7 > 0, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::error::unable_to_force_deleverage_error());
        assert!(v8 > 0, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::error::unable_to_force_deleverage_error());
        (v7, v8)
    }

    // decompiled from Move bytecode v7
}

