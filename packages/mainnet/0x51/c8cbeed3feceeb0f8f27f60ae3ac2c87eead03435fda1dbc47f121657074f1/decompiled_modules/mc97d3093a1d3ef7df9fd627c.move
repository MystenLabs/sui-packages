module 0x51c8cbeed3feceeb0f8f27f60ae3ac2c87eead03435fda1dbc47f121657074f1::mc97d3093a1d3ef7df9fd627c {
    public fun f2def654e32638c3ab0a95e3c<T0>(arg0: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOraclePriceUpdateRequest<T0>, arg1: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::state::State, arg2: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg3: &0x71fddacc6ecf164bd8f6c081092beeef20945c5da2c74e0b9f3e1d3c7003fadd::pyth_registry::PythRegistry, arg4: &0x2::clock::Clock) {
        0x71fddacc6ecf164bd8f6c081092beeef20945c5da2c74e0b9f3e1d3c7003fadd::rule::set_price_as_primary<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

