module 0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::oracle {
    struct FeedInfo has store {
        feed_id: vector<u8>,
        token_decimals: u8,
        last_accepted_price: u64,
        last_accepted_ms: u64,
        breaker_tripped: bool,
    }

    struct OracleConfig has store {
        feeds: 0x2::table::Table<0x1::type_name::TypeName, FeedInfo>,
        max_price_age_ms: u64,
        max_confidence_bps: u64,
        max_deviation_bps: u64,
    }

    struct FeedRegistered has copy, drop {
        token_type: 0x1::type_name::TypeName,
        feed_id: vector<u8>,
        token_decimals: u8,
    }

    struct BreakerTripped has copy, drop {
        token_type: 0x1::type_name::TypeName,
        last_accepted_price: u64,
        rejected_price: u64,
        deviation_bps: u64,
        timestamp_ms: u64,
    }

    struct BreakerReset has copy, drop {
        token_type: 0x1::type_name::TypeName,
        timestamp_ms: u64,
    }

    struct OracleConfigUpdated has copy, drop {
        max_price_age_ms: u64,
        max_confidence_bps: u64,
        max_deviation_bps: u64,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : OracleConfig {
        OracleConfig{
            feeds              : 0x2::table::new<0x1::type_name::TypeName, FeedInfo>(arg0),
            max_price_age_ms   : 60000,
            max_confidence_bps : 500,
            max_deviation_bps  : 2500,
        }
    }

    public fun decimals_of(arg0: &OracleConfig, arg1: 0x1::type_name::TypeName) : u8 {
        assert!(0x2::table::contains<0x1::type_name::TypeName, FeedInfo>(&arg0.feeds, arg1), 200);
        0x2::table::borrow<0x1::type_name::TypeName, FeedInfo>(&arg0.feeds, arg1).token_decimals
    }

    public fun get_config(arg0: &OracleConfig) : (u64, u64, u64) {
        (arg0.max_price_age_ms, arg0.max_confidence_bps, arg0.max_deviation_bps)
    }

    public fun get_last_price(arg0: &OracleConfig, arg1: 0x1::type_name::TypeName) : u64 {
        if (!0x2::table::contains<0x1::type_name::TypeName, FeedInfo>(&arg0.feeds, arg1)) {
            return 0
        };
        0x2::table::borrow<0x1::type_name::TypeName, FeedInfo>(&arg0.feeds, arg1).last_accepted_price
    }

    public(friend) fun get_price_usdc<T0>(arg0: &mut OracleConfig, arg1: &0x5d822921e69a841952ae20490bca998984f430aed4af604d048d2e32f304c92a::adapter::PriceCache, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, FeedInfo>(&arg0.feeds, v0), 200);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = 0x2::table::borrow_mut<0x1::type_name::TypeName, FeedInfo>(&mut arg0.feeds, v0);
        assert!(!v2.breaker_tripped, 207);
        assert!(0x5d822921e69a841952ae20490bca998984f430aed4af604d048d2e32f304c92a::adapter::feed_id_of(arg1, v0) == v2.feed_id, 202);
        let (v3, v4, v5, v6) = 0x5d822921e69a841952ae20490bca998984f430aed4af604d048d2e32f304c92a::adapter::read(arg1, v0);
        assert!(v4 + arg0.max_price_age_ms >= v1, 203);
        assert!((((v5 as u128) * (10000 as u128) / (v6 as u128)) as u64) <= arg0.max_confidence_bps, 205);
        if (v2.last_accepted_price > 0) {
            let v7 = v2.last_accepted_price;
            let v8 = if (v3 > v7) {
                v3 - v7
            } else {
                v7 - v3
            };
            let v9 = (((v8 as u128) * (10000 as u128) / (v7 as u128)) as u64);
            if (v9 > arg0.max_deviation_bps) {
                v2.breaker_tripped = true;
                let v10 = BreakerTripped{
                    token_type          : v0,
                    last_accepted_price : v7,
                    rejected_price      : v3,
                    deviation_bps       : v9,
                    timestamp_ms        : v1,
                };
                0x2::event::emit<BreakerTripped>(v10);
                abort 206
            };
        };
        v2.last_accepted_price = v3;
        v2.last_accepted_ms = v1;
        v3
    }

    public fun has_feed(arg0: &OracleConfig, arg1: 0x1::type_name::TypeName) : bool {
        0x2::table::contains<0x1::type_name::TypeName, FeedInfo>(&arg0.feeds, arg1)
    }

    public fun is_breaker_tripped(arg0: &OracleConfig, arg1: 0x1::type_name::TypeName) : bool {
        if (!0x2::table::contains<0x1::type_name::TypeName, FeedInfo>(&arg0.feeds, arg1)) {
            return false
        };
        0x2::table::borrow<0x1::type_name::TypeName, FeedInfo>(&arg0.feeds, arg1).breaker_tripped
    }

    fun pow10(arg0: u64) : u64 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun register_feed<T0>(arg0: &mut OracleConfig, arg1: vector<u8>, arg2: u8) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(!0x2::table::contains<0x1::type_name::TypeName, FeedInfo>(&arg0.feeds, v0), 201);
        let v1 = FeedInfo{
            feed_id             : arg1,
            token_decimals      : arg2,
            last_accepted_price : 0,
            last_accepted_ms    : 0,
            breaker_tripped     : false,
        };
        0x2::table::add<0x1::type_name::TypeName, FeedInfo>(&mut arg0.feeds, v0, v1);
        let v2 = FeedRegistered{
            token_type     : v0,
            feed_id        : arg1,
            token_decimals : arg2,
        };
        0x2::event::emit<FeedRegistered>(v2);
    }

    public(friend) fun remove_feed<T0>(arg0: &mut OracleConfig) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, FeedInfo>(&arg0.feeds, v0), 200);
        let FeedInfo {
            feed_id             : _,
            token_decimals      : _,
            last_accepted_price : _,
            last_accepted_ms    : _,
            breaker_tripped     : _,
        } = 0x2::table::remove<0x1::type_name::TypeName, FeedInfo>(&mut arg0.feeds, v0);
    }

    public(friend) fun reset_breaker<T0>(arg0: &mut OracleConfig, arg1: &0x2::clock::Clock) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, FeedInfo>(&arg0.feeds, v0), 200);
        let v1 = 0x2::table::borrow_mut<0x1::type_name::TypeName, FeedInfo>(&mut arg0.feeds, v0);
        v1.breaker_tripped = false;
        v1.last_accepted_price = 0;
        let v2 = BreakerReset{
            token_type   : v0,
            timestamp_ms : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<BreakerReset>(v2);
    }

    public(friend) fun set_config(arg0: &mut OracleConfig, arg1: u64, arg2: u64, arg3: u64) {
        assert!(arg1 >= 10000 && arg1 <= 600000, 208);
        assert!(arg2 >= 50 && arg2 <= 1000, 208);
        assert!(arg3 >= 500 && arg3 <= 9000, 208);
        arg0.max_price_age_ms = arg1;
        arg0.max_confidence_bps = arg2;
        arg0.max_deviation_bps = arg3;
        let v0 = OracleConfigUpdated{
            max_price_age_ms   : arg1,
            max_confidence_bps : arg2,
            max_deviation_bps  : arg3,
        };
        0x2::event::emit<OracleConfigUpdated>(v0);
    }

    public fun usdc_scale() : u64 {
        1000000
    }

    public(friend) fun value_of<T0>(arg0: &mut OracleConfig, arg1: u64, arg2: &0x5d822921e69a841952ae20490bca998984f430aed4af604d048d2e32f304c92a::adapter::PriceCache, arg3: &0x2::clock::Clock) : u64 {
        if (arg1 == 0) {
            return 0
        };
        let v0 = get_price_usdc<T0>(arg0, arg2, arg3);
        (((arg1 as u128) * (v0 as u128) / (pow10((0x2::table::borrow<0x1::type_name::TypeName, FeedInfo>(&arg0.feeds, 0x1::type_name::get<T0>()).token_decimals as u64)) as u128)) as u64)
    }

    // decompiled from Move bytecode v7
}

