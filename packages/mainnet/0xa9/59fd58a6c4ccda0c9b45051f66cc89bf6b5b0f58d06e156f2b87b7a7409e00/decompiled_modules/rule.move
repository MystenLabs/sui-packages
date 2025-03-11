module 0xa959fd58a6c4ccda0c9b45051f66cc89bf6b5b0f58d06e156f2b87b7a7409e00::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    fun assert_price_not_stale(arg0: u64, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000;
        assert!(arg0 >= v0 - 60, 70658);
        assert!(arg0 <= v0 + 10, 70659);
    }

    public fun set_price<T0>(arg0: &mut 0xe7511600c924f1d0ac4b3fa5de3ae26b8845545902b015dc5fc7894307365d7b::x_oracle::XOraclePriceUpdateRequest<T0>, arg1: &0xb884dbc39d915f32a82cc62dabad75ca3efd3c568c329eba270b03c6f58cbd8::aggregator::Aggregator, arg2: &0xa959fd58a6c4ccda0c9b45051f66cc89bf6b5b0f58d06e156f2b87b7a7409e00::switchboard_registry::SwitchboardRegistry, arg3: &0x2::clock::Clock) {
        0xa959fd58a6c4ccda0c9b45051f66cc89bf6b5b0f58d06e156f2b87b7a7409e00::switchboard_registry::assert_switchboard_aggregator<T0>(arg2, arg1);
        let (v0, v1) = 0xa959fd58a6c4ccda0c9b45051f66cc89bf6b5b0f58d06e156f2b87b7a7409e00::switchboard_adaptor::get_switchboard_price(arg1);
        let v2 = v0 / (0x1::u64::pow(10, 18 - 0xe7511600c924f1d0ac4b3fa5de3ae26b8845545902b015dc5fc7894307365d7b::price_feed::decimals()) as u128);
        assert!(v2 > 0 && v2 < 18446744073709551615, 70657);
        assert_price_not_stale(v1, arg3);
        let v3 = Rule{dummy_field: false};
        0xe7511600c924f1d0ac4b3fa5de3ae26b8845545902b015dc5fc7894307365d7b::x_oracle::set_secondary_price<T0, Rule>(v3, arg0, 0xe7511600c924f1d0ac4b3fa5de3ae26b8845545902b015dc5fc7894307365d7b::price_feed::new((v2 as u64), v1));
    }

    // decompiled from Move bytecode v6
}

