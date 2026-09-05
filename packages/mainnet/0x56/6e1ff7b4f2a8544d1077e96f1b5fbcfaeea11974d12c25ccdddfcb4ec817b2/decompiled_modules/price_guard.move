module 0x63d5fa6a5e173de759525146d52148a8aa38168d3daffbbbc0ad382487b7c1ec::price_guard {
    struct Price has copy, drop, store {
        mag: u64,
        expo: u8,
        conf: u64,
        timestamp_s: u64,
    }

    public fun assert_confidence(arg0: &Price, arg1: u64) {
        assert!((arg0.conf as u256) * 10000 <= (arg0.mag as u256) * (arg1 as u256), 101);
    }

    public fun assert_fresh(arg0: &Price, arg1: u64, arg2: u64) {
        assert!(arg1 <= arg0.timestamp_s + arg2, 102);
    }

    public fun assert_pool_matches_reference(arg0: u128, arg1: u8, arg2: u8, arg3: &Price, arg4: &Price, arg5: u64, arg6: u64, arg7: u64, arg8: u64) {
        assert_fresh(arg3, arg5, arg6);
        assert_fresh(arg4, arg5, arg6);
        assert_confidence(arg3, arg7);
        assert_confidence(arg4, arg7);
        assert_within_deviation(pool_price_q64(arg0, arg1, arg2), reference_price_q64(arg3, arg4), arg8);
    }

    public fun assert_within_deviation(arg0: u256, arg1: u256, arg2: u64) {
        assert!(arg1 > 0, 103);
        let v0 = if (arg0 > arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        };
        assert!(v0 * 10000 <= arg1 * (arg2 as u256), 100);
    }

    public fun conf(arg0: &Price) : u64 {
        arg0.conf
    }

    public fun expo(arg0: &Price) : u8 {
        arg0.expo
    }

    public fun mag(arg0: &Price) : u64 {
        arg0.mag
    }

    public fun new_price(arg0: u64, arg1: u8, arg2: u64, arg3: u64) : Price {
        assert!(arg0 > 0, 103);
        assert!(arg1 <= 38, 104);
        Price{
            mag         : arg0,
            expo        : arg1,
            conf        : arg2,
            timestamp_s : arg3,
        }
    }

    public fun pool_price_q64(arg0: u128, arg1: u8, arg2: u8) : u256 {
        let v0 = (arg0 as u256);
        (v0 * v0 >> 64) * pow10(arg1) / pow10(arg2)
    }

    fun pow10(arg0: u8) : u256 {
        assert!(arg0 <= 38, 104);
        let v0 = 1;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 * 10;
            v1 = v1 + 1;
        };
        v0
    }

    public fun reference_price_q64(arg0: &Price, arg1: &Price) : u256 {
        let v0 = (arg1.mag as u256) * pow10(arg0.expo);
        assert!(v0 > 0, 103);
        ((arg0.mag as u256) * pow10(arg1.expo) << 64) / v0
    }

    public fun timestamp_s(arg0: &Price) : u64 {
        arg0.timestamp_s
    }

    // decompiled from Move bytecode v7
}

