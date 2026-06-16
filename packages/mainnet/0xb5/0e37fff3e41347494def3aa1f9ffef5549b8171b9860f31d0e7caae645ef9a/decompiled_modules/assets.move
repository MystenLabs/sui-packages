module 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::assets {
    struct BoundedValueChecker has copy, drop, store {
        upper_bound: u64,
        lower_bound: u64,
    }

    struct BoundedAssetConfig has store {
        source: u8,
        feed_bound: BoundedValueChecker,
        ema_feed_bound: BoundedValueChecker,
    }

    public(friend) fun ensure_value_bounded(arg0: &BoundedValueChecker, arg1: u64) {
        assert!(arg0.lower_bound <= arg1, 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::oracle_error::value_below_lower_bound());
        assert!(arg1 <= arg0.upper_bound, 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::oracle_error::value_above_upper_bound());
    }

    public(friend) fun ensure_within_bounds(arg0: &BoundedAssetConfig, arg1: u64, arg2: u64) {
        ensure_value_bounded(&arg0.feed_bound, arg1);
        ensure_value_bounded(&arg0.ema_feed_bound, arg2);
    }

    public(friend) fun new(arg0: u64, arg1: u64) : BoundedValueChecker {
        assert!(arg1 < arg0, 0xbc3765f20da7192407de1a2cf92082982ad73fac247bc10a29933ad0766b6735::oracle_error::invalid_bound());
        BoundedValueChecker{
            upper_bound : arg0,
            lower_bound : arg1,
        }
    }

    public(friend) fun new_config(arg0: u8, arg1: BoundedValueChecker, arg2: BoundedValueChecker) : BoundedAssetConfig {
        BoundedAssetConfig{
            source         : arg0,
            feed_bound     : arg1,
            ema_feed_bound : arg2,
        }
    }

    public(friend) fun set_bounds(arg0: &mut BoundedAssetConfig, arg1: BoundedValueChecker, arg2: BoundedValueChecker) {
        arg0.feed_bound = arg1;
        arg0.ema_feed_bound = arg2;
    }

    public(friend) fun stork_source() : u8 {
        2
    }

    // decompiled from Move bytecode v7
}

