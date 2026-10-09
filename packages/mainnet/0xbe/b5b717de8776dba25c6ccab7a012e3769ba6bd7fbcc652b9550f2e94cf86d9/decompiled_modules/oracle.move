module 0xbeb5b717de8776dba25c6ccab7a012e3769ba6bd7fbcc652b9550f2e94cf86d9::oracle {
    struct OraclePrice has copy, drop {
        price: u256,
        conf: u256,
        timestamp: u64,
    }

    public fun price(arg0: &OraclePrice) : u256 {
        arg0.price
    }

    public fun conf(arg0: &OraclePrice) : u256 {
        arg0.conf
    }

    public(friend) fun from_raw(arg0: u64, arg1: u64, arg2: bool, arg3: u64, arg4: u64, arg5: u64) : OraclePrice {
        assert!(arg0 > 0, 101);
        let v0 = normalize((arg0 as u256), arg2, arg3);
        let v1 = normalize((arg1 as u256), arg2, arg3);
        assert!(v0 > 0, 101);
        assert!(arg5 < 10000, 102);
        assert!(v1 * 10000 <= v0 * (arg5 as u256), 102);
        OraclePrice{
            price     : v0,
            conf      : v1,
            timestamp : arg4,
        }
    }

    public(friend) fun new(arg0: u256, arg1: u256, arg2: u64) : OraclePrice {
        assert!(arg0 > 0 && arg1 < arg0, 101);
        OraclePrice{
            price     : arg0,
            conf      : arg1,
            timestamp : arg2,
        }
    }

    fun normalize(arg0: u256, arg1: bool, arg2: u64) : u256 {
        if (arg1) {
            assert!(arg2 <= 18, 103);
            if (arg2 <= 9) {
                arg0 * pow10(9 - arg2)
            } else {
                arg0 / pow10(arg2 - 9)
            }
        } else {
            assert!(arg2 <= 9, 103);
            arg0 * 1000000000 * pow10(arg2)
        }
    }

    fun pow10(arg0: u64) : u256 {
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    public fun price_high(arg0: &OraclePrice) : u256 {
        arg0.price + arg0.conf
    }

    public fun price_low(arg0: &OraclePrice) : u256 {
        arg0.price - arg0.conf
    }

    public fun price_scale() : u256 {
        1000000000
    }

    public(friend) fun read(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg1: &0x2::clock::Clock, arg2: &vector<u8>, arg3: u64, arg4: u64) : OraclePrice {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg0);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v0);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v1);
        assert!(&v2 == arg2, 100);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_no_older_than(arg0, arg1, arg3);
        let v4 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v3);
        assert!(!0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v4), 101);
        let v5 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v3);
        let v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v5);
        let v7 = if (v6) {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v5)
        } else {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v5)
        };
        from_raw(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v4), 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_conf(&v3), v6, v7, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v3), arg4)
    }

    public fun timestamp(arg0: &OraclePrice) : u64 {
        arg0.timestamp
    }

    // decompiled from Move bytecode v7
}

