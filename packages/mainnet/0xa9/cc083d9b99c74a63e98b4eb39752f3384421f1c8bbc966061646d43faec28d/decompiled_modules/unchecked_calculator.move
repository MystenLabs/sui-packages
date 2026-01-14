module 0xa9cc083d9b99c74a63e98b4eb39752f3384421f1c8bbc966061646d43faec28d::unchecked_calculator {
    public fun calculate_value(arg0: &0x2::clock::Clock, arg1: &0xe0c5c718964d8399d8155dd5434263346b2c82e339dbefa477684220e7f7c524::oracle::PriceOracle, arg2: u256, arg3: u8) : u256 {
        let (_, v1, v2) = 0xe0c5c718964d8399d8155dd5434263346b2c82e339dbefa477684220e7f7c524::oracle::get_token_price(arg0, arg1, arg3);
        arg2 * v1 / (0x2::math::pow(10, v2) as u256)
    }

    // decompiled from Move bytecode v6
}

