module 0xf47f46d755e088851fa31fb7aa27e3bf8716e40efc1e1f33cbb28bc6fce3ce93::m5aad87d5e0b90ee4a427fc5f {
    public fun f0ddeee8ba7a8673df24ab139<T0>(arg0: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOraclePriceUpdateRequest<T0>, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x1cf913c825c202cbbb71c378edccb9c04723fa07a73b88677b2ef89c6e203a85::pyth_registry::PythRegistry, arg4: &0x2::clock::Clock) {
        0x1cf913c825c202cbbb71c378edccb9c04723fa07a73b88677b2ef89c6e203a85::rule::set_price_as_primary<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

