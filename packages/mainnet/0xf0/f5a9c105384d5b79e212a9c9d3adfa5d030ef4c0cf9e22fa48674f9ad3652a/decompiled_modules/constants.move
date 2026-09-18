module 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::constants {
    public(friend) fun billion() : u128 {
        1000000000
    }

    public(friend) fun borrow_fee_precision() : u128 {
        100
    }

    public(friend) fun exchange_price_scale_factor() : u128 {
        1000000000000000000
    }

    public(friend) fun exchange_prices_precision() : u128 {
        1000000000000
    }

    public(friend) fun four_decimals() : u128 {
        10000
    }

    public(friend) fun get_minimum_branch_debt(arg0: u8) : u128 {
        let v0 = if (arg0 >= lower_decimals_operate()) {
            minimum_branch_debt()
        } else {
            minimum_branch_debt_lower_decimals()
        };
        scale_amounts(v0, arg0)
    }

    public(friend) fun get_minimum_debt(arg0: u8) : u128 {
        let v0 = if (arg0 >= lower_decimals_operate()) {
            min_debt()
        } else {
            min_debt_lower_decimals()
        };
        scale_amounts(v0, arg0)
    }

    public(friend) fun get_minimum_tick_debt(arg0: u8) : u128 {
        let v0 = if (arg0 >= lower_decimals_operate()) {
            minimum_tick_debt()
        } else {
            minimum_tick_debt_lower_decimals()
        };
        scale_amounts(v0, arg0)
    }

    public(friend) fun get_scale(arg0: u8) : u128 {
        assert!(arg0 <= max_token_decimals(), 0xf0f5a9c105384d5b79e212a9c9d3adfa5d030ef4c0cf9e22fa48674f9ad3652a::errors::vault_invalid_decimals());
        0x1::u128::pow(10, max_token_decimals() - arg0)
    }

    public(friend) fun initial_branch_debt_factor() : u64 {
        0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::big_number::create_big_number(x35(), 16384)
    }

    public(friend) fun liquidated_position_debt_multiplier() : u128 {
        2
    }

    public(friend) fun lower_decimals_operate() : u8 {
        4
    }

    public(friend) fun max_borrow_fee() : u8 {
        100
    }

    public(friend) fun max_liquidation_penalty() : u16 {
        9970
    }

    public(friend) fun max_liquidation_rounding_diff() : u128 {
        100
    }

    public(friend) fun max_negative_magnifier() : u128 {
        2000
    }

    public(friend) fun max_operate() : u64 {
        9223372036854775807
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

    public(friend) fun max_u32() : u128 {
        4294967295
    }

    public(friend) fun max_u64() : u128 {
        18446744073709551615
    }

    public(friend) fun min_debt() : u128 {
        1000
    }

    public(friend) fun min_debt_lower_decimals() : u128 {
        10
    }

    public(friend) fun min_operate() : u64 {
        1000
    }

    public(friend) fun min_operate_lower_decimals_amount() : u64 {
        10
    }

    public(friend) fun min_oracle_price() : u128 {
        1000000
    }

    public(friend) fun minimum_branch_debt() : u128 {
        100
    }

    public(friend) fun minimum_branch_debt_lower_decimals() : u128 {
        5
    }

    public(friend) fun minimum_tick_debt() : u128 {
        100
    }

    public(friend) fun minimum_tick_debt_lower_decimals() : u128 {
        5
    }

    public(friend) fun rate_output_decimals() : u32 {
        15
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

    public(friend) fun seconds_per_year() : u128 {
        31536000
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

    public(friend) fun vault_t1_type() : u8 {
        1
    }

    public(friend) fun version() : u64 {
        1
    }

    public(friend) fun x10() : u128 {
        1023
    }

    public(friend) fun x30() : u128 {
        1073741823
    }

    public(friend) fun x35() : u64 {
        34359738367
    }

    // decompiled from Move bytecode v7
}

