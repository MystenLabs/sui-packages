module 0xe013d93b5e1f9b23ae42a89a32eb728e2bc4e447a01bc05557a4ea3557ea35ef::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun set_price_as_primary(arg0: &mut 0x4f0be0e70afb81670fd135b4201270997f9a32a2dccddaa3925825fe5a8b4c2a::x_oracle::XOraclePriceUpdateRequest<0x4e0fd33013d90511b47217d9d1317e649ac72f4f48fe32be59841142450bf3ab::coin_gr::COIN_GR>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x4f0be0e70afb81670fd135b4201270997f9a32a2dccddaa3925825fe5a8b4c2a::x_oracle::set_primary_price<0x4e0fd33013d90511b47217d9d1317e649ac72f4f48fe32be59841142450bf3ab::coin_gr::COIN_GR, Rule>(v0, arg0, 0x4f0be0e70afb81670fd135b4201270997f9a32a2dccddaa3925825fe5a8b4c2a::price_feed::new(0, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    public fun set_price_as_secondary(arg0: &mut 0x4f0be0e70afb81670fd135b4201270997f9a32a2dccddaa3925825fe5a8b4c2a::x_oracle::XOraclePriceUpdateRequest<0x4e0fd33013d90511b47217d9d1317e649ac72f4f48fe32be59841142450bf3ab::coin_gr::COIN_GR>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x4f0be0e70afb81670fd135b4201270997f9a32a2dccddaa3925825fe5a8b4c2a::x_oracle::set_secondary_price<0x4e0fd33013d90511b47217d9d1317e649ac72f4f48fe32be59841142450bf3ab::coin_gr::COIN_GR, Rule>(v0, arg0, 0x4f0be0e70afb81670fd135b4201270997f9a32a2dccddaa3925825fe5a8b4c2a::price_feed::new(0, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    // decompiled from Move bytecode v6
}

