module 0x2ddd0d42028be061697e3faf946ad1c4011a5c9714d540a1527fb7dc9ad3bd4e::unchecked_calculator {
    public fun calculate_value(arg0: &0x2::clock::Clock, arg1: &0x63862ceed047505130b7625184dc571e545b26e42a5b7033ddc56258315b1d0d::oracle::PriceOracle, arg2: u256, arg3: u8) : u256 {
        let (_, v1, v2) = 0x63862ceed047505130b7625184dc571e545b26e42a5b7033ddc56258315b1d0d::oracle::get_token_price(arg0, arg1, arg3);
        arg2 * v1 / (0x2::math::pow(10, v2) as u256)
    }

    // decompiled from Move bytecode v7
}

