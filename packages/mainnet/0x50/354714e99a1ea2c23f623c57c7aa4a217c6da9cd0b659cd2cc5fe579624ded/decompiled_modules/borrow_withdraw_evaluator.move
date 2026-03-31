module 0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::borrow_withdraw_evaluator {
    public fun available_borrow_amount_in_usd(arg0: &0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::obligation::Obligation, arg1: &0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::market::Market, arg2: &0xb5f004a43af64a6a75c07eab517f3b27567d58e2172c237c90e9b76db1328359::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x152f1e2b109013b019e15b5e31298cea5a104212c6e8019c682ee57cfe629e31::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::collateral_value::collaterals_value_usd_for_borrow(arg0, arg1, arg2, arg3, arg4);
        let v1 = 0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::debt_value::debts_value_usd(arg0, arg2, arg3, arg4);
        if (0x4da734d854aa74947d12b279395d57c626e3a56bce2db2e5af4f7d10d026f333::fixed_point32_empower::gt(v0, v1)) {
            0x4da734d854aa74947d12b279395d57c626e3a56bce2db2e5af4f7d10d026f333::fixed_point32_empower::sub(v0, v1)
        } else {
            0x4da734d854aa74947d12b279395d57c626e3a56bce2db2e5af4f7d10d026f333::fixed_point32_empower::zero()
        }
    }

    public fun max_borrow_amount<T0>(arg0: &0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::obligation::Obligation, arg1: &0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::market::Market, arg2: &0xb5f004a43af64a6a75c07eab517f3b27567d58e2172c237c90e9b76db1328359::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x152f1e2b109013b019e15b5e31298cea5a104212c6e8019c682ee57cfe629e31::x_oracle::XOracle, arg4: &0x2::clock::Clock) : u64 {
        let v0 = available_borrow_amount_in_usd(arg0, arg1, arg2, arg3, arg4);
        if (0x4da734d854aa74947d12b279395d57c626e3a56bce2db2e5af4f7d10d026f333::fixed_point32_empower::gt(v0, 0x4da734d854aa74947d12b279395d57c626e3a56bce2db2e5af4f7d10d026f333::fixed_point32_empower::zero())) {
            let v2 = 0x1::type_name::get<T0>();
            0x1::fixed_point32::multiply_u64(0x2::math::pow(10, 0xb5f004a43af64a6a75c07eab517f3b27567d58e2172c237c90e9b76db1328359::coin_decimals_registry::decimals(arg2, v2)), 0x4da734d854aa74947d12b279395d57c626e3a56bce2db2e5af4f7d10d026f333::fixed_point32_empower::div(v0, 0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::price::get_price(arg3, v2, arg4)))
        } else {
            0
        }
    }

    public fun max_withdraw_amount<T0>(arg0: &0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::obligation::Obligation, arg1: &0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::market::Market, arg2: &0xb5f004a43af64a6a75c07eab517f3b27567d58e2172c237c90e9b76db1328359::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x152f1e2b109013b019e15b5e31298cea5a104212c6e8019c682ee57cfe629e31::x_oracle::XOracle, arg4: &0x2::clock::Clock) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (0x1::fixed_point32::is_zero(0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::debt_value::debts_value_usd(arg0, arg2, arg3, arg4))) {
            return 0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::obligation::collateral(arg0, v0)
        };
        let v1 = available_borrow_amount_in_usd(arg0, arg1, arg2, arg3, arg4);
        let v2 = 0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::risk_model::collateral_factor(0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::market::risk_model(arg1, v0));
        if (0x1::fixed_point32::is_zero(v2)) {
            return if (!0x1::fixed_point32::is_zero(v1)) {
                0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::obligation::collateral(arg0, v0)
            } else {
                0
            }
        };
        0x2::math::min(0x1::fixed_point32::divide_u64(0x1::fixed_point32::multiply_u64(0x2::math::pow(10, 0xb5f004a43af64a6a75c07eab517f3b27567d58e2172c237c90e9b76db1328359::coin_decimals_registry::decimals(arg2, v0)), 0x4da734d854aa74947d12b279395d57c626e3a56bce2db2e5af4f7d10d026f333::fixed_point32_empower::div(v1, 0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::price::get_price(arg3, v0, arg4))), v2), 0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::obligation::collateral(arg0, v0))
    }

    // decompiled from Move bytecode v6
}

