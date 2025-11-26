module 0x7635fd1a939dcafd922858933433dd83aa81f33e66cb7a3e9906d3e87fee3846::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun set_price_as_primary(arg0: &mut 0x7fdc2bc8e78c3e133728c75e54fe5587b868ad59f849d8c7611147cc0394f305::x_oracle::XOraclePriceUpdateRequest<0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::COIN_GUSD>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x7fdc2bc8e78c3e133728c75e54fe5587b868ad59f849d8c7611147cc0394f305::x_oracle::set_primary_price<0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::COIN_GUSD, Rule>(v0, arg0, 0x7fdc2bc8e78c3e133728c75e54fe5587b868ad59f849d8c7611147cc0394f305::price_feed::new(1000000000, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    public fun set_price_as_secondary(arg0: &mut 0x7fdc2bc8e78c3e133728c75e54fe5587b868ad59f849d8c7611147cc0394f305::x_oracle::XOraclePriceUpdateRequest<0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::COIN_GUSD>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x7fdc2bc8e78c3e133728c75e54fe5587b868ad59f849d8c7611147cc0394f305::x_oracle::set_secondary_price<0xa4d5fe28cdff0c3427ee0c9a2eba81e6cfef7e45676268729204071896836394::coin_gusd::COIN_GUSD, Rule>(v0, arg0, 0x7fdc2bc8e78c3e133728c75e54fe5587b868ad59f849d8c7611147cc0394f305::price_feed::new(1000000000, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    // decompiled from Move bytecode v6
}

