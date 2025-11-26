module 0xec80238d6a6acd3bf1b357dc7af7dfe370792e87f2b4601575fabfb629e96033::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun set_price_as_primary(arg0: &mut 0x7fdc2bc8e78c3e133728c75e54fe5587b868ad59f849d8c7611147cc0394f305::x_oracle::XOraclePriceUpdateRequest<0xc693b10e6ce36c7dbab99380ae2ffc31b1803a2850aa8e46269f9808801e1837::coin_gr::COIN_GR>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x7fdc2bc8e78c3e133728c75e54fe5587b868ad59f849d8c7611147cc0394f305::x_oracle::set_primary_price<0xc693b10e6ce36c7dbab99380ae2ffc31b1803a2850aa8e46269f9808801e1837::coin_gr::COIN_GR, Rule>(v0, arg0, 0x7fdc2bc8e78c3e133728c75e54fe5587b868ad59f849d8c7611147cc0394f305::price_feed::new(0, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    public fun set_price_as_secondary(arg0: &mut 0x7fdc2bc8e78c3e133728c75e54fe5587b868ad59f849d8c7611147cc0394f305::x_oracle::XOraclePriceUpdateRequest<0xc693b10e6ce36c7dbab99380ae2ffc31b1803a2850aa8e46269f9808801e1837::coin_gr::COIN_GR>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x7fdc2bc8e78c3e133728c75e54fe5587b868ad59f849d8c7611147cc0394f305::x_oracle::set_secondary_price<0xc693b10e6ce36c7dbab99380ae2ffc31b1803a2850aa8e46269f9808801e1837::coin_gr::COIN_GR, Rule>(v0, arg0, 0x7fdc2bc8e78c3e133728c75e54fe5587b868ad59f849d8c7611147cc0394f305::price_feed::new(0, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    // decompiled from Move bytecode v6
}

