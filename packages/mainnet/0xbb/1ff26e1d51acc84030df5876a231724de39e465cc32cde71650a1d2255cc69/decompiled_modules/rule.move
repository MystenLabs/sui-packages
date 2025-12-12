module 0xbb1ff26e1d51acc84030df5876a231724de39e465cc32cde71650a1d2255cc69::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun set_price_as_primary(arg0: &mut 0x2c9820fb02050a7ce492f9ffb0c2332d91a1a4e12ea229e569c95cceab7f702::x_oracle::XOraclePriceUpdateRequest<0xa7c2c58e027b49738219fbfaae6684cccb9729bd73cc0ab893a10d12a02cfadc::coin_gr::COIN_GR>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x2c9820fb02050a7ce492f9ffb0c2332d91a1a4e12ea229e569c95cceab7f702::x_oracle::set_primary_price<0xa7c2c58e027b49738219fbfaae6684cccb9729bd73cc0ab893a10d12a02cfadc::coin_gr::COIN_GR, Rule>(v0, arg0, 0x2c9820fb02050a7ce492f9ffb0c2332d91a1a4e12ea229e569c95cceab7f702::price_feed::new(0, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    public fun set_price_as_secondary(arg0: &mut 0x2c9820fb02050a7ce492f9ffb0c2332d91a1a4e12ea229e569c95cceab7f702::x_oracle::XOraclePriceUpdateRequest<0xa7c2c58e027b49738219fbfaae6684cccb9729bd73cc0ab893a10d12a02cfadc::coin_gr::COIN_GR>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x2c9820fb02050a7ce492f9ffb0c2332d91a1a4e12ea229e569c95cceab7f702::x_oracle::set_secondary_price<0xa7c2c58e027b49738219fbfaae6684cccb9729bd73cc0ab893a10d12a02cfadc::coin_gr::COIN_GR, Rule>(v0, arg0, 0x2c9820fb02050a7ce492f9ffb0c2332d91a1a4e12ea229e569c95cceab7f702::price_feed::new(0, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    // decompiled from Move bytecode v6
}

