module 0xb001591a1ff5c17febfca5bd80e24ef7ec63a7c4b3fb263330a38ed4db18352e::unchecked_calculator {
    public fun calculate_value(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: u256, arg3: u8) : u256 {
        let (_, v1, v2) = 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::get_token_price(arg0, arg1, arg3);
        arg2 * v1 / (0x2::math::pow(10, v2) as u256)
    }

    // decompiled from Move bytecode v6
}

