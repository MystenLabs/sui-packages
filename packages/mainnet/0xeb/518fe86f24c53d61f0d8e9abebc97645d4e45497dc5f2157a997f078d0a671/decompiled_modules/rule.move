module 0xeb518fe86f24c53d61f0d8e9abebc97645d4e45497dc5f2157a997f078d0a671::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun set_price_as_primary(arg0: &mut 0x4b8da0adfc3b829d63878104400a195a1864c347446b27947a28e4201ddffbbe::x_oracle::XOraclePriceUpdateRequest<0xac1462fcab23fb2408d22ec26bc472c1e76d0851b9283d11ff491faffde1be51::coin_gusd::COIN_GUSD>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x4b8da0adfc3b829d63878104400a195a1864c347446b27947a28e4201ddffbbe::x_oracle::set_primary_price<0xac1462fcab23fb2408d22ec26bc472c1e76d0851b9283d11ff491faffde1be51::coin_gusd::COIN_GUSD, Rule>(v0, arg0, 0x4b8da0adfc3b829d63878104400a195a1864c347446b27947a28e4201ddffbbe::price_feed::new(1000000000, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    public fun set_price_as_secondary(arg0: &mut 0x4b8da0adfc3b829d63878104400a195a1864c347446b27947a28e4201ddffbbe::x_oracle::XOraclePriceUpdateRequest<0xac1462fcab23fb2408d22ec26bc472c1e76d0851b9283d11ff491faffde1be51::coin_gusd::COIN_GUSD>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x4b8da0adfc3b829d63878104400a195a1864c347446b27947a28e4201ddffbbe::x_oracle::set_secondary_price<0xac1462fcab23fb2408d22ec26bc472c1e76d0851b9283d11ff491faffde1be51::coin_gusd::COIN_GUSD, Rule>(v0, arg0, 0x4b8da0adfc3b829d63878104400a195a1864c347446b27947a28e4201ddffbbe::price_feed::new(1000000000, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    // decompiled from Move bytecode v6
}

