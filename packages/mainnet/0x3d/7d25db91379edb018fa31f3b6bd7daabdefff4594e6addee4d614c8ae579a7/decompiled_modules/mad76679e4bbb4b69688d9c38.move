module 0x3d7d25db91379edb018fa31f3b6bd7daabdefff4594e6addee4d614c8ae579a7::mad76679e4bbb4b69688d9c38 {
    public fun f6963bceab0fa320425f76dcb<T0>(arg0: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg1: 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOraclePriceUpdateRequest<T0>, arg2: &0x2::clock::Clock) {
        0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T0>(arg0, arg1, arg2);
    }

    public fun f739cf4b066313e9d04bc46d9<T0>(arg0: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle) : 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOraclePriceUpdateRequest<T0> {
        0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T0>(arg0)
    }

    // decompiled from Move bytecode v7
}

