module 0x330aa337772418f68117556dce74034063f11a8de68f60a99acc9a5ee62f5fb3::ticket_engine {
    fun apply_multiplier(arg0: u64, arg1: u64) : u64 {
        arg0 * arg1 / 10000
    }

    public fun gate_pulse() : u64 {
        10
    }

    public fun gate_spark() : u64 {
        1
    }

    public fun gate_surge() : u64 {
        50
    }

    fun isqrt(arg0: u64) : u64 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = (arg0 + 1) / 2;
        while (v0 < arg0) {
            let v1 = v0 + arg0 / v0;
            v0 = v1 / 2;
        };
        arg0
    }

    public fun min_stake() : u64 {
        1
    }

    public fun pulse_tickets(arg0: u64, arg1: &0x330aa337772418f68117556dce74034063f11a8de68f60a99acc9a5ee62f5fb3::loyalty_tracker::LoyaltyRecord, arg2: &0x2::clock::Clock) : u64 {
        assert!(arg0 >= 1, 1);
        if (arg0 < 10) {
            return 0
        };
        let v0 = apply_multiplier(isqrt(arg0), 0x330aa337772418f68117556dce74034063f11a8de68f60a99acc9a5ee62f5fb3::loyalty_tracker::multiplier_bp(arg1, arg2));
        if (v0 == 0) {
            1
        } else {
            v0
        }
    }

    public fun spark_cap() : u64 {
        1
    }

    public fun spark_tickets(arg0: u64, arg1: &0x330aa337772418f68117556dce74034063f11a8de68f60a99acc9a5ee62f5fb3::loyalty_tracker::LoyaltyRecord, arg2: &0x2::clock::Clock) : u64 {
        assert!(arg0 >= 1, 1);
        if (arg0 < 1) {
            return 0
        };
        1
    }

    public fun surge_tickets(arg0: u64, arg1: &0x330aa337772418f68117556dce74034063f11a8de68f60a99acc9a5ee62f5fb3::loyalty_tracker::LoyaltyRecord, arg2: &0x2::clock::Clock) : u64 {
        assert!(arg0 >= 1, 1);
        if (arg0 < 50) {
            return 0
        };
        let v0 = apply_multiplier(isqrt(arg0), 0x330aa337772418f68117556dce74034063f11a8de68f60a99acc9a5ee62f5fb3::loyalty_tracker::multiplier_bp(arg1, arg2));
        if (v0 == 0) {
            1
        } else {
            v0
        }
    }

    // decompiled from Move bytecode v7
}

