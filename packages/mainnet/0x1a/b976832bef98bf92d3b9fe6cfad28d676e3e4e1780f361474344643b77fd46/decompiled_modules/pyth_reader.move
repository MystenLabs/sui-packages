module 0x1ab976832bef98bf92d3b9fe6cfad28d676e3e4e1780f361474344643b77fd46::pyth_reader {
    fun feed_id_of(arg0: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject) : vector<u8> {
        let v0 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::get_price_info_from_price_info_object(arg0);
        let v1 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::get_price_identifier(&v0);
        0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_identifier::get_bytes(&v1)
    }

    public fun get_validated_price(arg0: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::state::State, arg1: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg2: vector<u8>, arg3: &0x2::clock::Clock) : 0x1ab976832bef98bf92d3b9fe6cfad28d676e3e4e1780f361474344643b77fd46::price_feed::ValidatedPrice {
        0x1ab976832bef98bf92d3b9fe6cfad28d676e3e4e1780f361474344643b77fd46::price_feed::validate_price(feed_id_of(arg1), arg2, 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::pyth::get_price(arg0, arg1, arg3))
    }

    public fun get_validated_price_and_ema_with_age(arg0: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: u64) : (0x1ab976832bef98bf92d3b9fe6cfad28d676e3e4e1780f361474344643b77fd46::price_feed::ValidatedPrice, 0x1ab976832bef98bf92d3b9fe6cfad28d676e3e4e1780f361474344643b77fd46::price_feed::ValidatedPrice) {
        assert!(arg3 >= 0x1ab976832bef98bf92d3b9fe6cfad28d676e3e4e1780f361474344643b77fd46::price_feed::min_staleness_secs(), 1104);
        assert!(arg3 <= 0x1ab976832bef98bf92d3b9fe6cfad28d676e3e4e1780f361474344643b77fd46::price_feed::max_staleness_secs(), 1104);
        let v0 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::get_price_info_from_price_info_object(arg0);
        let v1 = feed_id_of(arg0);
        (0x1ab976832bef98bf92d3b9fe6cfad28d676e3e4e1780f361474344643b77fd46::price_feed::validate_price(v1, arg1, 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::pyth::get_price_no_older_than(arg0, arg2, arg3)), 0x1ab976832bef98bf92d3b9fe6cfad28d676e3e4e1780f361474344643b77fd46::price_feed::validate_ema_price(v1, arg1, 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_feed::get_ema_price(0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::get_price_feed(&v0))))
    }

    public fun get_validated_price_default(arg0: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg1: vector<u8>, arg2: &0x2::clock::Clock) : 0x1ab976832bef98bf92d3b9fe6cfad28d676e3e4e1780f361474344643b77fd46::price_feed::ValidatedPrice {
        get_validated_price_with_age(arg0, arg1, arg2, 0x1ab976832bef98bf92d3b9fe6cfad28d676e3e4e1780f361474344643b77fd46::price_feed::max_price_age_secs())
    }

    public fun get_validated_price_with_age(arg0: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: u64) : 0x1ab976832bef98bf92d3b9fe6cfad28d676e3e4e1780f361474344643b77fd46::price_feed::ValidatedPrice {
        assert!(arg3 >= 0x1ab976832bef98bf92d3b9fe6cfad28d676e3e4e1780f361474344643b77fd46::price_feed::min_staleness_secs(), 1104);
        assert!(arg3 <= 0x1ab976832bef98bf92d3b9fe6cfad28d676e3e4e1780f361474344643b77fd46::price_feed::max_staleness_secs(), 1104);
        0x1ab976832bef98bf92d3b9fe6cfad28d676e3e4e1780f361474344643b77fd46::price_feed::validate_price(feed_id_of(arg0), arg1, 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::pyth::get_price_no_older_than(arg0, arg2, arg3))
    }

    // decompiled from Move bytecode v7
}

