module 0x2580dc0809100975c9666165d7a35356eb0b700b5ed81197067adb7e3c43e9e6::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun set_price_as_primary(arg0: &mut 0xa672673d45ce659ff4e5fbca19d2e757a4822d95bbb064e5c98c05e04880b70f::x_oracle::XOraclePriceUpdateRequest<0xcf4fe1cc82b195af4dde839de18366583158db71b967af211b3621c9bdc5c05c::coin_gr::COIN_GR>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0xa672673d45ce659ff4e5fbca19d2e757a4822d95bbb064e5c98c05e04880b70f::x_oracle::set_primary_price<0xcf4fe1cc82b195af4dde839de18366583158db71b967af211b3621c9bdc5c05c::coin_gr::COIN_GR, Rule>(v0, arg0, 0xa672673d45ce659ff4e5fbca19d2e757a4822d95bbb064e5c98c05e04880b70f::price_feed::new(0, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    public fun set_price_as_secondary(arg0: &mut 0xa672673d45ce659ff4e5fbca19d2e757a4822d95bbb064e5c98c05e04880b70f::x_oracle::XOraclePriceUpdateRequest<0xcf4fe1cc82b195af4dde839de18366583158db71b967af211b3621c9bdc5c05c::coin_gr::COIN_GR>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0xa672673d45ce659ff4e5fbca19d2e757a4822d95bbb064e5c98c05e04880b70f::x_oracle::set_secondary_price<0xcf4fe1cc82b195af4dde839de18366583158db71b967af211b3621c9bdc5c05c::coin_gr::COIN_GR, Rule>(v0, arg0, 0xa672673d45ce659ff4e5fbca19d2e757a4822d95bbb064e5c98c05e04880b70f::price_feed::new(0, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    // decompiled from Move bytecode v6
}

