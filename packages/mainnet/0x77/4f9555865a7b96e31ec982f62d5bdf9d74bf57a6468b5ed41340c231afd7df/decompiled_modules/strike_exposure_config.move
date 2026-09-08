module 0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::strike_exposure_config {
    struct StrikeExposureConfig has store {
        backing_buffer_lambda: u64,
        base_fee: u64,
        min_fee: u64,
        min_entry_probability: u64,
        max_entry_probability: u64,
        expiry_fee_window_ms: u64,
        expiry_fee_max_multiplier: u64,
        inventory_impact_max_rate: u64,
    }

    public(friend) fun assert_mint_admission(arg0: &StrikeExposureConfig, arg1: u64, arg2: u64) : u64 {
        assert_mint_probability_policy(arg0, arg1);
        let v0 = 0xeb8212402af172cac87ef533a61a899334a75a745489432aaa31872fdc5ecb42::math::mul_down(arg1, arg2);
        assert!(v0 >= 1000000, 3);
        v0
    }

    public(friend) fun assert_mint_probability_policy(arg0: &StrikeExposureConfig, arg1: u64) {
        assert!(arg1 >= arg0.min_entry_probability && arg1 <= arg0.max_entry_probability, 0);
    }

    public(friend) fun backing_buffer_lambda(arg0: &StrikeExposureConfig) : u64 {
        arg0.backing_buffer_lambda
    }

    public(friend) fun base_fee(arg0: &StrikeExposureConfig) : u64 {
        arg0.base_fee
    }

    public(friend) fun expiry_fee_max_multiplier(arg0: &StrikeExposureConfig) : u64 {
        arg0.expiry_fee_max_multiplier
    }

    fun expiry_fee_multiplier(arg0: &StrikeExposureConfig, arg1: u64) : u64 {
        if (arg1 >= arg0.expiry_fee_window_ms) {
            return 1000000000
        };
        1000000000 + 0xeb8212402af172cac87ef533a61a899334a75a745489432aaa31872fdc5ecb42::math::mul_div_down(arg0.expiry_fee_max_multiplier - 1000000000, arg0.expiry_fee_window_ms - arg1, arg0.expiry_fee_window_ms)
    }

    public(friend) fun expiry_fee_window_ms(arg0: &StrikeExposureConfig) : u64 {
        arg0.expiry_fee_window_ms
    }

    fun fee_rate(arg0: &StrikeExposureConfig, arg1: u64, arg2: u64, arg3: u64) : u64 {
        0xeb8212402af172cac87ef533a61a899334a75a745489432aaa31872fdc5ecb42::math::mul_down(0x1::u64::max(raw_bernoulli_fee_rate(arg0, arg2), arg0.min_fee), expiry_fee_multiplier(arg0, arg1 - arg3))
    }

    public(friend) fun inventory_impact_max_rate(arg0: &StrikeExposureConfig) : u64 {
        arg0.inventory_impact_max_rate
    }

    public(friend) fun max_entry_probability(arg0: &StrikeExposureConfig) : u64 {
        arg0.max_entry_probability
    }

    public(friend) fun min_entry_probability(arg0: &StrikeExposureConfig) : u64 {
        arg0.min_entry_probability
    }

    public(friend) fun min_fee(arg0: &StrikeExposureConfig) : u64 {
        arg0.min_fee
    }

    public(friend) fun new() : StrikeExposureConfig {
        StrikeExposureConfig{
            backing_buffer_lambda     : 310000000,
            base_fee                  : 100000000,
            min_fee                   : 22000000,
            min_entry_probability     : 10000000,
            max_entry_probability     : 990000000,
            expiry_fee_window_ms      : 86400000,
            expiry_fee_max_multiplier : 1000000000,
            inventory_impact_max_rate : 0,
        }
    }

    fun raw_bernoulli_fee_rate(arg0: &StrikeExposureConfig, arg1: u64) : u64 {
        assert!(arg1 <= 1000000000, 2);
        if (arg1 == 0 || arg1 == 1000000000) {
            return 0
        };
        0xeb8212402af172cac87ef533a61a899334a75a745489432aaa31872fdc5ecb42::math::mul_down(arg0.base_fee, 0xeb8212402af172cac87ef533a61a899334a75a745489432aaa31872fdc5ecb42::math::sqrt_down(0xeb8212402af172cac87ef533a61a899334a75a745489432aaa31872fdc5ecb42::math::mul_down(arg1, 1000000000 - arg1)))
    }

    public(friend) fun set_backing_buffer_lambda(arg0: &mut StrikeExposureConfig, arg1: u64) {
        0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::config_constants::assert_backing_buffer_lambda(arg1);
        arg0.backing_buffer_lambda = arg1;
    }

    public(friend) fun set_base_fee(arg0: &mut StrikeExposureConfig, arg1: u64) {
        0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::config_constants::assert_base_fee(arg1);
        arg0.base_fee = arg1;
    }

    public(friend) fun set_expiry_fee_max_multiplier(arg0: &mut StrikeExposureConfig, arg1: u64) {
        0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::config_constants::assert_expiry_fee_max_multiplier(arg1);
        arg0.expiry_fee_max_multiplier = arg1;
    }

    public(friend) fun set_expiry_fee_window_ms(arg0: &mut StrikeExposureConfig, arg1: u64) {
        0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::config_constants::assert_expiry_fee_window_ms(arg1);
        arg0.expiry_fee_window_ms = arg1;
    }

    public(friend) fun set_inventory_impact_max_rate(arg0: &mut StrikeExposureConfig, arg1: u64) {
        0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::config_constants::assert_inventory_impact_max_rate(arg1);
        arg0.inventory_impact_max_rate = arg1;
    }

    public(friend) fun set_max_entry_probability(arg0: &mut StrikeExposureConfig, arg1: u64) {
        0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::config_constants::assert_max_entry_probability(arg1);
        assert!(arg1 > arg0.min_entry_probability, 1);
        arg0.max_entry_probability = arg1;
    }

    public(friend) fun set_min_entry_probability(arg0: &mut StrikeExposureConfig, arg1: u64) {
        0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::config_constants::assert_min_entry_probability(arg1);
        assert!(arg1 < arg0.max_entry_probability, 1);
        arg0.min_entry_probability = arg1;
    }

    public(friend) fun set_min_fee(arg0: &mut StrikeExposureConfig, arg1: u64) {
        0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::config_constants::assert_min_fee(arg1);
        arg0.min_fee = arg1;
    }

    public(friend) fun snapshot(arg0: &StrikeExposureConfig) : StrikeExposureConfig {
        StrikeExposureConfig{
            backing_buffer_lambda     : arg0.backing_buffer_lambda,
            base_fee                  : arg0.base_fee,
            min_fee                   : arg0.min_fee,
            min_entry_probability     : arg0.min_entry_probability,
            max_entry_probability     : arg0.max_entry_probability,
            expiry_fee_window_ms      : arg0.expiry_fee_window_ms,
            expiry_fee_max_multiplier : arg0.expiry_fee_max_multiplier,
            inventory_impact_max_rate : arg0.inventory_impact_max_rate,
        }
    }

    public(friend) fun trading_fee(arg0: &StrikeExposureConfig, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        0xeb8212402af172cac87ef533a61a899334a75a745489432aaa31872fdc5ecb42::math::mul_down(fee_rate(arg0, arg1, arg2, arg4), arg3)
    }

    // decompiled from Move bytecode v7
}

