module 0x1ab976832bef98bf92d3b9fe6cfad28d676e3e4e1780f361474344643b77fd46::price_feed {
    struct ValidatedPrice has copy, drop {
        feed_id: vector<u8>,
        price: u64,
        confidence: u64,
        expo: 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::I64,
        timestamp: u64,
    }

    public fun assert_feed(arg0: &ValidatedPrice, arg1: vector<u8>) {
        assert!(arg0.feed_id == arg1, 1105);
    }

    public fun compute_usd_value(arg0: u64, arg1: u8, arg2: &ValidatedPrice) : u64 {
        0x9b111da2af5529321ee4e887037f384b4380b8eb96d9f9a7f899853d3680f744::price::compute_usd_value(arg0, arg2.price, 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_negative(&arg2.expo), arg1, 0x9b111da2af5529321ee4e887037f384b4380b8eb96d9f9a7f899853d3680f744::rounding::down())
    }

    public fun compute_value(arg0: u64, arg1: u8, arg2: u8, arg3: &ValidatedPrice, arg4: &ValidatedPrice) : u64 {
        0x9b111da2af5529321ee4e887037f384b4380b8eb96d9f9a7f899853d3680f744::price::compute_value(arg0, arg3.price, 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_negative(&arg3.expo), arg1, arg4.price, 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_negative(&arg4.expo), arg2, 0x9b111da2af5529321ee4e887037f384b4380b8eb96d9f9a7f899853d3680f744::rounding::down())
    }

    public fun compute_value_ask(arg0: u64, arg1: u8, arg2: u8, arg3: &ValidatedPrice, arg4: &ValidatedPrice) : u64 {
        assert!(arg4.confidence < arg4.price, 1106);
        0x9b111da2af5529321ee4e887037f384b4380b8eb96d9f9a7f899853d3680f744::price::compute_value(arg0, arg3.price + arg3.confidence, 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_negative(&arg3.expo), arg1, arg4.price - arg4.confidence, 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_negative(&arg4.expo), arg2, 0x9b111da2af5529321ee4e887037f384b4380b8eb96d9f9a7f899853d3680f744::rounding::up())
    }

    public fun compute_value_bid(arg0: u64, arg1: u8, arg2: u8, arg3: &ValidatedPrice, arg4: &ValidatedPrice) : u64 {
        assert!(arg3.confidence < arg3.price, 1106);
        0x9b111da2af5529321ee4e887037f384b4380b8eb96d9f9a7f899853d3680f744::price::compute_value(arg0, arg3.price - arg3.confidence, 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_negative(&arg3.expo), arg1, arg4.price + arg4.confidence, 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_negative(&arg4.expo), arg2, 0x9b111da2af5529321ee4e887037f384b4380b8eb96d9f9a7f899853d3680f744::rounding::down())
    }

    public fun compute_value_round_up(arg0: u64, arg1: u8, arg2: u8, arg3: &ValidatedPrice, arg4: &ValidatedPrice) : u64 {
        0x9b111da2af5529321ee4e887037f384b4380b8eb96d9f9a7f899853d3680f744::price::compute_value(arg0, arg3.price, 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_negative(&arg3.expo), arg1, arg4.price, 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_negative(&arg4.expo), arg2, 0x9b111da2af5529321ee4e887037f384b4380b8eb96d9f9a7f899853d3680f744::rounding::up())
    }

    public fun max_price_age_secs() : u64 {
        60
    }

    public fun max_staleness_secs() : u64 {
        300
    }

    public fun min_staleness_secs() : u64 {
        1
    }

    fun scale_up(arg0: u128, arg1: u64) : u128 {
        assert!(arg1 <= 38, 1107);
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg1) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        assert!(arg0 <= 340282366920938463463374607431768211455 / v0, 1107);
        arg0 * v0
    }

    public fun scaled_bid_ask(arg0: &ValidatedPrice, arg1: &ValidatedPrice, arg2: u8, arg3: u8) : (u128, u128) {
        assert!(arg0.confidence < arg0.price, 1106);
        assert!(arg1.confidence < arg1.price, 1106);
        let v0 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_negative(&arg1.expo) + (arg3 as u64) + 12;
        let v1 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_negative(&arg0.expo) + (arg2 as u64);
        let (v2, v3) = if (v0 >= v1) {
            (v0 - v1, 0)
        } else {
            (0, v1 - v0)
        };
        let v4 = scale_up(((arg0.price + arg0.confidence) as u128), v2);
        let v5 = scale_up(((arg1.price - arg1.confidence) as u128), v3);
        let v6 = if (v4 % v5 == 0) {
            0
        } else {
            1
        };
        (scale_up(((arg0.price - arg0.confidence) as u128), v2) / scale_up(((arg1.price + arg1.confidence) as u128), v3), v4 / v5 + v6)
    }

    public fun scaled_price_scale_exp() : u64 {
        12
    }

    public fun scaled_quote(arg0: &ValidatedPrice, arg1: &ValidatedPrice, arg2: &ValidatedPrice, arg3: &ValidatedPrice, arg4: u8, arg5: u8) : (u128, u128, u128) {
        let (v0, v1) = scaled_bid_ask(arg0, arg2, arg4, arg5);
        let (v2, v3) = scaled_bid_ask(arg1, arg3, arg4, arg5);
        (0x1::u128::min(v0, v2), v0 + (v1 - v0) / 2, 0x1::u128::max(v1, v3))
    }

    public(friend) fun validate_ema_price(arg0: vector<u8>, arg1: vector<u8>, arg2: 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::Price) : ValidatedPrice {
        let v0 = validate_price_uncapped(arg0, arg1, arg2);
        with_confidence_capped(&v0, 500)
    }

    public(friend) fun validate_price(arg0: vector<u8>, arg1: vector<u8>, arg2: 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::Price) : ValidatedPrice {
        let v0 = validate_price_uncapped(arg0, arg1, arg2);
        assert!(within_confidence(&v0, 500), 1101);
        v0
    }

    fun validate_price_uncapped(arg0: vector<u8>, arg1: vector<u8>, arg2: 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::Price) : ValidatedPrice {
        assert!(arg0 == arg1, 1105);
        let v0 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_price(&arg2);
        let v1 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_expo(&arg2);
        assert!(!0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_is_negative(&v0), 1102);
        let v2 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_positive(&v0);
        assert!(v2 > 0, 1102);
        assert!(0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_is_negative(&v1), 1103);
        ValidatedPrice{
            feed_id    : arg0,
            price      : v2,
            confidence : 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_conf(&arg2),
            expo       : v1,
            timestamp  : 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_timestamp(&arg2),
        }
    }

    public fun validated_price_confidence(arg0: &ValidatedPrice) : u64 {
        arg0.confidence
    }

    public fun validated_price_expo(arg0: &ValidatedPrice) : 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::I64 {
        arg0.expo
    }

    public fun validated_price_feed_id(arg0: &ValidatedPrice) : vector<u8> {
        arg0.feed_id
    }

    public fun validated_price_timestamp(arg0: &ValidatedPrice) : u64 {
        arg0.timestamp
    }

    public fun validated_price_value(arg0: &ValidatedPrice) : u64 {
        arg0.price
    }

    public fun with_confidence_capped(arg0: &ValidatedPrice, arg1: u64) : ValidatedPrice {
        ValidatedPrice{
            feed_id    : arg0.feed_id,
            price      : arg0.price,
            confidence : 0x1::u64::min(arg0.confidence, (((arg0.price as u128) * (arg1 as u128) / 10000) as u64)),
            expo       : arg0.expo,
            timestamp  : arg0.timestamp,
        }
    }

    public fun within_confidence(arg0: &ValidatedPrice, arg1: u64) : bool {
        (arg0.confidence as u128) * 10000 <= (arg0.price as u128) * (arg1 as u128)
    }

    // decompiled from Move bytecode v7
}

