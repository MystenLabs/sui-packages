module 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_calcs {
    public(friend) fun calc_rewards_rate(arg0: u64, arg1: u128, arg2: u64, arg3: u64) : u64 {
        let v0 = 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::math::mul_div((arg0 as u256), (arg1 as u256), (arg2 as u256));
        if (v0 > (arg3 as u256)) {
            arg3
        } else {
            (v0 as u64)
        }
    }

    public fun liquidity_return(arg0: u64, arg1: u64) : u128 {
        assert!(arg1 >= arg0, 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::errors::f_token_liquidity_exchange_price_unexpected());
        0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::math::mul_div_u128(((arg1 - arg0) as u128), 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::constants::return_percent_precision(), (arg0 as u128))
    }

    public fun rewards_return(arg0: u64, arg1: 0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::units::DurationS) : u128 {
        if (0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::units::is_zero(arg1)) {
            return 0
        };
        0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::math::mul_div_u128((arg0 as u128), (0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::units::raw(arg1) as u128), (0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::constants::seconds_per_year() as u128))
    }

    public fun to_assets(arg0: u64, arg1: u64, arg2: bool) : u64 {
        if (arg2) {
            0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::math::mul_div_ceil_u64(arg0, arg1, (0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::constants::exchange_prices_precision() as u64))
        } else {
            0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::math::mul_div_u64(arg0, arg1, (0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::constants::exchange_prices_precision() as u64))
        }
    }

    public fun to_shares(arg0: u64, arg1: u64, arg2: bool) : u64 {
        if (arg2) {
            0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::math::mul_div_ceil_u64(arg0, (0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::constants::exchange_prices_precision() as u64), arg1)
        } else {
            0xdb1caa95193a0bda87e56a9aaf9878672ca8bea7039447e5c789a572a0621969::math::mul_div_u64(arg0, (0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::constants::exchange_prices_precision() as u64), arg1)
        }
    }

    // decompiled from Move bytecode v7
}

