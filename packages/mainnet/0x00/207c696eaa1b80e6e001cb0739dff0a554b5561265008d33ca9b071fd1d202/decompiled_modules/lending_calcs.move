module 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::lending_calcs {
    public(friend) fun calc_rewards_rate(arg0: u64, arg1: u128, arg2: u64, arg3: u64) : u64 {
        let v0 = 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::mul_div((arg0 as u256), (arg1 as u256), (arg2 as u256));
        if (v0 > (arg3 as u256)) {
            arg3
        } else {
            (v0 as u64)
        }
    }

    public fun liquidity_return(arg0: u64, arg1: u64) : u128 {
        assert!(arg1 >= arg0, 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::errors::f_token_liquidity_exchange_price_unexpected());
        0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::mul_div_u128(((arg1 - arg0) as u128), 0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::constants::return_percent_precision(), (arg0 as u128))
    }

    public fun rewards_return(arg0: u64, arg1: 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::DurationS) : u128 {
        if (0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::is_zero(arg1)) {
            return 0
        };
        0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::mul_div_u128((arg0 as u128), (0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::raw(arg1) as u128), (0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::constants::seconds_per_year() as u128))
    }

    public fun to_assets(arg0: u64, arg1: u64, arg2: bool) : u64 {
        if (arg2) {
            0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::mul_div_ceil_u64(arg0, arg1, (0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::constants::exchange_prices_precision() as u64))
        } else {
            0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::mul_div_u64(arg0, arg1, (0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::constants::exchange_prices_precision() as u64))
        }
    }

    public fun to_shares(arg0: u64, arg1: u64, arg2: bool) : u64 {
        if (arg2) {
            0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::mul_div_ceil_u64(arg0, (0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::constants::exchange_prices_precision() as u64), arg1)
        } else {
            0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::mul_div_u64(arg0, (0x207c696eaa1b80e6e001cb0739dff0a554b5561265008d33ca9b071fd1d202::constants::exchange_prices_precision() as u64), arg1)
        }
    }

    // decompiled from Move bytecode v7
}

