module 0xc9432ba03b31d6eac024dea04618f6ff87f9d0977f0c599eccb69743c427608a::mcee3d0ece345b015c19cf9bd {
    public fun f468539fd09232e7ac08f85be<T0>(arg0: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOraclePriceUpdateRequest<T0>, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x1cf913c825c202cbbb71c378edccb9c04723fa07a73b88677b2ef89c6e203a85::pyth_registry::PythRegistry, arg4: &0x2::clock::Clock) {
        0x1cf913c825c202cbbb71c378edccb9c04723fa07a73b88677b2ef89c6e203a85::rule::set_price_as_primary<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

