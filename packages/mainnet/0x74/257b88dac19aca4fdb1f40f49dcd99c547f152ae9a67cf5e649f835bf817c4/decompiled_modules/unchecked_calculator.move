module 0x74257b88dac19aca4fdb1f40f49dcd99c547f152ae9a67cf5e649f835bf817c4::unchecked_calculator {
    public fun calculate_value(arg0: &0x2::clock::Clock, arg1: &0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::PriceOracle, arg2: u256, arg3: u8) : u256 {
        let (_, v1, v2) = 0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::get_token_price(arg0, arg1, arg3);
        arg2 * v1 / (0x2::math::pow(10, v2) as u256)
    }

    // decompiled from Move bytecode v6
}

