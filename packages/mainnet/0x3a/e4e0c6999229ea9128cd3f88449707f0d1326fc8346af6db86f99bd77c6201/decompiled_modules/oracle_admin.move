module 0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::oracle_admin {
    struct PriceDelayToleranceUpdated has copy, drop {
        oracle: 0x2::object::ID,
        delay_ms: u64,
        who: address,
        timestamp: u64,
    }

    struct NewPythPriceFeed has copy, drop {
        oracle: 0x2::object::ID,
        asset: 0x1::type_name::TypeName,
        pyth_feed_id: vector<u8>,
    }

    public fun migrate(arg0: &0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::x_oracle::AdminCap, arg1: &mut 0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::x_oracle::XOracle) : u64 {
        0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::x_oracle::migrate(arg1)
    }

    public fun register_pyth_feed<T0>(arg0: &0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::x_oracle::AdminCap, arg1: &mut 0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::x_oracle::XOracle, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: u64, arg4: u64) {
        0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::pyth_adaptor::register_pyth_feed<T0>(0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::x_oracle::pyth_price_feeds_mut(arg1), arg2, arg3, arg4);
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg2);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v0);
        let v2 = NewPythPriceFeed{
            oracle       : 0x2::object::id<0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::x_oracle::XOracle>(arg1),
            asset        : 0x1::type_name::with_defining_ids<T0>(),
            pyth_feed_id : 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v1),
        };
        0x2::event::emit<NewPythPriceFeed>(v2);
    }

    public fun update_price_delay_tolerance_ms(arg0: &0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::x_oracle::AdminCap, arg1: &mut 0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::x_oracle::XOracle, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::x_oracle::update_price_delay_tolerance_ms(arg1, arg2);
        let v0 = PriceDelayToleranceUpdated{
            oracle    : 0x2::object::id<0x3ae4e0c6999229ea9128cd3f88449707f0d1326fc8346af6db86f99bd77c6201::x_oracle::XOracle>(arg1),
            delay_ms  : arg2,
            who       : 0x2::tx_context::sender(arg4),
            timestamp : 0x2::clock::timestamp_ms(arg3) / 1000,
        };
        0x2::event::emit<PriceDelayToleranceUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

