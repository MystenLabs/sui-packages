module 0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::collateral_value {
    public fun collaterals_value_usd_for_borrow(arg0: &0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::obligation::Obligation, arg1: &0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::market::Market, arg2: &0xb5f004a43af64a6a75c07eab517f3b27567d58e2172c237c90e9b76db1328359::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x152f1e2b109013b019e15b5e31298cea5a104212c6e8019c682ee57cfe629e31::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::obligation::collateral_types(arg0);
        let v1 = 0x4da734d854aa74947d12b279395d57c626e3a56bce2db2e5af4f7d10d026f333::fixed_point32_empower::zero();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v2);
            v1 = 0x4da734d854aa74947d12b279395d57c626e3a56bce2db2e5af4f7d10d026f333::fixed_point32_empower::add(v1, 0x4da734d854aa74947d12b279395d57c626e3a56bce2db2e5af4f7d10d026f333::fixed_point32_empower::mul(0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::value_calculator::usd_value(0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::price::get_price(arg3, v3, arg4), 0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::obligation::collateral(arg0, v3), 0xb5f004a43af64a6a75c07eab517f3b27567d58e2172c237c90e9b76db1328359::coin_decimals_registry::decimals(arg2, v3)), 0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::risk_model::collateral_factor(0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::market::risk_model(arg1, v3))));
            v2 = v2 + 1;
        };
        v1
    }

    public fun collaterals_value_usd_for_liquidation(arg0: &0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::obligation::Obligation, arg1: &0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::market::Market, arg2: &0xb5f004a43af64a6a75c07eab517f3b27567d58e2172c237c90e9b76db1328359::coin_decimals_registry::CoinDecimalsRegistry, arg3: &0x152f1e2b109013b019e15b5e31298cea5a104212c6e8019c682ee57cfe629e31::x_oracle::XOracle, arg4: &0x2::clock::Clock) : 0x1::fixed_point32::FixedPoint32 {
        let v0 = 0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::obligation::collateral_types(arg0);
        let v1 = 0x4da734d854aa74947d12b279395d57c626e3a56bce2db2e5af4f7d10d026f333::fixed_point32_empower::zero();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v2);
            v1 = 0x4da734d854aa74947d12b279395d57c626e3a56bce2db2e5af4f7d10d026f333::fixed_point32_empower::add(v1, 0x4da734d854aa74947d12b279395d57c626e3a56bce2db2e5af4f7d10d026f333::fixed_point32_empower::mul(0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::value_calculator::usd_value(0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::price::get_price(arg3, v3, arg4), 0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::obligation::collateral(arg0, v3), 0xb5f004a43af64a6a75c07eab517f3b27567d58e2172c237c90e9b76db1328359::coin_decimals_registry::decimals(arg2, v3)), 0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::risk_model::liq_factor(0x50354714e99a1ea2c23f623c57c7aa4a217c6da9cd0b659cd2cc5fe579624ded::market::risk_model(arg1, v3))));
            v2 = v2 + 1;
        };
        v1
    }

    // decompiled from Move bytecode v6
}

