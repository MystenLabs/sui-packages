module 0xd111a8eaba092d911a2e771a7d40adbf276f43310b7fcbdc69e74ccb1d9068cf::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun set_price_as_primary(arg0: &mut 0x6215446965938eaf3596a420047ed0da61a17c8c683b0941f9e54511ecad2b4b::x_oracle::XOraclePriceUpdateRequest<0xd76efd35c67ac11a55bca59117f28fefe900eea79c644b4d37fc81ddf703b23::coin_gr::COIN_GR>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x6215446965938eaf3596a420047ed0da61a17c8c683b0941f9e54511ecad2b4b::x_oracle::set_primary_price<0xd76efd35c67ac11a55bca59117f28fefe900eea79c644b4d37fc81ddf703b23::coin_gr::COIN_GR, Rule>(v0, arg0, 0x6215446965938eaf3596a420047ed0da61a17c8c683b0941f9e54511ecad2b4b::price_feed::new(0, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    public fun set_price_as_secondary(arg0: &mut 0x6215446965938eaf3596a420047ed0da61a17c8c683b0941f9e54511ecad2b4b::x_oracle::XOraclePriceUpdateRequest<0xd76efd35c67ac11a55bca59117f28fefe900eea79c644b4d37fc81ddf703b23::coin_gr::COIN_GR>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x6215446965938eaf3596a420047ed0da61a17c8c683b0941f9e54511ecad2b4b::x_oracle::set_secondary_price<0xd76efd35c67ac11a55bca59117f28fefe900eea79c644b4d37fc81ddf703b23::coin_gr::COIN_GR, Rule>(v0, arg0, 0x6215446965938eaf3596a420047ed0da61a17c8c683b0941f9e54511ecad2b4b::price_feed::new(0, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    // decompiled from Move bytecode v6
}

