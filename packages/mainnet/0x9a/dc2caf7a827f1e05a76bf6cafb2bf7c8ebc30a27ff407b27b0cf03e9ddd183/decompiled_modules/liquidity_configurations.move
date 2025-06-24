module 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::liquidity_configurations {
    struct LiquidityConfig has copy, drop, store {
        distribution_x: u64,
        distribution_y: u64,
        id: u32,
    }

    public fun apply_distribution(arg0: &LiquidityConfig, arg1: u128, arg2: u128) : (u128, u128) {
        (0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::safe_math::mul_div(arg1, arg0.distribution_x, 1000000000000000000), 0x9adc2caf7a827f1e05a76bf6cafb2bf7c8ebc30a27ff407b27b0cf03e9ddd183::safe_math::mul_div(arg2, arg0.distribution_y, 1000000000000000000))
    }

    public fun get_config_values(arg0: &LiquidityConfig) : (u64, u64, u32) {
        (arg0.distribution_x, arg0.distribution_y, arg0.id)
    }

    public fun get_distribution_x(arg0: &LiquidityConfig) : u64 {
        arg0.distribution_x
    }

    public fun get_distribution_y(arg0: &LiquidityConfig) : u64 {
        arg0.distribution_y
    }

    public fun get_id(arg0: &LiquidityConfig) : u32 {
        arg0.id
    }

    public fun get_precision() : u64 {
        1000000000000000000
    }

    public fun new_config(arg0: u64, arg1: u64, arg2: u32) : LiquidityConfig {
        assert!(arg0 <= 1000000000000000000, 401);
        assert!(arg1 <= 1000000000000000000, 401);
        LiquidityConfig{
            distribution_x : arg0,
            distribution_y : arg1,
            id             : arg2,
        }
    }

    public fun validate_distributions(arg0: &vector<LiquidityConfig>) : bool {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<LiquidityConfig>(arg0)) {
            let v3 = 0x1::vector::borrow<LiquidityConfig>(arg0, v2);
            v0 = v0 + (v3.distribution_x as u128);
            v1 = v1 + (v3.distribution_y as u128);
            v2 = v2 + 1;
        };
        v0 <= (1000000000000000000 as u128) && v1 <= (1000000000000000000 as u128)
    }

    // decompiled from Move bytecode v6
}

