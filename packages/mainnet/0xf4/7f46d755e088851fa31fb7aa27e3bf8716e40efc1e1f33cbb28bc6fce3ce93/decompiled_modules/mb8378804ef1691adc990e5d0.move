module 0xf47f46d755e088851fa31fb7aa27e3bf8716e40efc1e1f33cbb28bc6fce3ce93::mb8378804ef1691adc990e5d0 {
    public fun f4fbdf48c2cdd9dd12ff14c9e<T0>(arg0: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg1: 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOraclePriceUpdateRequest<T0>, arg2: &0x2::clock::Clock) {
        0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T0>(arg0, arg1, arg2);
    }

    public fun f647cd171b29ec556a39c07f9<T0>(arg0: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle) : 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOraclePriceUpdateRequest<T0> {
        0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T0>(arg0)
    }

    // decompiled from Move bytecode v7
}

