module 0x8c107031b02fcbd88a6eb5b97d3d6ceaf83651933d945656cb04f864958178ca::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun set_price_as_primary(arg0: &mut 0x4f0be0e70afb81670fd135b4201270997f9a32a2dccddaa3925825fe5a8b4c2a::x_oracle::XOraclePriceUpdateRequest<0x46fe03da9891419ee9a20c2fa445a14aef81446a76f70324cd91abac543ec96a::coin_gusd::COIN_GUSD>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x4f0be0e70afb81670fd135b4201270997f9a32a2dccddaa3925825fe5a8b4c2a::x_oracle::set_primary_price<0x46fe03da9891419ee9a20c2fa445a14aef81446a76f70324cd91abac543ec96a::coin_gusd::COIN_GUSD, Rule>(v0, arg0, 0x4f0be0e70afb81670fd135b4201270997f9a32a2dccddaa3925825fe5a8b4c2a::price_feed::new(1000000000, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    public fun set_price_as_secondary(arg0: &mut 0x4f0be0e70afb81670fd135b4201270997f9a32a2dccddaa3925825fe5a8b4c2a::x_oracle::XOraclePriceUpdateRequest<0x46fe03da9891419ee9a20c2fa445a14aef81446a76f70324cd91abac543ec96a::coin_gusd::COIN_GUSD>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x4f0be0e70afb81670fd135b4201270997f9a32a2dccddaa3925825fe5a8b4c2a::x_oracle::set_secondary_price<0x46fe03da9891419ee9a20c2fa445a14aef81446a76f70324cd91abac543ec96a::coin_gusd::COIN_GUSD, Rule>(v0, arg0, 0x4f0be0e70afb81670fd135b4201270997f9a32a2dccddaa3925825fe5a8b4c2a::price_feed::new(1000000000, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    // decompiled from Move bytecode v6
}

