module 0x8a03e72e9590438839f60f74fc7148288ecfffc5ba1e78043dbf525c1eb6263f::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun set_price_as_primary(arg0: &mut 0x4b8da0adfc3b829d63878104400a195a1864c347446b27947a28e4201ddffbbe::x_oracle::XOraclePriceUpdateRequest<0x187f3308f26b5defff9a0492c0d9a4a6ef7cf2120aa4bee5028a3f389530ee08::coin_gr::COIN_GR>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x4b8da0adfc3b829d63878104400a195a1864c347446b27947a28e4201ddffbbe::x_oracle::set_primary_price<0x187f3308f26b5defff9a0492c0d9a4a6ef7cf2120aa4bee5028a3f389530ee08::coin_gr::COIN_GR, Rule>(v0, arg0, 0x4b8da0adfc3b829d63878104400a195a1864c347446b27947a28e4201ddffbbe::price_feed::new(0, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    public fun set_price_as_secondary(arg0: &mut 0x4b8da0adfc3b829d63878104400a195a1864c347446b27947a28e4201ddffbbe::x_oracle::XOraclePriceUpdateRequest<0x187f3308f26b5defff9a0492c0d9a4a6ef7cf2120aa4bee5028a3f389530ee08::coin_gr::COIN_GR>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x4b8da0adfc3b829d63878104400a195a1864c347446b27947a28e4201ddffbbe::x_oracle::set_secondary_price<0x187f3308f26b5defff9a0492c0d9a4a6ef7cf2120aa4bee5028a3f389530ee08::coin_gr::COIN_GR, Rule>(v0, arg0, 0x4b8da0adfc3b829d63878104400a195a1864c347446b27947a28e4201ddffbbe::price_feed::new(0, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    // decompiled from Move bytecode v6
}

