module 0x968dd4d6cae5bc771f4104732697b723ec0db66a9e1e5b7e93050ab78d1ebfaa::m7a7e81da154c36ef4ac021f2 {
    public fun f33eabca9cfbe9e48675b5d1a<T0>(arg0: &mut 0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOraclePriceUpdateRequest<T0>, arg1: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::state::State, arg2: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg3: &0x71fddacc6ecf164bd8f6c081092beeef20945c5da2c74e0b9f3e1d3c7003fadd::pyth_registry::PythRegistry, arg4: &0x2::clock::Clock) {
        0x71fddacc6ecf164bd8f6c081092beeef20945c5da2c74e0b9f3e1d3c7003fadd::rule::set_price_as_primary<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

