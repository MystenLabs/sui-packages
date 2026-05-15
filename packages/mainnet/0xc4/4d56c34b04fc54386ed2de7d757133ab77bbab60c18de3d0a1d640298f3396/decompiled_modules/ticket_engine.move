module 0xc44d56c34b04fc54386ed2de7d757133ab77bbab60c18de3d0a1d640298f3396::ticket_engine {
    fun apply_multiplier(arg0: u64, arg1: u64) : u64 {
        arg0 * arg1 / 10000
    }

    public fun gate_pulse() : u64 {
        50
    }

    public fun gate_spark() : u64 {
        10
    }

    public fun gate_surge() : u64 {
        200
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
        10
    }

    public fun pulse_tickets(arg0: u64, arg1: &0xc44d56c34b04fc54386ed2de7d757133ab77bbab60c18de3d0a1d640298f3396::loyalty_tracker::LoyaltyRecord, arg2: &0x2::clock::Clock) : u64 {
        assert!(arg0 >= 10, 1);
        if (arg0 < 50) {
            return 0
        };
        let v0 = if (arg0 <= 1000) {
            arg0
        } else {
            1000 + isqrt(arg0 - 1000)
        };
        apply_multiplier(v0, 0xc44d56c34b04fc54386ed2de7d757133ab77bbab60c18de3d0a1d640298f3396::loyalty_tracker::multiplier_bp(arg1, arg2))
    }

    public fun spark_cap() : u64 {
        500
    }

    public fun spark_tickets(arg0: u64, arg1: &0xc44d56c34b04fc54386ed2de7d757133ab77bbab60c18de3d0a1d640298f3396::loyalty_tracker::LoyaltyRecord, arg2: &0x2::clock::Clock) : u64 {
        assert!(arg0 >= 10, 1);
        if (arg0 < 10) {
            return 0
        };
        let v0 = if (arg0 > 500) {
            500
        } else {
            arg0
        };
        apply_multiplier(v0, 0xc44d56c34b04fc54386ed2de7d757133ab77bbab60c18de3d0a1d640298f3396::loyalty_tracker::multiplier_bp(arg1, arg2))
    }

    public fun surge_tickets(arg0: u64, arg1: &0xc44d56c34b04fc54386ed2de7d757133ab77bbab60c18de3d0a1d640298f3396::loyalty_tracker::LoyaltyRecord, arg2: &0x2::clock::Clock) : u64 {
        assert!(arg0 >= 10, 1);
        if (arg0 < 200) {
            return 0
        };
        apply_multiplier(arg0, 0xc44d56c34b04fc54386ed2de7d757133ab77bbab60c18de3d0a1d640298f3396::loyalty_tracker::multiplier_bp(arg1, arg2))
    }

    // decompiled from Move bytecode v7
}

