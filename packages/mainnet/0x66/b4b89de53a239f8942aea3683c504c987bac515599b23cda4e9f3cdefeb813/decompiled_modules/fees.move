module 0x66b4b89de53a239f8942aea3683c504c987bac515599b23cda4e9f3cdefeb813::fees {
    struct BuyFeeWindow has copy, drop, store {
        period_start_ms: u64,
        period_used: u64,
        period_ms: u64,
        per_period_cap_bps: u64,
        per_trade_cap_bps: u64,
    }

    public fun apply_buy_fee(arg0: &mut BuyFeeWindow, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        if (v0 >= arg0.period_start_ms + arg0.period_ms) {
            arg0.period_start_ms = v0;
            arg0.period_used = 0;
        };
        if (arg0.per_trade_cap_bps > 0 && arg2 > 0) {
            assert!(arg1 <= 0x66b4b89de53a239f8942aea3683c504c987bac515599b23cda4e9f3cdefeb813::math::bps(arg2, arg0.per_trade_cap_bps), 0x66b4b89de53a239f8942aea3683c504c987bac515599b23cda4e9f3cdefeb813::errors::buy_fee_trade_exceeded());
        };
        if (arg0.per_period_cap_bps > 0 && arg3 > 0) {
            let v1 = 0x66b4b89de53a239f8942aea3683c504c987bac515599b23cda4e9f3cdefeb813::math::add(arg0.period_used, arg1);
            assert!(v1 <= 0x66b4b89de53a239f8942aea3683c504c987bac515599b23cda4e9f3cdefeb813::math::bps(arg3, arg0.per_period_cap_bps), 0x66b4b89de53a239f8942aea3683c504c987bac515599b23cda4e9f3cdefeb813::errors::buy_fee_period_exceeded());
            arg0.period_used = v1;
        } else {
            arg0.period_used = 0x66b4b89de53a239f8942aea3683c504c987bac515599b23cda4e9f3cdefeb813::math::add(arg0.period_used, arg1);
        };
    }

    public fun bump_hwm(arg0: &mut u64, arg1: u64) {
        if (arg1 > *arg0) {
            *arg0 = arg1;
        };
    }

    public fun compute_mgmt_fee_shares(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = if (arg3 <= arg2) {
            true
        } else if (arg1 == 0) {
            true
        } else {
            arg0 == 0
        };
        if (v0) {
            return 0
        };
        let v1 = (arg0 as u128) * (arg1 as u128) * ((arg3 - arg2) as u128) / (0x66b4b89de53a239f8942aea3683c504c987bac515599b23cda4e9f3cdefeb813::math::bps_denominator() as u128) * (0x66b4b89de53a239f8942aea3683c504c987bac515599b23cda4e9f3cdefeb813::math::seconds_per_year() as u128);
        assert!(v1 <= 18446744073709551615, 0x66b4b89de53a239f8942aea3683c504c987bac515599b23cda4e9f3cdefeb813::errors::overflow());
        (v1 as u64)
    }

    public fun compute_performance_fee(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = if (arg1 <= arg2) {
            true
        } else if (arg3 == 0) {
            true
        } else {
            arg0 == 0
        };
        if (v0) {
            return 0
        };
        0x66b4b89de53a239f8942aea3683c504c987bac515599b23cda4e9f3cdefeb813::math::bps(0x66b4b89de53a239f8942aea3683c504c987bac515599b23cda4e9f3cdefeb813::math::mul_div(arg0, arg1 - arg2, 1000000), arg3)
    }

    public fun new_buy_fee_window(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : BuyFeeWindow {
        assert!(arg0 > 0, 0x66b4b89de53a239f8942aea3683c504c987bac515599b23cda4e9f3cdefeb813::errors::bad_period_ms());
        BuyFeeWindow{
            period_start_ms    : arg3,
            period_used        : 0,
            period_ms          : arg0,
            per_period_cap_bps : arg1,
            per_trade_cap_bps  : arg2,
        }
    }

    public fun period_remaining(arg0: &BuyFeeWindow, arg1: u64, arg2: &0x2::clock::Clock) : u64 {
        if (0x2::clock::timestamp_ms(arg2) >= arg0.period_start_ms + arg0.period_ms) {
            return 0x66b4b89de53a239f8942aea3683c504c987bac515599b23cda4e9f3cdefeb813::math::bps(arg1, arg0.per_period_cap_bps)
        };
        let v0 = 0x66b4b89de53a239f8942aea3683c504c987bac515599b23cda4e9f3cdefeb813::math::bps(arg1, arg0.per_period_cap_bps);
        if (v0 <= arg0.period_used) {
            0
        } else {
            v0 - arg0.period_used
        }
    }

    public fun update_window_config(arg0: &mut BuyFeeWindow, arg1: u64, arg2: u64, arg3: u64) {
        assert!(arg1 > 0, 0x66b4b89de53a239f8942aea3683c504c987bac515599b23cda4e9f3cdefeb813::errors::bad_period_ms());
        arg0.period_ms = arg1;
        arg0.per_period_cap_bps = arg2;
        arg0.per_trade_cap_bps = arg3;
    }

    public fun window_period_ms(arg0: &BuyFeeWindow) : u64 {
        arg0.period_ms
    }

    public fun window_period_start_ms(arg0: &BuyFeeWindow) : u64 {
        arg0.period_start_ms
    }

    public fun window_period_used(arg0: &BuyFeeWindow) : u64 {
        arg0.period_used
    }

    // decompiled from Move bytecode v7
}

