module 0x9216987239f4c45e3dbf5d8f63d841e94d09544aaeb023562f1c192c58bfeb55::unchecked_calculator {
    public fun calculate_value(arg0: &0x2::clock::Clock, arg1: &0x63862ceed047505130b7625184dc571e545b26e42a5b7033ddc56258315b1d0d::oracle::PriceOracle, arg2: u256, arg3: u8) : u256 {
        let (_, v1, v2) = 0x63862ceed047505130b7625184dc571e545b26e42a5b7033ddc56258315b1d0d::oracle::get_token_price(arg0, arg1, arg3);
        arg2 * v1 / (0x2::math::pow(10, v2) as u256)
    }

    // decompiled from Move bytecode v7
}

