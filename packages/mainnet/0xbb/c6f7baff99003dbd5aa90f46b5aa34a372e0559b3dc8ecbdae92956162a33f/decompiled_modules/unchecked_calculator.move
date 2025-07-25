module 0xbbc6f7baff99003dbd5aa90f46b5aa34a372e0559b3dc8ecbdae92956162a33f::unchecked_calculator {
    public fun calculate_value(arg0: &0x2::clock::Clock, arg1: &0xe2e7f32c9b203878e79afcbc76d48552641727aae0c35142c7e51ab9efeb0c09::oracle::PriceOracle, arg2: u256, arg3: u8) : u256 {
        let (_, v1, v2) = 0xe2e7f32c9b203878e79afcbc76d48552641727aae0c35142c7e51ab9efeb0c09::oracle::get_token_price(arg0, arg1, arg3);
        arg2 * v1 / (0x2::math::pow(10, v2) as u256)
    }

    // decompiled from Move bytecode v6
}

