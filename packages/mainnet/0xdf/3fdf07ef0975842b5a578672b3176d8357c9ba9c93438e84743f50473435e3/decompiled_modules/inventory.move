module 0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::inventory {
    public fun calculate_ask_size(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = 2 * arg1 * arg2 / 1000;
        let v1 = if (1000 + v0 > arg2) {
            1000 + v0 - arg2
        } else {
            0
        };
        arg0 * v1 / 1000
    }

    public fun calculate_bid_size(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = 2 * arg1 * arg2 / 1000;
        let v1 = if (1000 + arg2 > v0) {
            1000 + arg2 - v0
        } else {
            0
        };
        arg0 * v1 / 1000
    }

    public fun calculate_inventory_ratio(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            return 500
        };
        let v0 = arg0 * 1000 / arg1;
        if (v0 > 1000) {
            1000
        } else {
            v0
        }
    }

    public fun calculate_mm_sizes(arg0: &0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::config::GlobalConfig, arg1: u64) : (u64, u64, u64, u64) {
        let v0 = calculate_inventory_ratio(arg1, 0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::config::max_position_sui(arg0));
        let v1 = 0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::config::skew_weight(arg0);
        let v2 = 0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::config::inner_base_size(arg0);
        let v3 = 0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::config::outer_base_size(arg0);
        let v4 = if (v0 > 500) {
            (v0 - 500) * v1 / 500
        } else {
            0
        };
        let v5 = if (v0 < 500) {
            (500 - v0) * v1 / 500
        } else {
            0
        };
        let v6 = if (v4 > 0) {
            if (1000 > v4) {
                1000 - v4
            } else {
                100
            }
        } else {
            1000 + v5
        };
        let v7 = if (v4 > 0) {
            1000 + v4
        } else if (1000 > v5) {
            1000 - v5
        } else {
            100
        };
        (v2 * v6 / 1000, v2 * v7 / 1000, v3 * v6 / 1000, v3 * v7 / 1000)
    }

    public fun check_ask_capacity(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : (u64, u64) {
        let v0 = if (arg0 > arg3) {
            arg0 - arg3
        } else {
            0
        };
        let v1 = arg1;
        let v2 = arg2;
        if (arg1 + arg2 > v0) {
            if (arg1 > v0) {
                v1 = v0;
                v2 = 0;
            } else {
                v2 = v0 - arg1;
            };
        };
        (v1, v2)
    }

    public fun check_bid_capacity(arg0: u64, arg1: u64, arg2: u64) : (u64, u64) {
        let v0 = arg1;
        let v1 = arg2;
        if (arg1 + arg2 > arg0) {
            if (arg1 > arg0) {
                v0 = arg0;
                v1 = 0;
            } else {
                v1 = arg0 - arg1;
            };
        };
        (v0, v1)
    }

    public fun needs_rebalance(arg0: u64, arg1: u64) : bool {
        let v0 = arg1 * 10;
        let v1 = if (1000 > v0) {
            1000 - v0
        } else {
            0
        };
        arg0 > v0 || arg0 < v1
    }

    public fun sui_to_usdc_estimate(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 1000000000) as u64)
    }

    public fun sui_value_in_usdc(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 1000000000) as u64)
    }

    // decompiled from Move bytecode v6
}

