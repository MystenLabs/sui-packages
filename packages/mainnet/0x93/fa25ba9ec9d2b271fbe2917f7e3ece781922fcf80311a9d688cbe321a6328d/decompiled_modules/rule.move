module 0x93fa25ba9ec9d2b271fbe2917f7e3ece781922fcf80311a9d688cbe321a6328d::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun set_price_as_primary(arg0: &mut 0x8a50c55c1208cc2ef7741b8dd7656bf6acc25ae6f2ce99a298f9a5c83e08e285::x_oracle::XOraclePriceUpdateRequest<0xdca44ccd8759522a6cdbebe4c0e33f6367a6830b50d9f6b541bc5901fa17d2e5::coin_gr::COIN_GR>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x8a50c55c1208cc2ef7741b8dd7656bf6acc25ae6f2ce99a298f9a5c83e08e285::x_oracle::set_primary_price<0xdca44ccd8759522a6cdbebe4c0e33f6367a6830b50d9f6b541bc5901fa17d2e5::coin_gr::COIN_GR, Rule>(v0, arg0, 0x8a50c55c1208cc2ef7741b8dd7656bf6acc25ae6f2ce99a298f9a5c83e08e285::price_feed::new(0, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    public fun set_price_as_secondary(arg0: &mut 0x8a50c55c1208cc2ef7741b8dd7656bf6acc25ae6f2ce99a298f9a5c83e08e285::x_oracle::XOraclePriceUpdateRequest<0xdca44ccd8759522a6cdbebe4c0e33f6367a6830b50d9f6b541bc5901fa17d2e5::coin_gr::COIN_GR>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x8a50c55c1208cc2ef7741b8dd7656bf6acc25ae6f2ce99a298f9a5c83e08e285::x_oracle::set_secondary_price<0xdca44ccd8759522a6cdbebe4c0e33f6367a6830b50d9f6b541bc5901fa17d2e5::coin_gr::COIN_GR, Rule>(v0, arg0, 0x8a50c55c1208cc2ef7741b8dd7656bf6acc25ae6f2ce99a298f9a5c83e08e285::price_feed::new(0, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    // decompiled from Move bytecode v6
}

