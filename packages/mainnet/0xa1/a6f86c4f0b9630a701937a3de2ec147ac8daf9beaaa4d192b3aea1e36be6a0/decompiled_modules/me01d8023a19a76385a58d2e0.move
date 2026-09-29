module 0xa1a6f86c4f0b9630a701937a3de2ec147ac8daf9beaaa4d192b3aea1e36be6a0::me01d8023a19a76385a58d2e0 {
    public fun f59e7efd0127bb0dea0991ebe<T0>(arg0: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg1: 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOraclePriceUpdateRequest<T0>, arg2: &0x2::clock::Clock) {
        0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T0>(arg0, arg1, arg2);
    }

    public fun f7481907dfe8247e5402974b3<T0>(arg0: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle) : 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOraclePriceUpdateRequest<T0> {
        0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T0>(arg0)
    }

    // decompiled from Move bytecode v7
}

