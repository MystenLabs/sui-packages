module 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::strike_exposure_config {
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
        let v0 = 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::mul_down(arg1, arg2);
        assert!(v0 >= 1000000, 3);
        v0
    }

    public(friend) fun assert_mint_probability_policy(arg0: &StrikeExposureConfig, arg1: u64) {
        assert!(arg1 >= arg0.min_entry_probability && arg1 <= arg0.max_entry_probability, 0);
    }

    public(friend) fun assert_range_mint_probability_policy(arg0: &StrikeExposureConfig, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::RangePrice) {
        let v0 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::lower_up(arg1);
        if (0x1::option::is_some<u64>(&v0)) {
            assert_mint_probability_policy(arg0, 0x1::option::destroy_some<u64>(v0));
        } else {
            0x1::option::destroy_none<u64>(v0);
        };
        let v1 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::higher_up(arg1);
        if (0x1::option::is_some<u64>(&v1)) {
            assert_mint_probability_policy(arg0, 1000000000 - 0x1::option::destroy_some<u64>(v1));
        } else {
            0x1::option::destroy_none<u64>(v1);
        };
        assert_mint_probability_policy(arg0, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::probability(arg1));
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
        1000000000 + 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::mul_div_down(arg0.expiry_fee_max_multiplier - 1000000000, arg0.expiry_fee_window_ms - arg1, arg0.expiry_fee_window_ms)
    }

    public(friend) fun expiry_fee_window_ms(arg0: &StrikeExposureConfig) : u64 {
        arg0.expiry_fee_window_ms
    }

    public(friend) fun inventory_impact_max_rate(arg0: &StrikeExposureConfig) : u64 {
        arg0.inventory_impact_max_rate
    }

    fun leg_trading_fee(arg0: &StrikeExposureConfig, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::mul_down(0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::mul_down(0x1::u64::max(raw_bernoulli_fee_rate(arg0, arg2), arg0.min_fee), expiry_fee_multiplier(arg0, arg1 - arg4)), arg3)
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
        0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::mul_down(arg0.base_fee, 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::sqrt_down(0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::mul_down(arg1, 1000000000 - arg1)))
    }

    public(friend) fun set_backing_buffer_lambda(arg0: &mut StrikeExposureConfig, arg1: u64) {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_constants::assert_backing_buffer_lambda(arg1);
        arg0.backing_buffer_lambda = arg1;
    }

    public(friend) fun set_base_fee(arg0: &mut StrikeExposureConfig, arg1: u64) {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_constants::assert_base_fee(arg1);
        arg0.base_fee = arg1;
    }

    public(friend) fun set_expiry_fee_max_multiplier(arg0: &mut StrikeExposureConfig, arg1: u64) {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_constants::assert_expiry_fee_max_multiplier(arg1);
        arg0.expiry_fee_max_multiplier = arg1;
    }

    public(friend) fun set_expiry_fee_window_ms(arg0: &mut StrikeExposureConfig, arg1: u64) {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_constants::assert_expiry_fee_window_ms(arg1);
        arg0.expiry_fee_window_ms = arg1;
    }

    public(friend) fun set_inventory_impact_max_rate(arg0: &mut StrikeExposureConfig, arg1: u64) {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_constants::assert_inventory_impact_max_rate(arg1);
        arg0.inventory_impact_max_rate = arg1;
    }

    public(friend) fun set_max_entry_probability(arg0: &mut StrikeExposureConfig, arg1: u64) {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_constants::assert_max_entry_probability(arg1);
        assert!(arg1 > arg0.min_entry_probability, 1);
        arg0.max_entry_probability = arg1;
    }

    public(friend) fun set_min_entry_probability(arg0: &mut StrikeExposureConfig, arg1: u64) {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_constants::assert_min_entry_probability(arg1);
        assert!(arg1 < arg0.max_entry_probability, 1);
        arg0.min_entry_probability = arg1;
    }

    public(friend) fun set_min_fee(arg0: &mut StrikeExposureConfig, arg1: u64) {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_constants::assert_min_fee(arg1);
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

    public(friend) fun trading_fee(arg0: &StrikeExposureConfig, arg1: u64, arg2: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::RangePrice, arg3: u64, arg4: u64) : u64 {
        let v0 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::lower_up(arg2);
        let v1 = if (0x1::option::is_some<u64>(&v0)) {
            0x1::option::some<u64>(leg_trading_fee(arg0, arg1, 0x1::option::destroy_some<u64>(v0), arg3, arg4))
        } else {
            0x1::option::destroy_none<u64>(v0);
            0x1::option::none<u64>()
        };
        let v2 = v1;
        let v3 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::higher_up(arg2);
        let v4 = if (0x1::option::is_some<u64>(&v3)) {
            0x1::option::some<u64>(leg_trading_fee(arg0, arg1, 0x1::option::destroy_some<u64>(v3), arg3, arg4))
        } else {
            0x1::option::destroy_none<u64>(v3);
            0x1::option::none<u64>()
        };
        let v5 = v4;
        0x1::option::get_with_default<u64>(&v2, 0) + 0x1::option::get_with_default<u64>(&v5, 0)
    }

    // decompiled from Move bytecode v7
}

