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
        let v0 = 0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::config::skew_weight(arg0);
        let v1 = calculate_inventory_ratio(arg1, 0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::config::max_position_sui(arg0));
        let v2 = if (0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::config::outer_tier_enabled(arg0)) {
            calculate_bid_size(0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::config::outer_base_size(arg0), v1, v0)
        } else {
            0
        };
        let v3 = if (0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::config::outer_tier_enabled(arg0)) {
            calculate_ask_size(0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::config::outer_base_size(arg0), v1, v0)
        } else {
            0
        };
        (calculate_bid_size(0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::config::inner_base_size(arg0), v1, v0), calculate_ask_size(0xb6cc84cbb4e8c2403fbd7a462490fa80a45ec4853d1f043b8fe148bdeef7df09::config::inner_base_size(arg0), v1, v0), v2, v3)
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

    public fun sui_value_in_usdc(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / 1000000000) as u64)
    }

    // decompiled from Move bytecode v6
}

