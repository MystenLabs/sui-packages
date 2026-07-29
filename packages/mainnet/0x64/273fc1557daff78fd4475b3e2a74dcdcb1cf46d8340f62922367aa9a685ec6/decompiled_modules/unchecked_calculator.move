module 0x64273fc1557daff78fd4475b3e2a74dcdcb1cf46d8340f62922367aa9a685ec6::unchecked_calculator {
    public fun calculate_value(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: u256, arg3: u8) : u256 {
        let (_, v1, v2) = 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::get_token_price(arg0, arg1, arg3);
        arg2 * v1 / (0x2::math::pow(10, v2) as u256)
    }

    // decompiled from Move bytecode v7
}

