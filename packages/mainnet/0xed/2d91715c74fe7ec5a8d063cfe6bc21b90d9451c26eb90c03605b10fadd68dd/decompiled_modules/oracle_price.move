module 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::oracle_price {
    struct Quote has copy, drop {
        price: u64,
        conf: 0x1::option::Option<u64>,
        expo_neg: u64,
    }

    struct PriceData has copy, drop {
        spot: Quote,
        smoothed: 0x1::option::Option<Quote>,
        timestamp_sec: u64,
    }

    struct PriceCollection has copy, drop {
        map: 0x2::vec_map::VecMap<0x2::object::ID, PriceData>,
        decimals: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u8>,
        created_at_sec: u64,
    }

    struct ValidatedPrices has copy, drop {
        map: 0x2::vec_map::VecMap<0x1::type_name::TypeName, PriceData>,
        decimals: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u8>,
        current_ts_sec: u64,
        max_age_secs: u64,
    }

    public fun decimals(arg0: &ValidatedPrices, arg1: 0x1::type_name::TypeName) : u8 {
        *0x2::vec_map::get<0x1::type_name::TypeName, u8>(&arg0.decimals, &arg1)
    }

    public fun add_currency<T0>(arg0: &mut PriceCollection, arg1: &0x2::coin_registry::Currency<T0>) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::vec_map::contains<0x1::type_name::TypeName, u8>(&arg0.decimals, &v0)) {
            return
        };
        0x2::vec_map::insert<0x1::type_name::TypeName, u8>(&mut arg0.decimals, v0, 0x2::coin_registry::decimals<T0>(arg1));
    }

    public fun add_pyth_pro(arg0: &mut PriceCollection, arg1: &0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject) {
        let v0 = 0x2::object::id<0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::PriceInfoObject>(arg1);
        if (0x2::vec_map::contains<0x2::object::ID, PriceData>(&arg0.map, &v0)) {
            return
        };
        let v1 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::get_price_info_from_price_info_object(arg1);
        let v2 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_info::get_price_feed(&v1);
        let v3 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_feed::get_price(v2);
        let v4 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price_feed::get_ema_price(v2);
        let v5 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_price(&v3);
        let v6 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_expo(&v3);
        let v7 = Quote{
            price    : 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_positive(&v5),
            conf     : 0x1::option::some<u64>(0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_conf(&v3)),
            expo_neg : 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_negative(&v6),
        };
        let v8 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_price(&v4);
        let v9 = 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_expo(&v4);
        let v10 = Quote{
            price    : 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_positive(&v8),
            conf     : 0x1::option::some<u64>(0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_conf(&v4)),
            expo_neg : 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::i64::get_magnitude_if_negative(&v9),
        };
        let v11 = PriceData{
            spot          : v7,
            smoothed      : 0x1::option::some<Quote>(v10),
            timestamp_sec : 0x55300367a2d40813727ccac4ecee977a39fb9cdb46f2e6b2c354b9798f5de2c0::price::get_timestamp(&v3),
        };
        0x2::vec_map::insert<0x2::object::ID, PriceData>(&mut arg0.map, v0, v11);
    }

    public fun create(arg0: &0x2::clock::Clock) : PriceCollection {
        PriceCollection{
            map            : 0x2::vec_map::empty<0x2::object::ID, PriceData>(),
            decimals       : 0x2::vec_map::empty<0x1::type_name::TypeName, u8>(),
            created_at_sec : 0x2::clock::timestamp_ms(arg0) / 1000,
        }
    }

    fun div_numeric_x128_inner(arg0: &ValidatedPrices, arg1: 0x1::type_name::TypeName, arg2: 0x1::type_name::TypeName, arg3: bool) : u256 {
        let (v0, v1, v2) = if (arg3) {
            let v3 = get_smoothed_price(arg0, arg1);
            quote_price_expo_dec(arg0, &v3, arg1)
        } else {
            let v4 = get_price(arg0, arg1);
            quote_price_expo_dec(arg0, &v4, arg1)
        };
        let (v5, v6, v7) = if (arg3) {
            let v8 = get_smoothed_price(arg0, arg2);
            quote_price_expo_dec(arg0, &v8, arg2)
        } else {
            let v9 = get_price(arg0, arg2);
            quote_price_expo_dec(arg0, &v9, arg2)
        };
        let (v10, v11) = if (v6 + v7 > v1 + v2) {
            (0x1::u64::pow(10, ((v6 + v7 - v1 - v2) as u8)), 1)
        } else {
            (1, 0x1::u64::pow(10, ((v1 + v2 - v6 - v7) as u8)))
        };
        assert!(v5 > 0, 2);
        let v12 = ((v0 as u256) * (v10 as u256) << 128) / (v5 as u256) * (v11 as u256);
        assert!(v12 <= 6277101735386680763835789423207666416102355444464034512895, 2);
        v12
    }

    public fun div_price_numeric_x128(arg0: &ValidatedPrices, arg1: 0x1::type_name::TypeName, arg2: 0x1::type_name::TypeName) : u256 {
        div_numeric_x128_inner(arg0, arg1, arg2, false)
    }

    public fun div_smoothed_price_numeric_x128(arg0: &ValidatedPrices, arg1: 0x1::type_name::TypeName, arg2: 0x1::type_name::TypeName) : u256 {
        div_numeric_x128_inner(arg0, arg1, arg2, true)
    }

    public fun get_price(arg0: &ValidatedPrices, arg1: 0x1::type_name::TypeName) : Quote {
        0x2::vec_map::get<0x1::type_name::TypeName, PriceData>(&arg0.map, &arg1).spot
    }

    public fun get_smoothed_price(arg0: &ValidatedPrices, arg1: 0x1::type_name::TypeName) : Quote {
        let v0 = 0x2::vec_map::get<0x1::type_name::TypeName, PriceData>(&arg0.map, &arg1);
        assert!(0x1::option::is_some<Quote>(&v0.smoothed), 4);
        *0x1::option::borrow<Quote>(&v0.smoothed)
    }

    public fun max_age_secs(arg0: &ValidatedPrices) : u64 {
        arg0.max_age_secs
    }

    public fun quote_conf(arg0: &Quote) : 0x1::option::Option<u64> {
        arg0.conf
    }

    public fun quote_expo_neg(arg0: &Quote) : u64 {
        arg0.expo_neg
    }

    public fun quote_price(arg0: &Quote) : u64 {
        arg0.price
    }

    fun quote_price_expo_dec(arg0: &ValidatedPrices, arg1: &Quote, arg2: 0x1::type_name::TypeName) : (u64, u64, u64) {
        (arg1.price, arg1.expo_neg, (decimals(arg0, arg2) as u64))
    }

    public(friend) fun validate(arg0: &PriceCollection, arg1: u64, arg2: &0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x2::object::ID>) : ValidatedPrices {
        let v0 = 0x2::vec_map::empty<0x1::type_name::TypeName, PriceData>();
        let v1 = 0x2::vec_map::empty<0x1::type_name::TypeName, u8>();
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x2::vec_map::length<0x1::type_name::TypeName, 0x2::object::ID>(arg2)) {
            let (v4, v5) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, 0x2::object::ID>(arg2, v3);
            let v6 = 0x2::vec_map::try_get<0x2::object::ID, PriceData>(&arg0.map, v5);
            assert!(0x1::option::is_some<PriceData>(&v6), 3);
            let v7 = 0x1::option::destroy_some<PriceData>(v6);
            assert!(v7.timestamp_sec <= arg0.created_at_sec + 60, 6);
            let v8 = 0x1::u64::saturating_sub(arg0.created_at_sec, v7.timestamp_sec);
            assert!(v8 <= arg1, 1);
            v2 = 0x1::u64::max(v2, v8);
            let v9 = 0x2::vec_map::try_get<0x1::type_name::TypeName, u8>(&arg0.decimals, v4);
            assert!(0x1::option::is_some<u8>(&v9), 5);
            0x2::vec_map::insert<0x1::type_name::TypeName, PriceData>(&mut v0, *v4, v7);
            0x2::vec_map::insert<0x1::type_name::TypeName, u8>(&mut v1, *v4, 0x1::option::destroy_some<u8>(v9));
            v3 = v3 + 1;
        };
        ValidatedPrices{
            map            : v0,
            decimals       : v1,
            current_ts_sec : arg0.created_at_sec,
            max_age_secs   : v2,
        }
    }

    // decompiled from Move bytecode v7
}

