module 0x28714f9f4af4307d975d05155ec4ce7d5de85f63f06d2e4de4463ff20cb16575::liquidity_configurations {
    struct LiquidityConfig has copy, drop, store {
        distribution_x: u64,
        distribution_y: u64,
        id: u32,
    }

    public fun apply_distribution(arg0: &LiquidityConfig, arg1: u64, arg2: u64) : (u64, u64) {
        (0x28714f9f4af4307d975d05155ec4ce7d5de85f63f06d2e4de4463ff20cb16575::safe_math::mul_div_u64(arg1, arg0.distribution_x, 0x28714f9f4af4307d975d05155ec4ce7d5de85f63f06d2e4de4463ff20cb16575::constants::precision()), 0x28714f9f4af4307d975d05155ec4ce7d5de85f63f06d2e4de4463ff20cb16575::safe_math::mul_div_u64(arg2, arg0.distribution_y, 0x28714f9f4af4307d975d05155ec4ce7d5de85f63f06d2e4de4463ff20cb16575::constants::precision()))
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
        0x28714f9f4af4307d975d05155ec4ce7d5de85f63f06d2e4de4463ff20cb16575::constants::precision()
    }

    public fun new_config(arg0: u64, arg1: u64, arg2: u32) : LiquidityConfig {
        assert!(arg0 <= 0x28714f9f4af4307d975d05155ec4ce7d5de85f63f06d2e4de4463ff20cb16575::constants::precision(), 401);
        assert!(arg1 <= 0x28714f9f4af4307d975d05155ec4ce7d5de85f63f06d2e4de4463ff20cb16575::constants::precision(), 401);
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
            v0 = v0 + v3.distribution_x;
            v1 = v1 + v3.distribution_y;
            v2 = v2 + 1;
        };
        v0 <= 0x28714f9f4af4307d975d05155ec4ce7d5de85f63f06d2e4de4463ff20cb16575::constants::precision() && v1 <= 0x28714f9f4af4307d975d05155ec4ce7d5de85f63f06d2e4de4463ff20cb16575::constants::precision()
    }

    // decompiled from Move bytecode v6
}

