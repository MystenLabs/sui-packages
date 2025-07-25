module 0x4fbc83a3d40b24b411cdfe68e5a43620c909a9c0dc4b44e9a52f48853d28035d::unchecked_calculator {
    public fun calculate_value(arg0: &0x2::clock::Clock, arg1: &0x244b3603f06260b1ad7c8953fd8cf38e137d3057ec56c0f283325eca3db20c07::oracle::PriceOracle, arg2: u256, arg3: u8) : u256 {
        let (_, v1, v2) = 0x244b3603f06260b1ad7c8953fd8cf38e137d3057ec56c0f283325eca3db20c07::oracle::get_token_price(arg0, arg1, arg3);
        arg2 * v1 / (0x2::math::pow(10, v2) as u256)
    }

    // decompiled from Move bytecode v6
}

