module 0x96613db94a8fd0cf5091b20975387bd618d9e71ff77f5e5940ab80eb72aab82c::constants {
    public(friend) fun billion() : u128 {
        1000000000
    }

    public(friend) fun exchange_prices_precision() : u128 {
        1000000000000
    }

    public(friend) fun four_decimals() : u128 {
        10000
    }

    public(friend) fun get_minimum_branch_debt(arg0: u8) : u128 {
        let v0 = if (arg0 >= lower_decimals_operate()) {
            100
        } else {
            5
        };
        scale_amounts(v0, arg0)
    }

    public(friend) fun get_minimum_debt(arg0: u8) : u128 {
        let v0 = if (arg0 >= lower_decimals_operate()) {
            1000
        } else {
            10
        };
        scale_amounts(v0, arg0)
    }

    public(friend) fun get_scale(arg0: u8) : u128 {
        assert!(arg0 <= max_token_decimals(), 0x96613db94a8fd0cf5091b20975387bd618d9e71ff77f5e5940ab80eb72aab82c::errors::invalid_decimals());
        0x1::u128::pow(10, max_token_decimals() - arg0)
    }

    public(friend) fun lower_decimals_operate() : u8 {
        4
    }

    public(friend) fun max_absorb_iterations() : u64 {
        600
    }

    public(friend) fun max_liquidation_rounding_diff() : u128 {
        100
    }

    public(friend) fun max_oracle_price() : u128 {
        1000000000000000000000000
    }

    public(friend) fun max_oracle_price_after_ex_price() : u128 {
        46000000000000000000000000
    }

    public(friend) fun max_token_decimals() : u8 {
        9
    }

    public(friend) fun rate_output_precision() : u128 {
        1000000000000000
    }

    public(friend) fun rate_output_precision_squared() : u128 {
        1000000000000000000000000000000
    }

    public(friend) fun scale_amounts(arg0: u128, arg1: u8) : u128 {
        arg0 * get_scale(arg1)
    }

    public(friend) fun three_decimals() : u128 {
        1000
    }

    public(friend) fun unscale_amounts(arg0: u128, arg1: u8) : u128 {
        arg0 / get_scale(arg1)
    }

    public(friend) fun unscale_amounts_up(arg0: u128, arg1: u8) : u128 {
        0x1::u128::div_ceil(arg0, get_scale(arg1))
    }

    public(friend) fun x30() : u128 {
        1073741823
    }

    // decompiled from Move bytecode v7
}

