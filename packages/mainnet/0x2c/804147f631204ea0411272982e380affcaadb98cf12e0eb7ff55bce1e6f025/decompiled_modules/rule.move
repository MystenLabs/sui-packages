module 0x2c804147f631204ea0411272982e380affcaadb98cf12e0eb7ff55bce1e6f025::rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    public fun set_price_as_primary(arg0: &mut 0x75d76cf4afd63e98f35c94aa28ae78ec4ddf13f4a878c6ef4aeb98e9b580b3d5::x_oracle::XOraclePriceUpdateRequest<0xefcee53fb42b93694d791c9eb8a65e2e50bcdd528bc30ae907ff8f135ccb9513::coin_gusd::COIN_GUSD>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x75d76cf4afd63e98f35c94aa28ae78ec4ddf13f4a878c6ef4aeb98e9b580b3d5::x_oracle::set_primary_price<0xefcee53fb42b93694d791c9eb8a65e2e50bcdd528bc30ae907ff8f135ccb9513::coin_gusd::COIN_GUSD, Rule>(v0, arg0, 0x75d76cf4afd63e98f35c94aa28ae78ec4ddf13f4a878c6ef4aeb98e9b580b3d5::price_feed::new(1000000000, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    public fun set_price_as_secondary(arg0: &mut 0x75d76cf4afd63e98f35c94aa28ae78ec4ddf13f4a878c6ef4aeb98e9b580b3d5::x_oracle::XOraclePriceUpdateRequest<0xefcee53fb42b93694d791c9eb8a65e2e50bcdd528bc30ae907ff8f135ccb9513::coin_gusd::COIN_GUSD>, arg1: &0x2::clock::Clock) {
        let v0 = Rule{dummy_field: false};
        0x75d76cf4afd63e98f35c94aa28ae78ec4ddf13f4a878c6ef4aeb98e9b580b3d5::x_oracle::set_secondary_price<0xefcee53fb42b93694d791c9eb8a65e2e50bcdd528bc30ae907ff8f135ccb9513::coin_gusd::COIN_GUSD, Rule>(v0, arg0, 0x75d76cf4afd63e98f35c94aa28ae78ec4ddf13f4a878c6ef4aeb98e9b580b3d5::price_feed::new(1000000000, 0x2::clock::timestamp_ms(arg1) / 1000));
    }

    // decompiled from Move bytecode v6
}

