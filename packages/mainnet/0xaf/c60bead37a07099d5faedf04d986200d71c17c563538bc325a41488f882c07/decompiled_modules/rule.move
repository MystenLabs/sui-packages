module 0xafc60bead37a07099d5faedf04d986200d71c17c563538bc325a41488f882c07::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun set_price_as_primary(arg0: &mut 0xbc09f43b2b70f84ab785c2cf5522327564593025d062ce63fab099dedcf0a195::x_oracle::XOraclePriceUpdateRequest<0xb26b55042763eadba3f63f0ae731d672c2992601ec85976b298da9b1275e98fb::coin_gr::COIN_GR>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0xbc09f43b2b70f84ab785c2cf5522327564593025d062ce63fab099dedcf0a195::x_oracle::set_primary_price<0xb26b55042763eadba3f63f0ae731d672c2992601ec85976b298da9b1275e98fb::coin_gr::COIN_GR, Rule>(v0, arg0, 0xbc09f43b2b70f84ab785c2cf5522327564593025d062ce63fab099dedcf0a195::price_feed::new(0, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    public fun set_price_as_secondary(arg0: &mut 0xbc09f43b2b70f84ab785c2cf5522327564593025d062ce63fab099dedcf0a195::x_oracle::XOraclePriceUpdateRequest<0xb26b55042763eadba3f63f0ae731d672c2992601ec85976b298da9b1275e98fb::coin_gr::COIN_GR>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0xbc09f43b2b70f84ab785c2cf5522327564593025d062ce63fab099dedcf0a195::x_oracle::set_secondary_price<0xb26b55042763eadba3f63f0ae731d672c2992601ec85976b298da9b1275e98fb::coin_gr::COIN_GR, Rule>(v0, arg0, 0xbc09f43b2b70f84ab785c2cf5522327564593025d062ce63fab099dedcf0a195::price_feed::new(0, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    // decompiled from Move bytecode v6
}

