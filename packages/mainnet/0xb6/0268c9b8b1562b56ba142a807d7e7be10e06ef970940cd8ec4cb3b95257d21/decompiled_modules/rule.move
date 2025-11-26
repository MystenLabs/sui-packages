module 0xb60268c9b8b1562b56ba142a807d7e7be10e06ef970940cd8ec4cb3b95257d21::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun set_price_as_primary(arg0: &mut 0x6215446965938eaf3596a420047ed0da61a17c8c683b0941f9e54511ecad2b4b::x_oracle::XOraclePriceUpdateRequest<0xa62ad50462b658099e18c134a0b59140a04f8e88f2457a00a5287a4e3d068321::coin_gusd::COIN_GUSD>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x6215446965938eaf3596a420047ed0da61a17c8c683b0941f9e54511ecad2b4b::x_oracle::set_primary_price<0xa62ad50462b658099e18c134a0b59140a04f8e88f2457a00a5287a4e3d068321::coin_gusd::COIN_GUSD, Rule>(v0, arg0, 0x6215446965938eaf3596a420047ed0da61a17c8c683b0941f9e54511ecad2b4b::price_feed::new(1000000000, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    public fun set_price_as_secondary(arg0: &mut 0x6215446965938eaf3596a420047ed0da61a17c8c683b0941f9e54511ecad2b4b::x_oracle::XOraclePriceUpdateRequest<0xa62ad50462b658099e18c134a0b59140a04f8e88f2457a00a5287a4e3d068321::coin_gusd::COIN_GUSD>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x6215446965938eaf3596a420047ed0da61a17c8c683b0941f9e54511ecad2b4b::x_oracle::set_secondary_price<0xa62ad50462b658099e18c134a0b59140a04f8e88f2457a00a5287a4e3d068321::coin_gusd::COIN_GUSD, Rule>(v0, arg0, 0x6215446965938eaf3596a420047ed0da61a17c8c683b0941f9e54511ecad2b4b::price_feed::new(1000000000, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    // decompiled from Move bytecode v6
}

