module 0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::protocol_config {
    struct ProtocolConfig has copy, drop, store {
        margin_pool_config: MarginPoolConfig,
        interest_config: InterestConfig,
        extra_fields: 0x2::vec_map::VecMap<0x1::string::String, u64>,
    }

    struct MarginPoolConfig has copy, drop, store {
        supply_cap: u64,
        max_utilization_rate: u64,
        protocol_spread: u64,
        min_borrow: u64,
        rate_limit_capacity: u64,
        rate_limit_refill_rate_per_ms: u64,
        rate_limit_enabled: bool,
    }

    struct InterestConfig has copy, drop, store {
        base_rate: u64,
        base_slope: u64,
        optimal_utilization: u64,
        excess_slope: u64,
    }

    public(friend) fun base_rate(arg0: &ProtocolConfig) : u64 {
        arg0.interest_config.base_rate
    }

    public(friend) fun base_slope(arg0: &ProtocolConfig) : u64 {
        arg0.interest_config.base_slope
    }

    public(friend) fun calculate_interest_with_borrow(arg0: &ProtocolConfig, arg1: u64, arg2: u64, arg3: u64) : u64 {
        0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::math::mul(0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::math::mul(arg3, interest_rate(arg0, arg1)), 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::math::div(arg2, 0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_constants::year_ms()))
    }

    public(friend) fun excess_slope(arg0: &ProtocolConfig) : u64 {
        arg0.interest_config.excess_slope
    }

    public(friend) fun interest_rate(arg0: &ProtocolConfig, arg1: u64) : u64 {
        let v0 = arg0.interest_config.optimal_utilization;
        if (arg1 < v0) {
            0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::math::mul(arg1, arg0.interest_config.base_slope) + arg0.interest_config.base_rate
        } else {
            arg0.interest_config.base_rate + 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::math::mul(v0, arg0.interest_config.base_slope) + 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::math::mul(arg1 - v0, arg0.interest_config.excess_slope)
        }
    }

    public(friend) fun max_utilization_rate(arg0: &ProtocolConfig) : u64 {
        arg0.margin_pool_config.max_utilization_rate
    }

    public(friend) fun min_borrow(arg0: &ProtocolConfig) : u64 {
        arg0.margin_pool_config.min_borrow
    }

    public fun new_interest_config(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : InterestConfig {
        assert!(arg2 <= 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::constants::float_scaling(), 1);
        InterestConfig{
            base_rate           : arg0,
            base_slope          : arg1,
            optimal_utilization : arg2,
            excess_slope        : arg3,
        }
    }

    public fun new_margin_pool_config(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : MarginPoolConfig {
        assert!(arg1 <= 0x1871df7998daea665dea310a930be8e870f1abd0b7530f5e1cb0cf096de5977f::constants::float_scaling(), 1);
        assert!(arg3 >= 0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_constants::min_min_borrow(), 1);
        assert!(arg2 <= 0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_constants::max_protocol_spread(), 1);
        let v0 = arg0 / 10;
        MarginPoolConfig{
            supply_cap                    : arg0,
            max_utilization_rate          : arg1,
            protocol_spread               : arg2,
            min_borrow                    : arg3,
            rate_limit_capacity           : v0,
            rate_limit_refill_rate_per_ms : v0 / 0x1e349f8d0f89558e6ff240502fcc5ec9caa5103364d3b70995b99a6f7c51ab7a::margin_constants::day_ms(),
            rate_limit_enabled            : false,
        }
    }

    public fun new_margin_pool_config_with_rate_limit(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: bool) : MarginPoolConfig {
        MarginPoolConfig{
            supply_cap                    : arg0,
            max_utilization_rate          : arg1,
            protocol_spread               : arg2,
            min_borrow                    : arg3,
            rate_limit_capacity           : arg4,
            rate_limit_refill_rate_per_ms : arg5,
            rate_limit_enabled            : arg6,
        }
    }

    public fun new_protocol_config(arg0: MarginPoolConfig, arg1: InterestConfig) : ProtocolConfig {
        assert!(arg0.max_utilization_rate >= arg1.optimal_utilization, 1);
        ProtocolConfig{
            margin_pool_config : arg0,
            interest_config    : arg1,
            extra_fields       : 0x2::vec_map::empty<0x1::string::String, u64>(),
        }
    }

    public(friend) fun optimal_utilization(arg0: &ProtocolConfig) : u64 {
        arg0.interest_config.optimal_utilization
    }

    public(friend) fun protocol_spread(arg0: &ProtocolConfig) : u64 {
        arg0.margin_pool_config.protocol_spread
    }

    public(friend) fun rate_limit_capacity(arg0: &ProtocolConfig) : u64 {
        arg0.margin_pool_config.rate_limit_capacity
    }

    public(friend) fun rate_limit_capacity_from_config(arg0: &MarginPoolConfig) : u64 {
        arg0.rate_limit_capacity
    }

    public(friend) fun rate_limit_enabled(arg0: &ProtocolConfig) : bool {
        arg0.margin_pool_config.rate_limit_enabled
    }

    public(friend) fun rate_limit_enabled_from_config(arg0: &MarginPoolConfig) : bool {
        arg0.rate_limit_enabled
    }

    public(friend) fun rate_limit_refill_rate_per_ms(arg0: &ProtocolConfig) : u64 {
        arg0.margin_pool_config.rate_limit_refill_rate_per_ms
    }

    public(friend) fun rate_limit_refill_rate_per_ms_from_config(arg0: &MarginPoolConfig) : u64 {
        arg0.rate_limit_refill_rate_per_ms
    }

    public(friend) fun set_interest_config(arg0: &mut ProtocolConfig, arg1: InterestConfig) {
        assert!(arg0.margin_pool_config.max_utilization_rate >= arg1.optimal_utilization, 1);
        arg0.interest_config = arg1;
    }

    public(friend) fun set_margin_pool_config(arg0: &mut ProtocolConfig, arg1: MarginPoolConfig) {
        assert!(arg1.max_utilization_rate >= arg0.interest_config.optimal_utilization, 1);
        arg0.margin_pool_config = arg1;
    }

    public(friend) fun supply_cap(arg0: &ProtocolConfig) : u64 {
        arg0.margin_pool_config.supply_cap
    }

    // decompiled from Move bytecode v6
}

