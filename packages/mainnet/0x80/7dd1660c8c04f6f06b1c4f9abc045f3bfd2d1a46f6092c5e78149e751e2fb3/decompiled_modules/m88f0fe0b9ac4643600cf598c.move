module 0x807dd1660c8c04f6f06b1c4f9abc045f3bfd2d1a46f6092c5e78149e751e2fb3::m88f0fe0b9ac4643600cf598c {
    public fun f9970312c366caa16f41c920d<T0>(arg0: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg1: 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOraclePriceUpdateRequest<T0>, arg2: &0x2::clock::Clock) {
        0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::confirm_price_update_request<T0>(arg0, arg1, arg2);
    }

    public fun fa2f7ec0d865dbd4ff4ad2db2<T0>(arg0: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle) : 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOraclePriceUpdateRequest<T0> {
        0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::price_update_request<T0>(arg0)
    }

    // decompiled from Move bytecode v7
}

