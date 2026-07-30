module 0x634fd7331a366f1eebc09d6d7a0ef2dd13aaf72ea2f8e4714936dad7a6d873a2::market {
    struct Market has store {
        pool_id: 0x2::object::ID,
        base: MarketCurrency,
        quote: MarketCurrency,
        mid_price: 0x1::option::Option<u64>,
        conf_ratio_bps: 0x1::option::Option<u64>,
    }

    struct MarketCurrency has store {
        coin_type: 0x1::type_name::TypeName,
        decimals: u8,
        pyth_price_feed_id: vector<u8>,
        price_publish_time: 0x1::option::Option<u64>,
    }

    public fun base_decimals(arg0: &Market) : u8 {
        arg0.base.decimals
    }

    public fun base_price_publish_time(arg0: &Market) : 0x1::option::Option<u64> {
        arg0.base.price_publish_time
    }

    public fun base_pyth_price_feed_id(arg0: &Market) : vector<u8> {
        arg0.base.pyth_price_feed_id
    }

    public fun base_type(arg0: &Market) : 0x1::type_name::TypeName {
        arg0.base.coin_type
    }

    public fun conf_ratio_bps(arg0: &Market) : 0x1::option::Option<u64> {
        arg0.conf_ratio_bps
    }

    public(friend) fun deepbook_price(arg0: &Market, arg1: 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::Price, arg2: 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::Price, arg3: u64) : (u64, u64) {
        let (v0, v1, v2) = deepbook_usd_price(arg1, arg3);
        let (v3, v4, v5) = deepbook_usd_price(arg2, arg3);
        let v6 = v4 + arg0.quote.decimals;
        let v7 = v1 + arg0.base.decimals;
        let v8 = if (v6 >= v7) {
            0x1::u128::mul_div(0x1::u128::pow(10, v6 - v7), (v0 as u128) * 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::float_scaling_u128(), (v3 as u128))
        } else {
            (v0 as u128) * 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::float_scaling_u128() / (v3 as u128) / 0x1::u128::pow(10, v7 - v6)
        };
        let v9 = 0x1::u128::try_as_u64(v8);
        if (0x1::option::is_some<u64>(&v9)) {
            let v10 = 0x1::option::destroy_some<u64>(v9);
            assert!(v10 >= 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::min_price(), 13836748245173010445);
            assert!(v10 <= 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::max_price(), 13837029724444819471);
            return (v10, v2 + v5)
        } else {
            0x1::option::destroy_none<u64>(v9);
            abort 13837029711559917583
        };
    }

    fun deepbook_usd_price(arg0: 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::Price, arg1: u64) : (u64, u8, u64) {
        let v0 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_price(&arg0);
        assert!(!0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_is_negative(&v0), 13835622405395185669);
        let v1 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_positive(&v0);
        assert!(v1 != 0, 13835622413985120261);
        let v2 = (0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_conf(&arg0) as u128) * 10000 / (v1 as u128);
        assert!(v2 <= (arg1 as u128), 13836466864685449227);
        let v3 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_expo(&arg0);
        assert!(0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_is_negative(&v3), 13835903936206602247);
        let v4 = 0x1::u64::try_as_u8(0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_negative(&v3));
        if (0x1::option::is_some<u8>(&v4)) {
            let v5 = 0x1::option::destroy_some<u8>(v4);
            assert!(v5 <= 19, 13836185432658280457);
            return (v1, v5, (v2 as u64))
        } else {
            0x1::option::destroy_none<u8>(v4);
            abort 13836185428363313161
        };
    }

    public fun has_valid_base_pyth_feed_id(arg0: &Market, arg1: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject) : bool {
        let v0 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::get_price_info_from_price_info_object(arg1);
        let v1 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::get_price_identifier(&v0);
        0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_identifier::get_bytes(&v1) == arg0.base.pyth_price_feed_id
    }

    public fun has_valid_pool<T0, T1>(arg0: &Market, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>) : bool {
        arg0.pool_id == 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1)
    }

    public fun has_valid_quote_pyth_feed_id(arg0: &Market, arg1: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject) : bool {
        let v0 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::get_price_info_from_price_info_object(arg1);
        let v1 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::get_price_identifier(&v0);
        0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_identifier::get_bytes(&v1) == arg0.quote.pyth_price_feed_id
    }

    public fun mid_price(arg0: &Market) : 0x1::option::Option<u64> {
        arg0.mid_price
    }

    public fun new<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &0x2::coin_registry::Currency<T0>, arg2: &0x2::coin_registry::Currency<T1>, arg3: vector<u8>, arg4: vector<u8>) : Market {
        assert!(0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::whitelisted<T0, T1>(arg0), 13837310263118790673);
        assert!(0x1::vector::length<u8>(&arg3) == 32, 13835058476188958721);
        assert!(0x1::vector::length<u8>(&arg4) == 32, 13835058493368827905);
        assert!(arg3 != arg4, 13837591776750338067);
        let v0 = 0x2::coin_registry::decimals<T0>(arg1);
        let v1 = 0x2::coin_registry::decimals<T1>(arg2);
        assert!(v0 <= 19, 13835339994115473411);
        assert!(v1 <= 19, 13835339998410440707);
        let v2 = MarketCurrency{
            coin_type          : 0x1::type_name::with_defining_ids<T0>(),
            decimals           : v0,
            pyth_price_feed_id : arg3,
            price_publish_time : 0x1::option::none<u64>(),
        };
        let v3 = MarketCurrency{
            coin_type          : 0x1::type_name::with_defining_ids<T1>(),
            decimals           : v1,
            pyth_price_feed_id : arg4,
            price_publish_time : 0x1::option::none<u64>(),
        };
        Market{
            pool_id        : 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg0),
            base           : v2,
            quote          : v3,
            mid_price      : 0x1::option::none<u64>(),
            conf_ratio_bps : 0x1::option::none<u64>(),
        }
    }

    public fun pool_id(arg0: &Market) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun quote_decimals(arg0: &Market) : u8 {
        arg0.quote.decimals
    }

    public fun quote_price_publish_time(arg0: &Market) : 0x1::option::Option<u64> {
        arg0.quote.price_publish_time
    }

    public fun quote_pyth_price_feed_id(arg0: &Market) : vector<u8> {
        arg0.quote.pyth_price_feed_id
    }

    public fun quote_type(arg0: &Market) : 0x1::type_name::TypeName {
        arg0.quote.coin_type
    }

    public(friend) fun reset_freshness_state(arg0: &mut Market) {
        arg0.base.price_publish_time = 0x1::option::none<u64>();
        arg0.quote.price_publish_time = 0x1::option::none<u64>();
        arg0.mid_price = 0x1::option::none<u64>();
        arg0.conf_ratio_bps = 0x1::option::none<u64>();
    }

    public(friend) fun set_latest_publish_times(arg0: &mut Market, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000;
        arg0.base.price_publish_time = 0x1::option::some<u64>(v0);
        arg0.quote.price_publish_time = 0x1::option::some<u64>(v0);
    }

    public(friend) fun set_price_and_conf(arg0: &mut Market, arg1: u64, arg2: u64) {
        arg0.mid_price = 0x1::option::some<u64>(arg1);
        arg0.conf_ratio_bps = 0x1::option::some<u64>(arg2);
    }

    public(friend) fun try_update_publish_times(arg0: &mut Market, arg1: 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::Price, arg2: 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::Price) : bool {
        let v0 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_timestamp(&arg1);
        let v1 = arg0.base.price_publish_time;
        let v2 = if (0x1::option::is_some<u64>(&v1)) {
            0x1::option::some<bool>(0x1::option::destroy_some<u64>(v1) < v0)
        } else {
            0x1::option::destroy_none<u64>(v1);
            0x1::option::none<bool>()
        };
        let v3 = v2;
        let v4 = if (0x1::option::is_some<bool>(&v3)) {
            0x1::option::destroy_some<bool>(v3)
        } else {
            0x1::option::destroy_none<bool>(v3);
            true
        };
        if (v4) {
            0x1::option::swap_or_fill<u64>(&mut arg0.base.price_publish_time, v0);
        };
        let v5 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_timestamp(&arg2);
        let v6 = arg0.quote.price_publish_time;
        let v7 = if (0x1::option::is_some<u64>(&v6)) {
            0x1::option::some<bool>(0x1::option::destroy_some<u64>(v6) < v5)
        } else {
            0x1::option::destroy_none<u64>(v6);
            0x1::option::none<bool>()
        };
        let v8 = v7;
        let v9 = if (0x1::option::is_some<bool>(&v8)) {
            0x1::option::destroy_some<bool>(v8)
        } else {
            0x1::option::destroy_none<bool>(v8);
            true
        };
        if (v9) {
            0x1::option::swap_or_fill<u64>(&mut arg0.quote.price_publish_time, v5);
        };
        v4 || v9
    }

    // decompiled from Move bytecode v7
}

