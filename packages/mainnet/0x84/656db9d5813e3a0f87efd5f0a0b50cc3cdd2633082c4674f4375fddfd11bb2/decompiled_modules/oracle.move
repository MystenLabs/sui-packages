module 0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::oracle {
    struct TrustedPrice has copy, drop, store {
        price_1e8: u128,
        publish_time_ms: u64,
        confidence_bps: u16,
        source: u8,
    }

    public fun assert_confident(arg0: &TrustedPrice, arg1: u16) {
        assert!(arg0.confidence_bps <= arg1, 18);
    }

    public fun assert_consistent(arg0: &TrustedPrice, arg1: &TrustedPrice, arg2: u64) {
        let v0 = arg0.price_1e8;
        let v1 = arg1.price_1e8;
        let v2 = if (v0 >= v1) {
            v0
        } else {
            v1
        };
        let v3 = if (v0 >= v1) {
            v1
        } else {
            v0
        };
        if (v2 == 0) {
            return
        };
        assert!((((v2 - v3) * 10000 / v2) as u64) <= arg2, 19);
    }

    public fun assert_fresh(arg0: &TrustedPrice, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(arg0.publish_time_ms <= v0, 17);
        assert!(arg0.publish_time_ms + arg1 >= v0, 17);
    }

    public fun confidence_bps(arg0: &TrustedPrice) : u16 {
        arg0.confidence_bps
    }

    public fun new(arg0: u128, arg1: u64, arg2: u16, arg3: u8) : TrustedPrice {
        TrustedPrice{
            price_1e8       : arg0,
            publish_time_ms : arg1,
            confidence_bps  : arg2,
            source          : arg3,
        }
    }

    public fun price_1e8(arg0: &TrustedPrice) : u128 {
        arg0.price_1e8
    }

    public fun publish_time_ms(arg0: &TrustedPrice) : u64 {
        arg0.publish_time_ms
    }

    public fun pyth(arg0: u128, arg1: u64, arg2: u16) : TrustedPrice {
        new(arg0, arg1, arg2, 0)
    }

    public fun source(arg0: &TrustedPrice) : u8 {
        arg0.source
    }

    public fun stable_peg(arg0: u128, arg1: u64) : TrustedPrice {
        new(arg0, arg1, 0, 2)
    }

    public fun twap(arg0: u128, arg1: u64, arg2: u16) : TrustedPrice {
        new(arg0, arg1, arg2, 1)
    }

    // decompiled from Move bytecode v7
}

