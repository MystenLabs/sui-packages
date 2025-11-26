module 0x14179b18a3d0c0344254495a98c1838d9114a01c9a8020e1651b6c62e75f0341::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun set_price_as_primary(arg0: &mut 0x66895f6e3a45637db4bf50868d6b522f18f8ab35687517d3bacea4f1a3bae218::x_oracle::XOraclePriceUpdateRequest<0x27a83c0dc396b16b7e391183847fe83be97770fa36395dfca3dd876fc1bace71::coin_gr::COIN_GR>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x66895f6e3a45637db4bf50868d6b522f18f8ab35687517d3bacea4f1a3bae218::x_oracle::set_primary_price<0x27a83c0dc396b16b7e391183847fe83be97770fa36395dfca3dd876fc1bace71::coin_gr::COIN_GR, Rule>(v0, arg0, 0x66895f6e3a45637db4bf50868d6b522f18f8ab35687517d3bacea4f1a3bae218::price_feed::new(0, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    public fun set_price_as_secondary(arg0: &mut 0x66895f6e3a45637db4bf50868d6b522f18f8ab35687517d3bacea4f1a3bae218::x_oracle::XOraclePriceUpdateRequest<0x27a83c0dc396b16b7e391183847fe83be97770fa36395dfca3dd876fc1bace71::coin_gr::COIN_GR>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x66895f6e3a45637db4bf50868d6b522f18f8ab35687517d3bacea4f1a3bae218::x_oracle::set_secondary_price<0x27a83c0dc396b16b7e391183847fe83be97770fa36395dfca3dd876fc1bace71::coin_gr::COIN_GR, Rule>(v0, arg0, 0x66895f6e3a45637db4bf50868d6b522f18f8ab35687517d3bacea4f1a3bae218::price_feed::new(0, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    // decompiled from Move bytecode v6
}

