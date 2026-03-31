module 0x1b73d7b465f3c271d707325785350217dbd9b08e7394dc44d0a605fc114c722e::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun set_price_as_primary(arg0: &mut 0x6790ab53e30ff851d7199bc50243b229718daa0443b41bd663253bdc6624811a::x_oracle::XOraclePriceUpdateRequest<0x888f8588db58841c2f8e66b14f1dfb13609b41486ff85832818a29b7f8cf750e::coin_gr::COIN_GR>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x6790ab53e30ff851d7199bc50243b229718daa0443b41bd663253bdc6624811a::x_oracle::set_primary_price<0x888f8588db58841c2f8e66b14f1dfb13609b41486ff85832818a29b7f8cf750e::coin_gr::COIN_GR, Rule>(v0, arg0, 0x6790ab53e30ff851d7199bc50243b229718daa0443b41bd663253bdc6624811a::price_feed::new(0, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    public fun set_price_as_secondary(arg0: &mut 0x6790ab53e30ff851d7199bc50243b229718daa0443b41bd663253bdc6624811a::x_oracle::XOraclePriceUpdateRequest<0x888f8588db58841c2f8e66b14f1dfb13609b41486ff85832818a29b7f8cf750e::coin_gr::COIN_GR>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x6790ab53e30ff851d7199bc50243b229718daa0443b41bd663253bdc6624811a::x_oracle::set_secondary_price<0x888f8588db58841c2f8e66b14f1dfb13609b41486ff85832818a29b7f8cf750e::coin_gr::COIN_GR, Rule>(v0, arg0, 0x6790ab53e30ff851d7199bc50243b229718daa0443b41bd663253bdc6624811a::price_feed::new(0, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    // decompiled from Move bytecode v6
}

