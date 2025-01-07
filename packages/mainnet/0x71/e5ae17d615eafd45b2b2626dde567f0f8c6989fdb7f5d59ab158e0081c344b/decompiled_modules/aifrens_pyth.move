module 0x71e5ae17d615eafd45b2b2626dde567f0f8c6989fdb7f5d59ab158e0081c344b::aifrens_pyth {
    public fun update_price(arg0: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg1: &0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::state::State, arg2: 0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_info::PriceInfoObject, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: vector<u8>, arg5: &0x2::clock::Clock) {
        let v0 = 0x1::vector::empty<0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::VAA>();
        0x1::vector::push_back<0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::VAA>(&mut v0, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg0, arg4, arg5));
        let v1 = 0x1::vector::empty<0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_info::PriceInfoObject>();
        0x1::vector::push_back<0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_info::PriceInfoObject>(&mut v1, arg2);
        0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::pyth::update_price_feeds(arg1, v0, &mut v1, arg3, arg5);
        0x2::transfer::public_share_object<0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_info::PriceInfoObject>(0x1::vector::pop_back<0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_info::PriceInfoObject>(&mut v1));
        0x1::vector::destroy_empty<0xa446c4a37c0bb69d03357c1a52d60da0b434048226d5f3feffdb693586bea861::price_info::PriceInfoObject>(v1);
    }

    // decompiled from Move bytecode v6
}

