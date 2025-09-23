module 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::protocol_config {
    struct ProtocolConfig has copy, drop, store {
        margin_pool_config: MarginPoolConfig,
        interest_config: InterestConfig,
    }

    struct MarginPoolConfig has copy, drop, store {
        supply_cap: u64,
        max_utilization_rate: u64,
        protocol_spread: u64,
        min_borrow: u64,
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

    public(friend) fun excess_slope(arg0: &ProtocolConfig) : u64 {
        arg0.interest_config.excess_slope
    }

    public(friend) fun interest_rate(arg0: &ProtocolConfig, arg1: u64) : u64 {
        let v0 = arg0.interest_config.optimal_utilization;
        if (arg1 < v0) {
            0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::math::mul(arg1, arg0.interest_config.base_slope) + arg0.interest_config.base_rate
        } else {
            arg0.interest_config.base_rate + 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::math::mul(v0, arg0.interest_config.base_slope) + 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::math::mul(arg1 - v0, arg0.interest_config.excess_slope)
        }
    }

    public(friend) fun max_utilization_rate(arg0: &ProtocolConfig) : u64 {
        arg0.margin_pool_config.max_utilization_rate
    }

    public(friend) fun min_borrow(arg0: &ProtocolConfig) : u64 {
        arg0.margin_pool_config.min_borrow
    }

    public fun new_interest_config(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : InterestConfig {
        InterestConfig{
            base_rate           : arg0,
            base_slope          : arg1,
            optimal_utilization : arg2,
            excess_slope        : arg3,
        }
    }

    public fun new_margin_pool_config(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : MarginPoolConfig {
        MarginPoolConfig{
            supply_cap           : arg0,
            max_utilization_rate : arg1,
            protocol_spread      : arg2,
            min_borrow           : arg3,
        }
    }

    public fun new_protocol_config(arg0: MarginPoolConfig, arg1: InterestConfig) : ProtocolConfig {
        ProtocolConfig{
            margin_pool_config : arg0,
            interest_config    : arg1,
        }
    }

    public(friend) fun optimal_utilization(arg0: &ProtocolConfig) : u64 {
        arg0.interest_config.optimal_utilization
    }

    public(friend) fun protocol_spread(arg0: &ProtocolConfig) : u64 {
        arg0.margin_pool_config.protocol_spread
    }

    public(friend) fun set_interest_config(arg0: &mut ProtocolConfig, arg1: InterestConfig) {
        assert!(arg0.margin_pool_config.max_utilization_rate >= arg1.optimal_utilization, 1);
        arg0.interest_config = arg1;
    }

    public(friend) fun set_margin_pool_config(arg0: &mut ProtocolConfig, arg1: MarginPoolConfig) {
        assert!(arg1.protocol_spread <= 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::constants::float_scaling(), 2);
        assert!(arg1.max_utilization_rate <= 0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::constants::float_scaling(), 1);
        assert!(arg1.max_utilization_rate >= arg0.interest_config.optimal_utilization, 1);
        assert!(arg1.min_borrow >= 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_constants::min_min_borrow(), 1);
        arg0.margin_pool_config = arg1;
    }

    public(friend) fun supply_cap(arg0: &ProtocolConfig) : u64 {
        arg0.margin_pool_config.supply_cap
    }

    public(friend) fun time_adjusted_rate(arg0: &ProtocolConfig, arg1: u64, arg2: u64) : u64 {
        0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::math::div(0x81222e1557299effa96b6d5cb9eeef931101ca69b87b03c5d7be772e23e9bcd9::math::mul(arg2, interest_rate(arg0, arg1)), 0xfbd16396208f01d34840b4a0bcd4346ba1fd3542429665f67b6df8552ef9acfd::margin_constants::year_ms())
    }

    // decompiled from Move bytecode v6
}

