module 0x8ffc6dc26e6bd3ed37281fe612ad12e7b5733735ec056791128c09ca88c6de64::user_oracle {
    public fun get_price(arg0: &0x8ffc6dc26e6bd3ed37281fe612ad12e7b5733735ec056791128c09ca88c6de64::x_oracle::XOracle, arg1: 0x1::type_name::TypeName, arg2: 0x8ffc6dc26e6bd3ed37281fe612ad12e7b5733735ec056791128c09ca88c6de64::x_oracle::BaseToken, arg3: &0x2::clock::Clock) : 0x6a9f1a9dbc42ae30b45eca93faf2334a7a237749dd65395fdcab5be361da6d00::float::Decimal {
        abort 0
    }

    public fun refresh_usd_price<T0>(arg0: &mut 0x8ffc6dc26e6bd3ed37281fe612ad12e7b5733735ec056791128c09ca88c6de64::x_oracle::XOracle, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x2::clock::Clock) {
        abort 0
    }

    // decompiled from Move bytecode v6
}

