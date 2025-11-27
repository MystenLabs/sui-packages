module 0x8923d57eac0399e9cec0900de918c9f4f8cc98c457753d26b71a7ef8f850e98f::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun set_price_as_primary(arg0: &mut 0x58908fcf6fe6711a482ab9dc4000d5c9f2ab753c34298843c2a96a534f7fae1d::x_oracle::XOraclePriceUpdateRequest<0xf63455ff6a0e224f8797c015317a14bb84a3c0334541fa88a494d36864947c0::coin_gusd::COIN_GUSD>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x58908fcf6fe6711a482ab9dc4000d5c9f2ab753c34298843c2a96a534f7fae1d::x_oracle::set_primary_price<0xf63455ff6a0e224f8797c015317a14bb84a3c0334541fa88a494d36864947c0::coin_gusd::COIN_GUSD, Rule>(v0, arg0, 0x58908fcf6fe6711a482ab9dc4000d5c9f2ab753c34298843c2a96a534f7fae1d::price_feed::new(1000000000, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    public fun set_price_as_secondary(arg0: &mut 0x58908fcf6fe6711a482ab9dc4000d5c9f2ab753c34298843c2a96a534f7fae1d::x_oracle::XOraclePriceUpdateRequest<0xf63455ff6a0e224f8797c015317a14bb84a3c0334541fa88a494d36864947c0::coin_gusd::COIN_GUSD>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x58908fcf6fe6711a482ab9dc4000d5c9f2ab753c34298843c2a96a534f7fae1d::x_oracle::set_secondary_price<0xf63455ff6a0e224f8797c015317a14bb84a3c0334541fa88a494d36864947c0::coin_gusd::COIN_GUSD, Rule>(v0, arg0, 0x58908fcf6fe6711a482ab9dc4000d5c9f2ab753c34298843c2a96a534f7fae1d::price_feed::new(1000000000, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    // decompiled from Move bytecode v6
}

