module 0xb1a05bf52e569b01903aca8f92fee1e4393f085e477f198f4b72f581136b17a3::economics {
    struct EconomicConfig has copy, drop, store {
        tier_1_floor: u64,
        tier_2_floor: u64,
        tier_3_floor: u64,
        tier_1_burn_bps: u64,
        tier_2_burn_bps: u64,
        tier_3_burn_bps: u64,
        tier_4_burn_bps: u64,
        tier_1_liquidity_bps: u64,
        tier_2_liquidity_bps: u64,
        tier_3_liquidity_bps: u64,
        tier_4_liquidity_bps: u64,
        treasury_bps: u64,
    }

    public fun burn_bps(arg0: u64, arg1: &EconomicConfig) : u64 {
        if (arg0 > arg1.tier_1_floor) {
            arg1.tier_1_burn_bps
        } else if (arg0 > arg1.tier_2_floor) {
            arg1.tier_2_burn_bps
        } else if (arg0 > arg1.tier_3_floor) {
            arg1.tier_3_burn_bps
        } else {
            arg1.tier_4_burn_bps
        }
    }

    public fun calculate_burn_fee(arg0: u64) : u64 {
        arg0 * 1 / 100000
    }

    public fun calculate_purchase_splits(arg0: u64, arg1: u64, arg2: &EconomicConfig) : (u64, u64, u64, u64) {
        (arg0 * burn_bps(arg1, arg2) / 10000, arg0 * liquidity_bps(arg1, arg2) / 10000, arg0 * uploader_bps(arg1, arg2) / 10000, arg0 * arg2.treasury_bps / 10000)
    }

    public fun calculate_reward(arg0: u64, arg1: u8) : u64 {
        if (arg1 < 30) {
            0
        } else if (arg1 < 50) {
            arg0 * 1 / 100000
        } else if (arg1 < 70) {
            arg0 * 25 / 1000000
        } else if (arg1 < 90) {
            arg0 * 4 / 100000
        } else {
            arg0 * 5 / 100000
        }
    }

    public fun create_config(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64) : EconomicConfig {
        EconomicConfig{
            tier_1_floor         : arg0,
            tier_2_floor         : arg1,
            tier_3_floor         : arg2,
            tier_1_burn_bps      : arg3,
            tier_2_burn_bps      : arg4,
            tier_3_burn_bps      : arg5,
            tier_4_burn_bps      : arg6,
            tier_1_liquidity_bps : arg7,
            tier_2_liquidity_bps : arg8,
            tier_3_liquidity_bps : arg9,
            tier_4_liquidity_bps : arg10,
            treasury_bps         : arg11,
        }
    }

    public fun default_config() : EconomicConfig {
        EconomicConfig{
            tier_1_floor         : 50000000000000000,
            tier_2_floor         : 35000000000000000,
            tier_3_floor         : 20000000000000000,
            tier_1_burn_bps      : 6000,
            tier_2_burn_bps      : 4500,
            tier_3_burn_bps      : 3000,
            tier_4_burn_bps      : 2000,
            tier_1_liquidity_bps : 0,
            tier_2_liquidity_bps : 1000,
            tier_3_liquidity_bps : 1500,
            tier_4_liquidity_bps : 2000,
            treasury_bps         : 1000,
        }
    }

    public fun get_tier(arg0: u64, arg1: &EconomicConfig) : u8 {
        if (arg0 > arg1.tier_1_floor) {
            1
        } else if (arg0 > arg1.tier_2_floor) {
            2
        } else if (arg0 > arg1.tier_3_floor) {
            3
        } else {
            4
        }
    }

    public fun liquidity_bps(arg0: u64, arg1: &EconomicConfig) : u64 {
        if (arg0 > arg1.tier_1_floor) {
            arg1.tier_1_liquidity_bps
        } else if (arg0 > arg1.tier_2_floor) {
            arg1.tier_2_liquidity_bps
        } else if (arg0 > arg1.tier_3_floor) {
            arg1.tier_3_liquidity_bps
        } else {
            arg1.tier_4_liquidity_bps
        }
    }

    public fun tier_1_floor(arg0: &EconomicConfig) : u64 {
        arg0.tier_1_floor
    }

    public fun tier_2_floor(arg0: &EconomicConfig) : u64 {
        arg0.tier_2_floor
    }

    public fun tier_3_floor(arg0: &EconomicConfig) : u64 {
        arg0.tier_3_floor
    }

    public fun treasury_bps(arg0: &EconomicConfig) : u64 {
        arg0.treasury_bps
    }

    public fun uploader_bps(arg0: u64, arg1: &EconomicConfig) : u64 {
        10000 - burn_bps(arg0, arg1) - liquidity_bps(arg0, arg1) - arg1.treasury_bps
    }

    public fun validate_config(arg0: &EconomicConfig) : bool {
        if (arg0.tier_1_burn_bps + arg0.tier_1_liquidity_bps + arg0.treasury_bps > 10000) {
            return false
        };
        if (arg0.tier_2_burn_bps + arg0.tier_2_liquidity_bps + arg0.treasury_bps > 10000) {
            return false
        };
        if (arg0.tier_3_burn_bps + arg0.tier_3_liquidity_bps + arg0.treasury_bps > 10000) {
            return false
        };
        if (arg0.tier_4_burn_bps + arg0.tier_4_liquidity_bps + arg0.treasury_bps > 10000) {
            return false
        };
        true
    }

    // decompiled from Move bytecode v6
}

