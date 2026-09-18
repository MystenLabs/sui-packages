module 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units {
    struct DurationS has copy, drop, store {
        pos0: u64,
    }

    struct TimestampS has copy, drop, store {
        pos0: u64,
    }

    public fun add_ts(arg0: TimestampS, arg1: DurationS) : TimestampS {
        TimestampS{pos0: arg0.pos0 + arg1.pos0}
    }

    public fun clock_seconds(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    public fun elapsed_since(arg0: TimestampS, arg1: TimestampS) : DurationS {
        assert!(arg0.pos0 >= arg1.pos0, 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::errors::overflow());
        DurationS{pos0: arg0.pos0 - arg1.pos0}
    }

    public fun from_clock(arg0: &0x2::clock::Clock) : TimestampS {
        TimestampS{pos0: 0x2::clock::timestamp_ms(arg0) / 1000}
    }

    public fun from_seconds(arg0: u64) : DurationS {
        DurationS{pos0: arg0}
    }

    public fun ge_ts(arg0: TimestampS, arg1: TimestampS) : bool {
        arg0.pos0 >= arg1.pos0
    }

    public fun gt_ts(arg0: TimestampS, arg1: TimestampS) : bool {
        arg0.pos0 > arg1.pos0
    }

    public fun is_zero(arg0: DurationS) : bool {
        arg0.pos0 == 0
    }

    public fun is_zero_ts(arg0: TimestampS) : bool {
        arg0.pos0 == 0
    }

    public fun le(arg0: DurationS, arg1: DurationS) : bool {
        arg0.pos0 <= arg1.pos0
    }

    public fun le_ts(arg0: TimestampS, arg1: TimestampS) : bool {
        arg0.pos0 <= arg1.pos0
    }

    public fun max_ts(arg0: TimestampS, arg1: TimestampS) : TimestampS {
        if (arg0.pos0 > arg1.pos0) {
            arg0
        } else {
            arg1
        }
    }

    public fun min_ts(arg0: TimestampS, arg1: TimestampS) : TimestampS {
        if (arg0.pos0 < arg1.pos0) {
            arg0
        } else {
            arg1
        }
    }

    public fun raw(arg0: DurationS) : u64 {
        arg0.pos0
    }

    public fun raw_ts(arg0: TimestampS) : u64 {
        arg0.pos0
    }

    public fun timestamp_from_seconds(arg0: u64) : TimestampS {
        TimestampS{pos0: arg0}
    }

    public fun zero_ts() : TimestampS {
        TimestampS{pos0: 0}
    }

    // decompiled from Move bytecode v7
}

