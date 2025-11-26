module 0x10bdc59d93f81cf5bd3cd88ea2517c9e050808a4ffaaf0c938256fa042ce3c2e::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun set_price_as_primary(arg0: &mut 0x901a0eda69c69f5ed9ccd6e94b01e2a4d3e36c88f0b5c0da90978a2a92979007::x_oracle::XOraclePriceUpdateRequest<0x1a6490dc72a223587be7619fcda2b4ef56b4d138a3401968005062333f030063::coin_gr::COIN_GR>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x901a0eda69c69f5ed9ccd6e94b01e2a4d3e36c88f0b5c0da90978a2a92979007::x_oracle::set_primary_price<0x1a6490dc72a223587be7619fcda2b4ef56b4d138a3401968005062333f030063::coin_gr::COIN_GR, Rule>(v0, arg0, 0x901a0eda69c69f5ed9ccd6e94b01e2a4d3e36c88f0b5c0da90978a2a92979007::price_feed::new(0, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    public fun set_price_as_secondary(arg0: &mut 0x901a0eda69c69f5ed9ccd6e94b01e2a4d3e36c88f0b5c0da90978a2a92979007::x_oracle::XOraclePriceUpdateRequest<0x1a6490dc72a223587be7619fcda2b4ef56b4d138a3401968005062333f030063::coin_gr::COIN_GR>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x901a0eda69c69f5ed9ccd6e94b01e2a4d3e36c88f0b5c0da90978a2a92979007::x_oracle::set_secondary_price<0x1a6490dc72a223587be7619fcda2b4ef56b4d138a3401968005062333f030063::coin_gr::COIN_GR, Rule>(v0, arg0, 0x901a0eda69c69f5ed9ccd6e94b01e2a4d3e36c88f0b5c0da90978a2a92979007::price_feed::new(0, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    // decompiled from Move bytecode v6
}

