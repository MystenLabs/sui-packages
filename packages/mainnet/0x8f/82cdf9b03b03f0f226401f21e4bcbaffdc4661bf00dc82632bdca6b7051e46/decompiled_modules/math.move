module 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::math {
    public fun calculate_mcr_pure(arg0: vector<0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::Decimal>, arg1: vector<0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::Decimal>) : 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::Decimal {
        let v0 = 0x1::vector::length<0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::Decimal>(&arg0);
        let v1 = 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::from(0);
        let v2 = 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::from(0);
        let v3 = 0;
        let v4 = 0;
        while (v4 < v0) {
            let v5 = *0x1::vector::borrow<0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::Decimal>(&arg0, v4);
            v1 = 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::add(v1, 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::mul(v5, v5));
            let v6 = v4 + 1;
            while (v6 < v0) {
                v2 = 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::add(v2, 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::mul(*0x1::vector::borrow<0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::Decimal>(&arg1, v3), 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::mul(v5, *0x1::vector::borrow<0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::Decimal>(&arg0, v6))));
                v3 = v3 + 1;
                v6 = v6 + 1;
            };
            v4 = v4 + 1;
        };
        0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::sqrt(0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::add(v1, 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::mul(0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::from(2), v2)))
    }

    public fun calculate_new_unit_value(arg0: 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::Decimal, arg1: u64, arg2: u64) : 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::Decimal {
        0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::mul(arg0, 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::saturating_sub(0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::from(1), 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::div(0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::from(arg1), 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::from(arg2))))
    }

    public fun calculate_premium(arg0: u64, arg1: u64, arg2: u64) : u64 {
        0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::floor(0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::mul(0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::mul(0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::from(arg0), 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::from_bps(arg1)), 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::div(0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::from(arg2), 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::from(31536000))))
    }

    public fun calculate_premium_rate(arg0: 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::Decimal, arg1: u64, arg2: u64, arg3: u64) : 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::Decimal {
        let v0 = 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::from_bps(arg2);
        if (0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::gt(arg0, v0)) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::add(0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::from_bps(arg1), 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::mul(0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::sub(arg0, v0), 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::from_bps(arg3)))
        } else {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::from_bps(arg1)
        }
    }

    public fun calculate_price_bump_bps(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg1 == 0) {
            return 0
        };
        0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::floor(0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::div(0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::mul(0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::from(arg2), 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::from(arg0)), 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::from(arg1)))
    }

    public fun calculate_utilization(arg0: u64, arg1: u64, arg2: u64) : 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::Decimal {
        if (arg1 == 0) {
            return 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::from(0)
        };
        0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::div(0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::from(arg0), 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::mul(0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::from(arg1), 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::from_bps(arg2)))
    }

    public fun get_base_price_bps(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        if (arg3 <= arg1) {
            return arg0
        };
        let v0 = 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::floor(0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::div(0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::mul(0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::from(arg4), 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::from(arg3 - arg1)), 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::from(86400)));
        if (arg0 <= arg2 + v0) {
            arg2
        } else {
            arg0 - v0
        }
    }

    // decompiled from Move bytecode v6
}

