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

    fun leg_fee(arg0: &StrikeExposureConfig, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        assert!(arg2 <= 1000000000, 2);
        0x19262d18a3ce9f1c304defbacc89f36585152acde73e626231200d10617fb9a7::math::leg_fee(arg0.base_fee, arg0.min_fee, arg0.expiry_fee_window_ms, arg0.expiry_fee_max_multiplier, arg2, arg3, arg1 - arg4)
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

    public(friend) fun expiry_fee_window_ms(arg0: &StrikeExposureConfig) : u64 {
        arg0.expiry_fee_window_ms
    }

    public(friend) fun inventory_impact_max_rate(arg0: &StrikeExposureConfig) : u64 {
        arg0.inventory_impact_max_rate
    }

    public(friend) fun max_prob(arg0: &StrikeExposureConfig) : u64 {
        arg0.max_entry_probability
    }

    public(friend) fun min_fee(arg0: &StrikeExposureConfig) : u64 {
        arg0.min_fee
    }

    public(friend) fun min_prob(arg0: &StrikeExposureConfig) : u64 {
        arg0.min_entry_probability
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

    public(friend) fun prob_ok(arg0: &StrikeExposureConfig, arg1: u64) : bool {
        arg1 >= arg0.min_entry_probability && arg1 <= arg0.max_entry_probability
    }

    public(friend) fun range_ok(arg0: &StrikeExposureConfig, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::RangePrice) : bool {
        let v0 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::lower_up(arg1);
        let v1 = if (0x1::option::is_some<u64>(&v0)) {
            0x1::option::some<bool>(prob_ok(arg0, 0x1::option::destroy_some<u64>(v0)))
        } else {
            0x1::option::destroy_none<u64>(v0);
            0x1::option::none<bool>()
        };
        let v2 = v1;
        if (0x1::option::get_with_default<bool>(&v2, true)) {
            let v4 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::higher_up(arg1);
            let v5 = if (0x1::option::is_some<u64>(&v4)) {
                0x1::option::some<bool>(prob_ok(arg0, 1000000000 - 0x1::option::destroy_some<u64>(v4)))
            } else {
                0x1::option::destroy_none<u64>(v4);
                0x1::option::none<bool>()
            };
            let v6 = v5;
            if (0x1::option::get_with_default<bool>(&v6, true)) {
                prob_ok(arg0, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::probability(arg1))
            } else {
                false
            }
        } else {
            false
        }
    }

    public(friend) fun set_base_fee(arg0: &mut StrikeExposureConfig, arg1: u64) {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_constants::chk_base_fee(arg1);
        arg0.base_fee = arg1;
    }

    public(friend) fun set_fee_mult(arg0: &mut StrikeExposureConfig, arg1: u64) {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_constants::chk_fee_mult(arg1);
        arg0.expiry_fee_max_multiplier = arg1;
    }

    public(friend) fun set_fee_win(arg0: &mut StrikeExposureConfig, arg1: u64) {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_constants::chk_fee_win(arg1);
        arg0.expiry_fee_window_ms = arg1;
    }

    public(friend) fun set_impact(arg0: &mut StrikeExposureConfig, arg1: u64) {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_constants::chk_impact(arg1);
        arg0.inventory_impact_max_rate = arg1;
    }

    public(friend) fun set_lambda(arg0: &mut StrikeExposureConfig, arg1: u64) {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_constants::chk_lambda(arg1);
        arg0.backing_buffer_lambda = arg1;
    }

    public(friend) fun set_max_prob(arg0: &mut StrikeExposureConfig, arg1: u64) {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_constants::chk_max_prob(arg1);
        assert!(arg1 > arg0.min_entry_probability, 1);
        arg0.max_entry_probability = arg1;
    }

    public(friend) fun set_min_fee(arg0: &mut StrikeExposureConfig, arg1: u64) {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_constants::chk_min_fee(arg1);
        arg0.min_fee = arg1;
    }

    public(friend) fun set_min_prob(arg0: &mut StrikeExposureConfig, arg1: u64) {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::config_constants::chk_min_prob(arg1);
        assert!(arg1 < arg0.max_entry_probability, 1);
        arg0.min_entry_probability = arg1;
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
            0x1::option::some<u64>(leg_fee(arg0, arg1, 0x1::option::destroy_some<u64>(v0), arg3, arg4))
        } else {
            0x1::option::destroy_none<u64>(v0);
            0x1::option::none<u64>()
        };
        let v2 = v1;
        let v3 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::higher_up(arg2);
        let v4 = if (0x1::option::is_some<u64>(&v3)) {
            0x1::option::some<u64>(leg_fee(arg0, arg1, 0x1::option::destroy_some<u64>(v3), arg3, arg4))
        } else {
            0x1::option::destroy_none<u64>(v3);
            0x1::option::none<u64>()
        };
        let v5 = v4;
        0x1::option::get_with_default<u64>(&v2, 0) + 0x1::option::get_with_default<u64>(&v5, 0)
    }

    // decompiled from Move bytecode v7
}

